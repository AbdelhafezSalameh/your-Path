import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_uni_services2/Screens/complete_profile/combined_profile.dart';
import 'package:student_uni_services2/components/custom_surfix_icon.dart';
import 'package:student_uni_services2/constants.dart';
import 'package:student_uni_services2/generated/l10n.dart';
import 'package:student_uni_services2/size_config.dart';

import '../../components/socal_card.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = "/sign_up";

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
      r'^(?=.*[A-Za-z])' +
          r'(?=.*\d)' +
          r'(?=.*[@$!%*?&])' +
          r'[A-Za-z\d@$!%*?&]{8,}$',
    ).hasMatch(value);
  }

  Future<void> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = FirebaseAuth.instance.currentUser;
      await user?.sendEmailVerification();
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Do not close this message!'),
            content: Text(
              'A verification email has been sent to $email. Please check your email and click on the verification link.',
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await user?.reload();
                  if (mounted) {
                    if (user?.emailVerified == true) {
                      print(
                          "heeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeey");
                      Navigator.of(context).pop();

                      Navigator.pushNamed(
                          context, CombinedProfileScreen.routeName);
                    } else {
                      Navigator.of(context).pop();
                    }
                  }
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('An error occurred during sign-up: ${e.message}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('An unexpected error occurred: $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).signUp_appar,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF297C74),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              vertical: getProportionateScreenHeight(20),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.0),
                  Text(S.of(context).signUp_title, style: headingStyle),
                  Text(
                    S.of(context).signUp_text,
                    style: const TextStyle(color: Color(0xFf23B1AD)),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.05),
                  Form(
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
                              return "Please enter a valid email";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: S.of(context).signUp_label_email,
                            hintText: S.of(context).signUp_hint_email,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            prefixIcon: const CustomSurffixIcon(
                              svgIcon: "assets/icons/Mail.svg",
                            ),
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
                              return "Password is required.";
                            } else if (value.length < 8) {
                              addError(error: kShortPassError);
                              return "Password must be at least 8 characters long.";
                            } else if (!isPasswordComplex(value)) {
                              return "Password must contain:\n- At least one letter\n- At least one digit\n- At least one special character.";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: S.of(context).signUp_label_pass,
                            hintText: S.of(context).signUp_hint_pass,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            prefixIcon: const CustomSurffixIcon(
                              svgIcon: "assets/icons/Lock.svg",
                            ),
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
                            } else if (value.isNotEmpty &&
                                password == confirmPassword) {
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
                            prefixIcon: const CustomSurffixIcon(
                              svgIcon: "assets/icons/Lock.svg",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.05),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF297C74),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // Call signUp function here passing email and password
                        signUp(email!, password!);
                        // Navigate to the next screen if needed
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CombinedProfileScreen(),
                          ),
                        );
                      }
                    },
                    child: Text(
                      S.of(context).signUp_button,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocalCard(
                        icon: "assets/icons/google-icon.svg",
                        press: () {},
                      ),
                      SocalCard(
                        icon: "assets/icons/facebook-2.svg",
                        press: () {},
                      ),
                      SocalCard(
                        icon: "assets/icons/twitter.svg",
                        press: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  Text(
                    S.of(context).signUp_term,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFf23B1AD),
                      fontWeight: FontWeight.bold,
                    ),
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
