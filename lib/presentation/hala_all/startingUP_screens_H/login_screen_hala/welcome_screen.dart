import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/repos/auth_repo.dart';
import '../../../../services/git_it_service.dart';
import '../../../common_components/custom_progress_hud.dart';
import '../../../common_components/custom_snackbar.dart';
import '../../../cubits/signIn_cubit/sign_in_cubit.dart';
import '../../../mohamad/components/logo.dart';
import '../../../pages/home_page.dart';
import 'signup_screen.dart';
import 'sign_in_screen.dart';

/// # coded By [Hala]

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
  create: (context) => SignInCubit(
    authRepo:getIt<AuthRepo>(),
  ),
  child: Scaffold(
      body: Builder(
        builder: (context) {
          return BlocConsumer<SignInCubit, SignInState>(
            listener: (context, state) {

              if(state is SignInSuccess){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                );
                CustomSnackBar.show(context: context, message: "success");
              }
              if(state is SignInFailure){
                CustomSnackBar.show(context: context, message: state.message.substring(11));
              }
            },
            builder: (context, state) {
              return CustomProgressHud(
                inAsyncCall: state is SignInLoading,
                child: SafeArea(
                            child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Logo(
                                logoHight: screenHeight * 0.1,
                                logoWidth: screenWidth * 0.2,
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: const Text(
                                "Discover",
                                style: TextStyle(
                                  fontSize: 88,
                                  color: Color(0xFF0B3C49),
                                  height: 1.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              "Let’s get started !",
                              style: TextStyle(
                                fontSize: 22,
                                color: Color(0xFF3D7C91),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 25),
                              decoration: BoxDecoration(
                                color: const Color(0xFF3D7C91),
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(1, 2),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                    decoration: BoxDecoration(
                                      color:  const Color(0xFF6A1B2D),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),

                                      ),
                                      child: Column(
                                        children: [
                                          const Text(
                                            "Coming Soon",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                              letterSpacing: 1,
                                              shadows: [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  offset: Offset(1, 2),
                                                  blurRadius: 4,
                                                ),
                                              ]
                                            ),
                                          ),
                                          SizedBox(height: 8,),
                                          const Text(
                                            "Continue with",
                                            style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              shadows: [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  offset: Offset(1, 2),
                                                  blurRadius: 4,
                                                ),
                                              ]
                                            ),
                                          ),
                                          const SizedBox(height: 25),

                                          _buildWhiteButton(
                                            imagePath: "assets/images/google.jpg",
                                            text: "Continue with Google",
                                            onTap: () {

                                              //context.read<SignInCubit>().signInWithGoogle();

                                            },
                                          ),
                                          const SizedBox(height: 14),

                                          _buildWhiteButton(
                                            imagePath:
                                            "assets/images/2023_Facebook_icon.svg.png",
                                            text: "Continue with Facebook",
                                            onTap: () {
                                              //context.read<SignInCubit>().signInWithFacebook();

                                            },
                                          ),
                                          const SizedBox(height: 6),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 25),

                                  const Text(
                                    "or",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          elevation: 0,
                                          padding: const EdgeInsets.symmetric(vertical: 16),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (_) => const SignUpScreen()),
                                          );
                                        },
                                        child: const Text(
                                            "Create GOJO account",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                            ),
                                            ),
                                        ),
                                  ),

                                ],
                              ),
                            ),

                            const SizedBox(height: 20),

                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const LoginScreen()),
                                );
                              },
                              child: const Text(
                                "Already i have an account",
                                style: TextStyle(
                                  color: Color(0xFF3D7C91),
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.03),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                            ),
                          ),
              );
            },
          );
        }
      ),
    ),
);
  }

  Widget _buildWhiteButton({
    required String imagePath,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(1, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: Row(
              children: [
                Image.asset(
                  imagePath,
                  height: 35,
                  width: 35,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
              ),
          ),
    );
    }
}
