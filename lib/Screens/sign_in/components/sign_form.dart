import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_uni_services2/Firebase/authService.dart';
import 'package:student_uni_services2/Screens/sign_up/sign_up_screen.dart';
import 'package:student_uni_services2/admin/homeScreen.dart';
import 'package:student_uni_services2/advertiser_home/advertiserHomeScreen.dart';
import 'package:student_uni_services2/components/custom_surfix_icon.dart';
import 'package:student_uni_services2/components/form_error.dart';
import 'package:student_uni_services2/components/nav_bar.dart';
import 'package:student_uni_services2/generated/l10n.dart';
import 'package:student_uni_services2/helper/keyboard.dart';
import 'package:student_uni_services2/screens/forgot_password/forgot_password_screen.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';

class SignForm extends StatefulWidget {
  const SignForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
  final List<String?> errors = [];
  final AuthService _auth = AuthService();

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

  Future<void> logIn(String email, String password) async {
    String? result = await _auth.signIn(email, password);

    if (result == null) {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String? userRole = await getUserRole(user.uid);

        if (userRole == 'Student') {
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Example()),
          );
        } else if (userRole == 'advertiser') {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(
              context, AdvertiserHomeScreen.routeName);
        } else if (userRole == 'admin') {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, HomeScreenAdmin.routeName);
        } else {
          // ignore: avoid_print
          print('Unknown user role: $userRole');
        }
      }
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> checkAndNavigate() async {
    bool isLoggedIn = await _auth.isUserLoggedIn();

    if (isLoggedIn) {
      // Nav Bar
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Example()),
      );
    } else {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignUpScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text(S.of(context).login_remeber),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  S.of(context).login_forgot,
                  style: const TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        setState(() {
                          _isLoading = true;
                        });
                        // لما يكون التسجيل صح
                        KeyboardUtil.hideKeyboard(context);
                        await logIn(email!, password!);
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  _isLoading ? 'Logging in...' : S.of(context).login_button,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: S.of(context).login_label_pass,
        hintText: S.of(context).login_hint_pass,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
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
        labelText: S.of(context).login_label_email,
        hintText: S.of(context).login_hint_email,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}

Future<String?> getUserRole(String userId) async {
  try {
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userSnapshot.exists) {
      // هاي فيلد بالفايرستور عشان احدد المستخدمين
      return userSnapshot.get('role');
    } else {
      // اذا ما عندي يوزر محدد
      // ignore: avoid_print
      print(
          'User document does not exist in Firestore for user with ID: $userId');
      return null;
    }
  } catch (e) {
    // مشاكل تانية اذا صارت وقت ترجيع البيانات
    // ignore: avoid_print
    print('Error getting user role for user with ID: $userId - Error: $e');
    return null;
  }
}
