// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_uni_services2/Screens/otp/otp_screen.dart';
import 'package:student_uni_services2/generated/l10n.dart';
import 'package:student_uni_services2/size_config.dart';
import 'package:email_sender/email_sender.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../complete_profile/complete_profile_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? confirmPassword;
  bool remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  bool isPasswordComplex(String value) {
    return RegExp(
            // r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$'
            r'^(?=.*[A-Za-z])' // حرف واحد ع الاقل سواء كبير او صغير

            // \d يعني من صفر ل تسعة
            r'(?=.*\d)' // رقم واحد ع الاقل

            r'(?=.*[@$!%*?&])' // رمز واحد ع الاقل
            r'[A-Za-z\d@$!%*?&]{8,}$' // مجموع كلشي يكون اقل شي ثمانية خانات
            )
        .hasMatch(value);
  }

  Future<void> sendVerificationEmail(String email) async {
    final randomNumbers = generateRandomNumbers(6);
    // ignore: avoid_print
    print('Random Numbers: $randomNumbers');
  }

  List<int> generateRandomNumbers(int length) {
    final random = Random();
    return List.generate(length, (index) => random.nextInt(10));
  }

  Future<void> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = FirebaseAuth.instance.currentUser;
      await user?.sendEmailVerification();
      //   // ignore: avoid_print
      // ignore: avoid_print
      print('Sign-up successful!');
      //   // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, CompleteProfileScreen.routeName);
    } catch (e) {
      //   // ignore: avoid_print
      print('Error during sign-up: $e');
    }

    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Text('Email Verification Required'),
    //         content: Text(
    //           'A verification email has been sent to $email. Please check your email and click on the verification link.',
    //         ),
    //         actions: [
    //           TextButton(
    //             onPressed: () async {
    //               await user?.reload();
    //               if (mounted && user?.emailVerified == true) {
    //                 Navigator.pushNamed(
    //                     context, CompleteProfileScreen.routeName);
    //               }
    //             },
    //             child: const Text('OK'),
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // } on FirebaseAuthException catch (e) {
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Text('Error'),
    //         content: Text('An error occurred during sign-up: ${e.message}'),
    //         actions: [
    //           TextButton(
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //             child: Text('OK'),
    //           ),
    //         ],
    //       );
    //     },
    //   );

    // on FirebaseAuthException catch (e) {
    //   // Handle FirebaseAuthException and display an error message
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Text('Error'),
    //         content: Text('An error occurred during sign-up: ${e.message}'),
    //         actions: [
    //           TextButton(
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //             child: Text('OK'),
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }
    //   catch (e) {
    // Handle other exceptions and display an error message
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: Text('Error'),
    //       content: Text('An unexpected error occurred: $e'),
    //       actions: [
    //         TextButton(
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //           child: Text('OK'),
    //         ),
    //       ],
    //     );
    //   },
    // );
    //   }
  }

  Random random = Random();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            cursorColor: const Color(0xFF297C74),
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kEmailNullError);
              } else if (emailValidatorRegExp.hasMatch(value)) {
                removeError(error: kInvalidEmailError);
              }
              return;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kEmailNullError);
                return "";
              } else if (!emailValidatorRegExp.hasMatch(value)) {
                addError(error: kInvalidEmailError);
                return "";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: S.of(context).signUp_label_email,
              hintText: S.of(context).signUp_hint_email,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon:
                  const CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.04),
          TextFormField(
            cursorColor: const Color(0xFF297C74),
            obscureText: true,
            onSaved: (newValue) => password = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPassNullError);
              } else if (value.length >= 8) {
                removeError(error: kShortPassError);
              }
              password = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kPassNullError);
                return "";
              } else if (value.length < 8) {
                addError(error: kShortPassError);
                return "";
              } else if (!isPasswordComplex(value)) {
                addError(
                    error:
                        "Password must contain:\nsymbols, numbers, and characters");
                return "";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: S.of(context).signUp_label_email,
              hintText: S.of(context).signUp_hint_pass,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon:
                  const CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.04),
          TextFormField(
            cursorColor: const Color(0xFF297C74),
            obscureText: true,
            onSaved: (newValue) => confirmPassword = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPassNullError);
              } else if (value.isNotEmpty && password == confirmPassword) {
                removeError(error: kMatchPassError);
              }
              confirmPassword = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kPassNullError);
                return "";
              } else if (password != value) {
                addError(error: kMatchPassError);
                return "";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: S.of(context).signUp_label_confirm_pass,
              hintText: S.of(context).signUp_hint_confirm_pass,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon:
                  const CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
            ),
          ),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.04),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF297C74),
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                int randomNumber = random.nextInt(9000) + 1000;
                EmailSender emailsender = EmailSender();
                var response =
                    await emailsender.sendOtp("$email", randomNumber);
                print("heeeeeeeeeeeeeeeeeey response= ${response}");
                _formKey.currentState!.save();
                signUp(email!, password!);
                Navigator.pushNamed(context, OtpScreen.routeName,
                    arguments: {
                      "email" : email
                    });
              }
            },
            child: Text(
              S.of(context).signUp_button,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
