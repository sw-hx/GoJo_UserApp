import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_jo_user_application/cubits/signIn_cubit/sign_in_cubit.dart';
import 'package:go_jo_user_application/hala_all/startingUP_screens_H/login_screen_hala/welcome_screen.dart';
import 'package:go_jo_user_application/pages/home_page.dart';
import '../../../common_components/custom_progress_hud.dart';
import '../../../common_components/custom_returnArrow.dart';
import '../../../common_components/custom_snackbar.dart';
import '../../../domain/repos/auth_repo.dart';
import '../../../services/git_it_service.dart';
import 'forgot_password_screen.dart';
import 'signup_screen.dart';

/// # coded By [Hala]

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

/// # coded By [Hala]

class _LoginScreenState extends State<LoginScreen> {
  late String email,password;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscurePassword = true;

  /// # coded By [Hala]

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => SignInCubit(
    authRepo:getIt<AuthRepo>(),
  ),
  child: Scaffold(
      backgroundColor: Colors.white,
      body: Builder(
        builder: (context) {
          return BlocConsumer<SignInCubit, SignInState>(
            listener: (context, state) {
              if(state is SignInSuccess){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()));
              }
              if(state is SignInFailure){
          CustomSnackBar.show(context: context, message: state.message.substring(11));


              }
            },
            builder: (context, state) {
              return CustomProgressHud(
                inAsyncCall: state is SignInLoading,
                child: Form(
                  key: formKey,
                  child: Padding(
                              padding: const EdgeInsets.all(30),
                              child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text('GOJO',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                  color: Color(0xFF3D7C91),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: const CustomReturnArrow(targetPage: WelcomeScreen(),),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Center(
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize:40,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0B3C49),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Center(
                        child: Text(
                          "Hi,Welcome back !",
                          style: TextStyle(color: Color(0xFF3D7C91), fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 40),
                      const Text("Email", style: TextStyle(color: Color(0xFF3D7C91), fontSize: 22,fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return "Email is required";
                          }
                          return null;
                        },
                        onSaved: (value){
                          email = value!;
                        },

                        controller: emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(60),borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Password",
                        style: TextStyle(color: Color(0xFF3D7C91), fontSize: 22,fontWeight: FontWeight.bold),
                      ),
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          TextFormField(
                            validator: (value){
                              if(value!.isEmpty){
                                return "Password is required";
                              }
                              return null;
                            },
                            onSaved: (value){
                              password = value!;
                            },
                            controller: passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(60),borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Color(0xFF3D7C91),
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ForgotPasswordScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Forgot password?",
                              style: TextStyle(color: Color(0xFF3D7C91), fontSize: 15),),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF3D7C91),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 80,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          onPressed: (){
                            if(formKey.currentState!.validate()){
                              formKey.currentState!.save();
                              context.read<SignInCubit>().signInWithEmailAndPassword(email: email, password: password);

                            }
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don’t have an account?",
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const SignUpScreen()),
                              ),
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(color: Color(0xFF3D7C91),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                              ),
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
}
