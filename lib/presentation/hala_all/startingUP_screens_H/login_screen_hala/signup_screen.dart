import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/repos/auth_repo.dart';
import '../../../../services/git_it_service.dart';
import '../../../common_components/custom_returnArrow.dart';
import '../../../common_components/custom_snackbar.dart';
import '../../../cubits/signUp_cubit/sign_up_cubit.dart';
import 'success_screen.dart';
import 'welcome_screen.dart';

/// coded by [Hala]

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

/// coded by [Hala]

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late String name,email,password;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _passwordsMatch = true;

  void _checkPasswords() {
    setState(() {
      _passwordsMatch =
          passwordController.text == confirmPasswordController.text;
    });
  }

  void _showPasswordRules() {
    showModalBottomSheet(
      context: context,
      backgroundColor:  Color(0xFF3D7C91),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              "Password must contain",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,fontSize:28,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "- At least 8 characters",
              style: TextStyle(color: Colors.white,fontSize: 22),
            ),
            Text(
              "- At least one uppercase letter",
              style: TextStyle(color: Colors.white,fontSize: 22),
            ),
            Text(
              "- One number or special symbol",
              style: TextStyle(color: Colors.white,fontSize: 22),
            ),
            Text("- No spaces", style: TextStyle(color: Colors.white,fontSize: 22)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => SignUpCubit(
      authRepo:getIt<AuthRepo>()
  ),
  child: Scaffold(
      backgroundColor: Colors.white,
      body: Builder(
        builder: (context) {
          return BlocConsumer<SignUpCubit, SignUpState>(
            listener: (context, state) {
              if(state is SignUpSuccess){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SuccessScreen(username: name,)));
              }
              if(state is SignUpFailure){
          CustomSnackBar.show(context: context, message: state.message.substring(11));
              }
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Padding(
                            padding: const EdgeInsets.all(25),
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
                    const Center(
                      child: Text(
                        "Sign Up",
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
                        "Ready to Discover?",
                        style: TextStyle(color: Color(0xFF3D7C91), fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 20),

                    _buildLabel("Name"),
                    _buildInput(onSaved: (value){
                      name = value!;

                    }),

                    const SizedBox(height: 20),
                    _buildLabel("Email"),
                    _buildInput(onSaved: (value){
                      email = value!;
                    }),

                    const SizedBox(height: 20),
                    _buildLabel("Password"),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        TextFormField(
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Field is required';
                            }
                            return null;
                          },
                          onSaved: (value){
                            password = value!;
                          },
                          controller: passwordController,
                          obscureText: _obscurePassword,
                          onChanged: (_) => _checkPasswords(),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(60),borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                size: 30,
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Color(0xff2F7898),
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            const Text('/',style: TextStyle(color: Colors.black, fontSize: 30),),
                            IconButton(
                              icon: const Icon(
                                size: 30,
                                Icons.info_outline,
                                color: Color(0xff2F7898),
                              ),
                              onPressed: _showPasswordRules,
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    _buildLabel("Confirm Password"),
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Field is required';
                        }
                        return null;
                      },
                      controller: confirmPasswordController,
                      obscureText: _obscureConfirm,
                      onChanged: (_) => _checkPasswords(),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60),
                          borderSide: BorderSide(
                            color: _passwordsMatch ? Colors.transparent : Colors.red,
                            width: 2,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff2F7898),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 80,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: () {
                          if (_passwordsMatch) {
                            if(_formKey.currentState!.validate()){
                              _formKey.currentState!.save();
                              context.read<SignUpCubit>().createUserWithEmailAndPassword(email: email, password: password, name: name);
                            }
                          }
                          else{
                            CustomSnackBar.show(context:context,message:  "Passwords do not match");

                          }
                        },
                        child: const Text(
                          "Confirm",
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  //  const SizedBox(height: 15),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                          );
                        },
                        child: const Text(
                          "Already I have an account",
                          style: TextStyle(color: Color(0xFF3D7C91),fontSize: 18),
                        ),
                      ),
                    ),
                  ],
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

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize:22,
        color: Color(0xFF3D7C91),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildInput({required void Function(String?) onSaved }) {
    return TextFormField(
      validator: (value){
        if(value!.isEmpty){
          return 'Field is required';
        }
        return null;
      },
      onSaved: onSaved,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(60),borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
