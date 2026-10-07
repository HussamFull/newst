/*import 'package:flutter/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});



Future<void> login() async {
  final preferenceManager = PreferenceManager();

  final savedEmail =
      preferenceManager.getString('user_email');

  final savedPassword =
      preferenceManager.getString('user_password');

  final email = emailController.text.trim();
  final password = passwordController.text.trim();

  if (email == savedEmail &&
      password == savedPassword) {

    await preferenceManager.setBoolean(
      'is_logged_in',
      true,
    );

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
      (route) => false,
    );
  } else {
    setState(() {
      errorMessage = 'Invalid email or password';
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
*/


import 'package:flutter/material.dart';
import 'package:newst/core/datasource/local_source/preference_manager.dart';
import 'package:newst/core/widget/custom_text_form_feild.dart';
import 'package:newst/features/auth/screen/register_screen.dart';
import 'package:newst/features/home/screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // =========================================
  // Form Key
  // =========================================

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();

  // =========================================
  // Controllers
  // =========================================

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  // =========================================
  // Variables
  // =========================================

  String? errorMessage;

  bool isLoading = false;

  // =========================================
  // Login Function
  // =========================================

  Future<void> login() async {
    setState(() {
      errorMessage = null;
      isLoading = true;
    });

    final preferenceManager = PreferenceManager();

    // Get saved user data
    final savedEmail =
        preferenceManager.getString('user_email');

    final savedPassword =
        preferenceManager.getString('user_password');

    // Get entered data
    final enteredEmail =
        emailController.text.trim();

    final enteredPassword =
        passwordController.text.trim();

    // Check login information
    if (savedEmail == enteredEmail &&
        savedPassword == enteredPassword) {

      // User is logged in
      await preferenceManager.setBoolean(
        'is_logged_in',
        true,
      );

      if (!mounted) return;

      // Go to Home
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (route) => false,
      );

    } else {

      // Login failed
      setState(() {
        errorMessage =
            'Invalid email or password';

        isLoading = false;
      });
    }
  }

  // =========================================
  // Dispose Controllers
  // =========================================

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  // =========================================
  // Build
  // =========================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/backGround.png',
            ),
            fit: BoxFit.cover,
          ),
        ),

        child: Padding(
          padding: const EdgeInsets.all(16.0),

          child: Form(
            key: _formKey,

            child: SingleChildScrollView(
              child: Column(
                children: [

                  const SizedBox(height: 140),

                  // =================================
                  // Logo
                  // =================================

                  Center(
                    child: Image.asset(
                      'assets/images/newst.png',
                      height: 45,
                    ),
                  ),

                  const SizedBox(height: 100),

                  // =================================
                  // Title
                  // =================================

                  const Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF363636),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Login to continue',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6E7191),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // =================================
                  // Email
                  // =================================

                  CustomTextFormFeild(
                    title: 'Email',
                    controller: emailController,
                    obscureText: false,
                    hintText: 'Enter your email',

                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'Please enter your email';
                      }

                      final email =
                          value.trim();

                      final emailRegex =
                          RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      );

                      if (!emailRegex
                          .hasMatch(email)) {
                        return 'Please enter a valid email address';
                      }

                      return null;
                    },
                     maxLines: 1,
                  ),

                  const SizedBox(height: 16),

                  // =================================
                  // Password
                  // =================================

                  CustomTextFormFeild(
                    title: 'Password',
                    controller: passwordController,
                    obscureText: true,
                    hintText: 'Enter your password',

                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'Please enter your password';
                      }

                      return null;
                    },
                     maxLines: 1,
                  ),

                  // =================================
                  // Error Message
                  // =================================

                  if (errorMessage != null)
                    Padding(
                      padding:
                          const EdgeInsets.only(
                        top: 12,
                      ),

                      child: Text(
                        errorMessage!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                    ),

                  const SizedBox(height: 24),

                  // =================================
                  // Login Button
                  // =================================

                  SizedBox(
                    width: double.infinity,
                    height: 48,

                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              if (_formKey
                                      .currentState
                                      ?.validate() ??
                                  false) {
                                login();
                              }
                            },

                      child: isLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,

                              child:
                                  CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Login',
                            ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // =================================
                  // Register
                  // =================================

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    children: [

                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF141414),
                        ),
                      ),

                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const RegisterScreen(),
                            ),
                          );
                        },

                        child: const Text(
                          'Register',
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
    );
  }
}