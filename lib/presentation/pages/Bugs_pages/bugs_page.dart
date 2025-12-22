import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../common_components/bottom_nav_bar.dart';
import '../../common_components/custom_returnArrow.dart';
import '../../components/components_bug_center/rectangle_image_text_field.dart';
import '../../cubits/create_ticket_cubit/create_ticket_cubit.dart';
import '../profile_page.dart';
import 'bugs_thank_page.dart';

class BugsReportScreen extends StatefulWidget {
  const BugsReportScreen({super.key, required this.username, required this.name});
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
              builder: (_) =>  BugsThankYouScreen(
                name: widget.name,
              ),
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
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomReturnArrow(targetPage: ProfilePage()),
                      const SizedBox(height: 20),

                      Row(
                        children: const [
                          Icon(
                            Icons.support_agent_rounded,
                            color: Color.fromRGBO(18, 54, 69, 1),
                            size: 40,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Bugs Center",
                            style: TextStyle(
                              color: Color.fromRGBO(18, 54, 69, 1),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),

                      const Text(
                        "Reason for reporting this bug?",
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 10),

                      SizedBox(
                        height: 45,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: issueTypes.length,
                          separatorBuilder: (_, __) =>
                          const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            final issue = issueTypes[index];
                            final isSelected = issue == selectedIssue;

                            return GestureDetector(
                              onTap: () {
                                setState(() => selectedIssue = issue);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xff2F7898)
                                      : const Color(0xFFD0D0D0),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    formatLabel(issue),
                                    style: TextStyle(
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

                      const SizedBox(height: 25),

                      const Text(
                        "Can you provide clarity on the issue?",
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 10),

                      Container(
                        height: 160,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        child: TextField(
                          controller: descriptionController,
                          maxLines: null,
                          expands: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Describe the problem here...",
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      const Text(
                        "Add screenshot (optional)",
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 10),

                      Center(
                        child: RectangleImageTextField(
                          image: selectedImage,
                          onChanged: (file) {
                            setState(() => selectedImage = file);
                          },
                        ),
                      ),

                      const SizedBox(height: 25),

                      const Text(
                        "Bug priority",
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _priorityButton("HIGH_PRIORITY", Colors.red),
                          _priorityButton("MEDIUM_PRIORITY", Colors.orange),
                          _priorityButton("LOW_PRIORITY", Colors.green),
                        ],
                      ),

                      const SizedBox(height: 100),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed:
                            isLoading ? null : () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade200,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black),
                            ),
                          ),
                          ElevatedButton(

                            onPressed: isLoading
                                ? null
                                : () {
                              final message = descriptionController.text.trim();

                              if (message.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Please describe the problem before submitting"),
                                  ),
                                );
                                return;
                              }

                              context.read<CreateTicketCubit>().createTicket(
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
                              backgroundColor: const Color(0xff2F7898),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: const Text(
                              "Submit",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: color, width: 2),
        ),
        child: Text(
          formatLabel(value),
          style: TextStyle(
            color: isSelected ? Colors.black : color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
