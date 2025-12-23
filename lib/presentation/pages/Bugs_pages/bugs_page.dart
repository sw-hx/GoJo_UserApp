import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../common_components/bottom_nav_bar.dart';
import '../../common_components/custom_returnArrow.dart';
import '../../components/components_bug_center/rectangle_image_text_field.dart';
import '../../cubits/create_ticket_cubit/create_ticket_cubit.dart';
import '../profile_page.dart';
import 'bugs_thank_page.dart';

class BugsReportScreen extends StatefulWidget {
  const BugsReportScreen({
    super.key,
    required this.username,
    required this.name,
  });

  final String username;
  final String name;

  @override
  State<BugsReportScreen> createState() => _BugsReportScreenState();
}

class _BugsReportScreenState extends State<BugsReportScreen> {
  String selectedIssue = "FUNCTIONALITY_ISSUE";
  String selectedPriority = "MEDIUM_PRIORITY";

  File? selectedImage;
  final TextEditingController descriptionController = TextEditingController();

  final List<String> issueTypes = [
    "FUNCTIONALITY_ISSUE",
    "PERFORMANCE_ISSUE",
    "CRASH_ERROR_ISSUE",
    "DATA_CONTENT_ISSUE",
    "OTHER",
  ];

  String formatLabel(String value) {
    return value
        .toLowerCase()
        .replaceAll('_', ' ')
        .split(' ')
        .map((e) => e[0].toUpperCase() + e.substring(1))
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateTicketCubit, CreateTicketState>(
      listener: (context, state) {
        if (state is CreateTicketSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => BugsThankYouScreen(name: widget.name),
            ),
          );
        }

        if (state is CreateTicketFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final bool isLoading = state is CreateTicketLoading;

        return Scaffold(
          body: ModalProgressHUD(
            inAsyncCall: isLoading,
            dismissible: false,
            child: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomReturnArrow(targetPage: ProfilePage()),
                    SizedBox(height: 5.h),

                    Row(
                      children: [
                        Icon(
                          Icons.support_agent_rounded,
                          color: const Color.fromRGBO(18, 54, 69, 1),
                          size: 40.sp,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          "Bugs Center",
                          style: TextStyle(
                            color: const Color.fromRGBO(18, 54, 69, 1),
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 25.h),

                    /// ================= ISSUE TYPE =================
                    Text(
                      "Reason for reporting this bug?",
                      style: TextStyle(fontSize: 15.sp),
                    ),
                    SizedBox(height: 10.h),

                    SizedBox(
                      height: 45.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: issueTypes.length,
                        separatorBuilder: (_, __) =>
                            SizedBox(width: 8.w),
                        itemBuilder: (context, index) {
                          final issue = issueTypes[index];
                          final isSelected = issue == selectedIssue;

                          return GestureDetector(
                            onTap: () =>
                                setState(() => selectedIssue = issue),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.w,
                                vertical: 10.h,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xff2F7898)
                                    : const Color(0xFFD0D0D0),
                                borderRadius:
                                BorderRadius.circular(20.r),
                              ),
                              child: Center(
                                child: Text(
                                  formatLabel(issue),
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 25.h),

                    /// ================= DESCRIPTION =================
                    Text(
                      "Can you provide clarity on the issue?",
                      style: TextStyle(fontSize: 15.sp),
                    ),
                    SizedBox(height: 10.h),

                    Container(
                      height: 160.h,
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15.r),
                          bottomLeft: Radius.circular(15.r),
                          bottomRight: Radius.circular(15.r),
                        ),
                      ),
                      child: TextField(
                        controller: descriptionController,
                        maxLines: null,
                        expands: true,
                        style: TextStyle(fontSize: 14.sp),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Describe the problem here...",
                        ),
                      ),
                    ),

                    SizedBox(height: 25.h),

                    /// ================= IMAGE =================
                    Text(
                      "Add screenshot (optional)",
                      style: TextStyle(fontSize: 15.sp),
                    ),
                    SizedBox(height: 10.h),

                    Center(
                      child: RectangleImageTextField(
                        image: selectedImage,
                        onChanged: (file) {
                          setState(() => selectedImage = file);
                        },
                      ),
                    ),

                    SizedBox(height: 25.h),

                    /// ================= PRIORITY =================
                    Text(
                      "Bug priority",
                      style: TextStyle(fontSize: 15.sp),
                    ),
                    SizedBox(height: 10.h),

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        _priorityButton(
                            "HIGH_PRIORITY", Colors.red),
                        _priorityButton(
                            "MEDIUM_PRIORITY", Colors.orange),
                        _priorityButton(
                            "LOW_PRIORITY", Colors.green),
                      ],
                    ),

                    SizedBox(height: 80.h),

                    /// ================= ACTIONS =================
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            Colors.grey.shade200,
                            padding: EdgeInsets.symmetric(
                              horizontal: 40.w,
                              vertical: 10.h,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(50.r),
                            ),
                          ),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                            final message =
                            descriptionController
                                .text
                                .trim();

                            if (message.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Please describe the problem before submitting"),
                                ),
                              );
                              return;
                            }

                            context
                                .read<CreateTicketCubit>()
                                .createTicket(
                              data: {
                                "message": message,
                                "priority": selectedPriority,
                                "tag": selectedIssue,
                              },
                              image: selectedImage,
                              username: widget.username,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            const Color(0xff2F7898),
                            padding: EdgeInsets.symmetric(
                              horizontal: 40.w,
                              vertical: 10.h,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(50.r),
                            ),
                          ),
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: const BottomNavBar(),
        );
      },
    );
  }

  Widget _priorityButton(String value, Color color) {
    final bool isSelected = selectedPriority == value;

    return GestureDetector(
      onTap: () => setState(() => selectedPriority = value),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.white,
          borderRadius: BorderRadius.circular(50.r),
          border: Border.all(color: color, width: 2.w),
        ),
        child: Text(
          formatLabel(value),
          style: TextStyle(
            fontSize: 13.sp,
            color: isSelected ? Colors.black : color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
