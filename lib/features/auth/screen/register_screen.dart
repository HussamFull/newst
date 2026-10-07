import 'package:flutter/material.dart';
import 'package:newst/core/datasource/local_source/preference_manager.dart';
import 'package:newst/core/widget/custom_text_form_feild.dart';
import 'package:newst/features/auth/screen/login_screen.dart';
import 'package:newst/features/home/screen/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _Key = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String? errorMessage;

  bool isLoading = false;

 Future<void> register() async {


    setState(() {
      errorMessage = null;
      isLoading = true;
    });




    final savedEmail = PreferenceManager().getString('user_email');
    if (savedEmail != null && savedEmail == emailController.text.trim()) {
      setState(() {
        errorMessage = 'Email already exists. Please use a different email.';
        isLoading = false;
      });
    } else {
      // Save the email to SharedPreferences
      await PreferenceManager().setString('user_email', emailController.text);
      await PreferenceManager().setString(
        'user_password',
        passwordController.text,
      );
      // await PreferenceManager().setString('user_confirm_password', confirmPasswordController.text);
      // await PreferenceManager().setBoolean('onboarding_completed', true);



// Save the user_registered flag لاحقا مشان الدخول   وتسجيل الخروج كمان   
      await PreferenceManager().setBoolean(
          'user_registered',
          true,
        );



      await PreferenceManager().setBoolean('is_logged_in', true);





        

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()
      ),
       (route) => false,
  );
      // Navigate to the next screen or perform any other action
    }
  }










  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backGround.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _Key,

            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 140),

                  Center(
                    child: Image.asset(
                      'assets/images/newst.png',
                      // width: 100,
                      height: 45,
                    ),
                  ),

                  SizedBox(height: 140),
                  Text(
                    'Welcome to Newts',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF363636),
                    ),
                  ),
                  SizedBox(height: 8),

                  CustomTextFormFeild(
                    title: 'Email',
                    controller: emailController,
                    obscureText: false,
                    hintText: 'Enter your email',

                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email';
                      }

                      //    وقفنا هنا  بالبارت 2
                      final email = value.trim();

                      final emailRegex = RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      );

                      if (!emailRegex.hasMatch(email)) {
                        return 'Please enter a valid email address';
                      }

                      return null;
                    },
                     maxLines: 1,
                  ),

                  // Display error message if it exists
                  if (errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        errorMessage!,
                        style: const TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ),

                  SizedBox(height: 16),

                  CustomTextFormFeild(
                    title: 'Password',
                    controller: passwordController,
                    obscureText: true,
                    hintText: 'Enter your password',

                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your password';
                      }

                      final passwordRegex = RegExp(
                        r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$',
                      );
                      if (!passwordRegex.hasMatch(value)) {
                        return 'Password must contain at least one letter and one number';
                      }

                      return null;
                    },

                     maxLines: 1,
                  ),

                  SizedBox(height: 16),

                  CustomTextFormFeild(
                    title: 'Confirm Password',
                    controller: confirmPasswordController,
                    obscureText: true,
                    hintText: 'Confirm your password',
                     maxLines: 1,


                    validator: (value) {
  if (value == null || value.trim().isEmpty) {
    return 'Please confirm your password';
  }

  if (value.trim() != passwordController.text.trim()) {
    return 'Passwords do not match';
  }

  return null;
},


                  ),

                  SizedBox(height: 24),
                  // 9,17    p 4

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_Key.currentState?.validate() ?? false) {
                          register();
                        }
                      },

                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Register'),
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF141414),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text('Login'),
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
