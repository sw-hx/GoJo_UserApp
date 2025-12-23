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

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  late String name, email, password, username;

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

  /// ---------------- USERNAME RULES ----------------
  void _showNameRules() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF3D7C91),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (_) => const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Username must contain",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text("- Lowercase letters only",
                style: TextStyle(color: Colors.white, fontSize: 22)),
            Text("- Underscore (_) allowed",
                style: TextStyle(color: Colors.white, fontSize: 22)),
            Text("- No spaces",
                style: TextStyle(color: Colors.white, fontSize: 22)),
          ],
        ),
      ),
    );
  }

  /// ---------------- PASSWORD RULES ----------------
  void _showPasswordRules() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF3D7C91),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (_) => const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Password must contain",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text("- At least 6 characters",
                style: TextStyle(color: Colors.white, fontSize: 22)),
            Text("- One uppercase letter",
                style: TextStyle(color: Colors.white, fontSize: 22)),
            Text("- One number or symbol",
                style: TextStyle(color: Colors.white, fontSize: 22)),
            Text("- No spaces",
                style: TextStyle(color: Colors.white, fontSize: 22)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpCubit(authRepo: getIt<AuthRepo>()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state is SignUpSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => SuccessScreen(username: name),
                ),
              );
            }
            if (state is SignUpFailure) {
              CustomSnackBar.show(
                context: context,
                message: state.message.substring(11),
              );
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

                      const Text(
                        'GOJO',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3D7C91),
                        ),
                      ),
                      const CustomReturnArrow(
                        targetPage: WelcomeScreen(),
                      ),

                      const Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0B3C49),
                          ),
                        ),
                      ),
                      const Center(
                        child: Text(
                          "Ready to Discover?",
                          style: TextStyle(
                            color: Color(0xFF3D7C91),
                            fontSize: 20,
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      _buildLabel("Name"),
                      _buildInput(
                        controller: nameController,
                        onSaved: (v) => name = v!,
                      ),

                      const SizedBox(height: 20),

                      _buildLabel("Email"),
                      _buildInput(
                        controller: emailController,
                        onSaved: (v) => email = v!,
                      ),

                      const SizedBox(height: 20),

                      _buildLabelWithInfo(
                        "Username",
                        onInfoTap: _showNameRules,
                      ),
                      _buildInput(
                        onSaved: (v) => username = v!,
                      ),

                      const SizedBox(height: 20),

                      _buildLabel("Password"),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(60), // نعومة الأطراف
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            TextFormField(
                              controller: passwordController,
                              obscureText: _obscurePassword,
                              onChanged: (_) => _checkPasswords(),
                              validator: (v) =>
                              v!.isEmpty ? 'Field is required' : null,
                              onSaved: (v) => password = v!,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200], // 👈 اللون المطلوب
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 18,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: const Color(0xff2F7898),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                                const Text("/"),
                                IconButton(
                                  icon: const Icon(Icons.info_outline),
                                  color: const Color(0xff2F7898),
                                  onPressed: _showPasswordRules,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),



                      const SizedBox(height: 20),

                      _buildLabel("Confirm Password"),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: TextFormField(
                          controller: confirmPasswordController,
                          obscureText: _obscureConfirm,
                          onChanged: (_) => _checkPasswords(),
                          validator: (v) =>
                          v!.isEmpty ? 'Field is required' : null,
                          decoration: _inputDecoration(),
                        ),
                      ),


                      const SizedBox(height: 40),

                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff2F7898),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 80,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          onPressed: () {
                            if (!_passwordsMatch) {
                              CustomSnackBar.show(
                                context: context,
                                message: "Passwords do not match",
                              );
                              return;
                            }
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              context
                                  .read<SignUpCubit>()
                                  .createUserWithEmailAndPassword(
                                email: email,
                                password: password,
                                name: name,
                                username: username,
                              );
                            }
                          },
                          child: const Text(
                            "Confirm",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const WelcomeScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Already I have an account",
                            style: TextStyle(
                              color: Color(0xFF3D7C91),
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// ---------------- UI HELPERS ----------------

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 22,
        color: Color(0xFF3D7C91),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildLabelWithInfo(String text,
      {required VoidCallback onInfoTap}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildLabel(text),
        const SizedBox(width: 6),
        GestureDetector(
          onTap: onInfoTap,
          child: const Icon(
            Icons.info_outline,
            color: Color(0xff2F7898),
          ),
        ),
      ],
    );
  }
  Widget _buildInput({
    TextEditingController? controller,
    required void Function(String?) onSaved,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(60),
      child: TextFormField(
        controller: controller,
        validator: (v) => v!.isEmpty ? 'Field is required' : null,
        onSaved: onSaved,
        decoration: _inputDecoration(),
      ),
    );
  }


  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey[200],
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
    );
  }



}
