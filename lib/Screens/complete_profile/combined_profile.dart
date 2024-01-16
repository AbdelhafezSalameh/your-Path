import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:student_uni_services2/Screens/sign_in/sign_in_screen.dart';
import 'package:student_uni_services2/components/custom_surfix_icon.dart';
import 'package:student_uni_services2/components/form_error.dart';
import 'package:student_uni_services2/size_config.dart';

import '../../constants.dart';

class CombinedProfileScreen extends StatefulWidget {
  static String routeName = "/complete_profile";

  final String? email;
  final String? password;

  const CombinedProfileScreen({
    this.email,
    this.password,
    Key? key,
  }) : super(key: key);

  @override
  State<CombinedProfileScreen> createState() => _CombinedProfileScreenState();
}

class _CombinedProfileScreenState extends State<CombinedProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final List<String?> errors = [];
  String? fullName;
  String? major;
  String? address;
  String? college;
  final String role = "Student";

  List<String> colleges = [
    'تكنولوجيا المعلومات',
    'المال والأعمال',
    'الدعوة وأصول الدين',
    'الشيخ نوح للشريعة والقانون',
    'الآداب والعلوم التربوية',
    'الفنون والعمارة الإسلامية',
  ];

  Map<String, List<String>> majorsByCollege = {
    'تكنولوجيا المعلومات': [
      'هندسة البرمجيات',
      'علم الحاسوب',
      'أمن وسرية المعلومات والشبكات',
      'تظم الشبكات'
    ],
    'المال والأعمال': [
      'إدارة الأعمال',
      'المحاسبة',
      'العلوم المالية والمصرفية',
      'المصارف الإسلامية',
      'نظم المعلومات الإدارية'
    ],
    'الدعوة وأصول الدين': ['الفقه الحنفي', 'الفقه الشافعي', 'الفقه المالكي'],
    'الشيخ نوح للشريعة والقانون': [
      'أصول الدين',
      'الفقه وأصوله',
      'الأدآء الصوتي والتجويد',
      'القراءات والدراسات القرآنية',
      'القانون'
    ],
    'الآداب والعلوم التربوية': [
      'الإنجليزية وآدابها',
      'العربية وأدابها',
      'التاريخ والحضارة الإسلامية',
      "معلم الصف",
      "التربية الخاصة",
      "إرشاد وصحة نفسية"
    ],
    'الفنون والعمارة الإسلامية': [
      'التصميم الداخلي',
      'الفنون والزخارف الإسلامية'
    ],
  };

  List<String> majors = [];
  @override
  void initState() {
    super.initState();
    majors = majorsByCollege[colleges.first] ?? [];
  }

  Future<void> saveUserDataToFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.emailVerified) {
      try {
        final token = await FirebaseMessaging.instance.getToken();

        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'fullName': fullName,
          'major': major,
          'college': college,
          'address': address,
          'role': role,
          'deviceToken': token,
        });
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Sign-Up Successful'),
              content: Text(
                'Your Name is: $fullName.\nYour Major is: $major',
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        print('User data and device token saved to Firestore successfully!');
      } catch (e) {
        print('Error saving user data to Firestore: $e');
      }
    } else {
      print('Data registration failed. User or email not verified.');
      Future.delayed(Duration.zero, () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Sign-Up not Successful'),
              content: const Text(
                "The information was not registered successfully, because the sent mail was not verified.\nPlease re-create the account with another account",
              ),
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
      });
    }
  }

  void addError({String? error}) {
    if (!errors.contains(error)) {
      errors.add(error);
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      errors.remove(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign Up",
          style: TextStyle(
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
                horizontal: getProportionateScreenWidth(15)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(15)),
                  const Text("Complete Profile", style: headingStyle),
                  const Text(
                    "Complete your details or continue  \nwith social media",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          onSaved: (newValue) => fullName = newValue,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              removeError(error: kNamelNullError);
                            }
                            return;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              addError(error: kNamelNullError);
                              return "";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: "Full Name",
                            hintText: "Enter your full name",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            prefixIcon: CustomSurffixIcon(
                                svgIcon: "assets/icons/User.svg"),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        DropdownButtonFormField<String>(
                          items: colleges.map((String? value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value!),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              college = value;
                              majors = majorsByCollege[value] ?? [];
                              major =
                                  null; // Reset selected major when college changes
                            });
                          },
                          value: college,
                          decoration: const InputDecoration(
                            prefixIcon: CustomSurffixIcon(
                                svgIcon: "assets/icons/college.svg"),
                            labelText: "College",
                            hintText: "Choose your college",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        DropdownButtonFormField<String>(
                          items: majors.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              major = value;
                            });
                          },
                          value: major,
                          decoration: const InputDecoration(
                            prefixIcon: CustomSurffixIcon(
                                svgIcon: "assets/icons/major.svg"),
                            labelText: "Major",
                            hintText: "Choose your major",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        TextFormField(
                          onSaved: (newValue) => address = newValue,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              removeError(error: kAddressNullError);
                            }
                            return;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              addError(error: kAddressNullError);
                              return "";
                            }
                            return null;
                          },
                          maxLength: 10,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: "Student ID",
                            hintText: "Enter your Student ID",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            prefixIcon: CustomSurffixIcon(
                              svgIcon: "assets/icons/ID-STD.svg",
                            ),
                          ),
                        ),
                        FormError(errors: errors),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF297C74),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              saveUserDataToFirestore();
                              Navigator.pushNamed(
                                  context, SignInScreen.routeName);
                            }
                          },
                          child: const Text("Continue",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  Text(
                    "By continuing, you confirm that you agree with our Terms and Conditions",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
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
