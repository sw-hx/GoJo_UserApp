import 'package:flutter/material.dart';
import 'package:go_jo_user_application/pages/profile_page.dart';
import '../../common_components/bottom_nav_bar.dart';
import '../../common_components/custom_returnArrow.dart';
import 'bugs_thank_page.dart';


/// Coded by[Hala]

class BugsReportScreen extends StatefulWidget {
  const BugsReportScreen({super.key});

  @override
  State<BugsReportScreen> createState() => _BugsReportScreenState();
}

class _BugsReportScreenState extends State<BugsReportScreen> {
  String selectedIssue = "";
  String selectedPriority = "";

  final TextEditingController descriptionController = TextEditingController();

  final List<String> issueTypes = [
    "Functionality Issues",
    "Performance Issues",
    "Crash/Error Issues",
    "Data/Content Issues",
    "Other",];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                const CustomReturnArrow(targetPage: ProfilePage(),),
                const SizedBox(height:20),

                // Title
                Row(
                  children: const [Icon(Icons.support_agent_rounded,
                      color: Color.fromRGBO(18, 54, 69, 1),
                      size: 40),
                    SizedBox(width: 10),
                    Text(
                      "Bugs Center",
                      style: TextStyle(
                          color: Color.fromRGBO(18, 54, 69, 1),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height:40),

                const Text(
                  "Reason for reporting this bug?",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10),// Select issue type
                SizedBox(
                  height: 45,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
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
                                ?  Color(0xff2F7898)
                              :    Color(0xFFD0D0D0),
                          borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(issue,
                              style: TextStyle(
                                color:
                                isSelected ? Colors.white : Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemCount: issueTypes.length,
                  ),
                ),

                const SizedBox(height: 25),
                const Text(
                  "Can you provide clarity on the issue?",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                const SizedBox(height: 10),// Description box
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: descriptionController,
                    maxLines: null,
                    expands: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Describe the problem here...",
                    ),
                  ),
                ),const SizedBox(height: 25),
                const Text(
                  "Bug priority",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                const SizedBox(height: 10),

                // Priority buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildPriorityButton("High priority", Colors.red),
                    _buildPriorityButton("Medium priority", Colors.orange),
                    _buildPriorityButton("Low priority", Colors.green),
                  ],
                ),

                const SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const BugsThankYouScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:Colors.grey.shade200,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),child: const Text(
                      "Cancel",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    ),

                    //////////////////////
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ProfilePage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff2F7898),
                      padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      ),child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 16, color: Colors.white),
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
  }

  Widget _buildPriorityButton(String label, Color color) {
    bool isSelected = selectedPriority == label;
    return GestureDetector(onTap: () => setState(() => selectedPriority = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: color, width: 2),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}