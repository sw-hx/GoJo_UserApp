import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../core/helpers/getUser.dart';
import '../../data/models/user_model.dart';
import '../cubits/edit_profile_cubit/edit_profile_cubit.dart';
import '../common_components/bottom_nav_bar.dart';
import '../components/components_edit_profile/edit_profile_bottom_sheet.dart';
import '../hala_all/startingUP_screens_H/login_screen_hala/welcome_screen.dart';
import '../common_components/custom_returnArrow.dart';
import 'Bugs_pages/bugs_page.dart';
import 'home_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool allowNotifications = false;

  UserModel? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    user = await getUserData();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (user == null) {
      return const WelcomeScreen();
    }

    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) async {
        if (state is EditProfileSuccess) {
          print(state.updatedUser);

          user = user!.copyWith(
            personFullName: state.updatedUser['personFullName'],
            profilePhoto: state.updatedUser['profileImageLink'],
          );

          await saveUserData(user!);

          setState(() {});


        }


        if (state is EditProfileFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
          throw Exception(state.message);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is EditProfileLoading,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: const CustomReturnArrow(targetPage: HomePage()),
                    ),
                    const SizedBox(height: 10),

                    CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: user!.profilePhoto != null &&
                          user!.profilePhoto!.isNotEmpty
                          ? (user!.profilePhoto!.startsWith('http')
                          ? NetworkImage(user!.profilePhoto!)
                          : FileImage(File(user!.profilePhoto!))
                      as ImageProvider)
                          : null,
                      child: user!.profilePhoto == null ||
                          user!.profilePhoto!.isEmpty
                          ? Text(
                        user!.personFullName.isNotEmpty
                            ? user!.personFullName[0].toUpperCase()
                            : "?",
                        style: const TextStyle(fontSize: 50),
                      )
                          : null,
                    ),

                    const SizedBox(height: 15),

                    Text(
                      user!.personFullName,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(18, 54, 69, 1),
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      user!.email,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.blueGrey,
                        decoration: TextDecoration.underline,
                      ),
                    ),

                    const SizedBox(height: 10),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25)),
                          ),
                          builder: (_) => EditProfileBottomSheet(
                            user: user!,
                            onSave: (newName, newImage) {
                              context.read<EditProfileCubit>().editProfile(
                                username: user!.username,
                                fullName: newName,
                                newImage: newImage,
                              );
                            },
                          ),
                        );
                      },
                      child: const Text(
                        "Edit profile",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),

                    const SizedBox(height: 25),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border:
                        const Border.fromBorderSide(BorderSide(width: .5)),
                        color: const Color(0xFFF6F6F6),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Name",
                              style: TextStyle(color: Colors.black54)),
                          const SizedBox(height: 5),
                          Text(
                            user!.personFullName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const Divider(height: 25),
                          const Text("Email",
                              style: TextStyle(color: Colors.black54)),
                          const SizedBox(height: 5),
                          Text(
                            user!.email,
                            style: const TextStyle(
                              color: Colors.blueGrey,
                              decoration: TextDecoration.underline,
                              fontSize: 16,
                            ),
                          ),
                          const Divider(height: 25),
                          const Text("User Name",
                              style: TextStyle(color: Colors.black54)),
                          const SizedBox(height: 5),
                          Text(
                            user!.username,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Preferences",
                        style:
                        TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6F6F6),
                        border:
                        const Border.fromBorderSide(BorderSide(width: .5)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(
                              Icons.notifications_none_rounded,
                              color: Color.fromRGBO(18, 54, 69, 1),
                              size: 30,
                            ),
                            title: const Text(
                              "Allow notifications",
                              style: TextStyle(fontSize: 16),
                            ),
                            trailing: Switch(
                              activeThumbColor:
                              const Color.fromRGBO(28, 176, 5, 1.0),
                              value: allowNotifications,
                              onChanged: (val) =>
                                  setState(() => allowNotifications = val),
                            ),
                          ),
                          const Divider(height: 1),
                          ListTile(
                            leading: const Icon(
                              Icons.support_agent_rounded,
                              color: Colors.black87,
                              size: 30,
                            ),
                            title: const Text(
                              "Bugs center",
                              style: TextStyle(fontSize: 16),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                  const BugsReportScreen(),
                                ),
                              );
                            },
                          ),
                          const Divider(height: 1),
                          ListTile(
                            leading: const Icon(
                              Icons.logout_rounded,
                              color: Colors.red,
                              size: 30,
                            ),
                            title: const Text(
                              "Logout",
                              style: TextStyle(
                                  color: Colors.red, fontSize: 16),
                            ),
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                  const WelcomeScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: const BottomNavBar(),
          ),
        );
      },
    );
  }
}
