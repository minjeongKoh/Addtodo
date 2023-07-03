import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/screen/signin.dart';
import 'package:login_ui/style/app_color.dart';
import 'package:login_ui/widgets/button.dart';
import 'package:login_ui/widgets/formfield.dart';
import 'package:login_ui/widgets/headers.dart';
import 'package:login_ui/widgets/richtext.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final auth = FirebaseAuth.instance;
  final _userName = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

  String get userName => _userName.text.trim();
  String get email => _emailcontroller.text.trim();
  String get password => _passwordcontroller.text.trim();

  void signUp() {
    try {
      auth
          .createUserWithEmailAndPassword(
              email: _emailcontroller.value.text,
              password: _passwordcontroller.value.text)
          .then((value) {
        Navigator.of(context).pop;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        print('패스워드가 너무 약합니다');
      } else if (e.code == 'email-alreay-in-use') {
        print('이 이메일은 이미 계정이 존재합니다');
      }
    } catch (e) {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: AppColors.blue,
            ),
            CustomHeader(
              text: 'Sign Up.',
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Signin(),
                  ),
                );
              },
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.08,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: AppColors.whiteshade,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.09),
                      child: Image.asset("asset/images/login.png"),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomFormField(
                        headingText: "Username",
                        hintText: "Username",
                        obsecureText: false,
                        suffixIcon: const SizedBox(),
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        controller: _userName,
                        maxLines: 1),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomFormField(
                        headingText: "Email",
                        hintText: "Email",
                        obsecureText: false,
                        suffixIcon: const SizedBox(),
                        textInputType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        controller: _emailcontroller,
                        maxLines: 1),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomFormField(
                        headingText: "Password",
                        hintText: "최소 8자리 이상",
                        obsecureText: true,
                        suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.visibility)),
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        controller: _passwordcontroller,
                        maxLines: 1),
                    const SizedBox(
                      height: 16,
                    ),
                    AuthButton(onPressed: signUp, text: 'Sign Up'),
                    CustomRichText(
                      discription: '이미 계정을 가지고 계신가요?',
                      text: '여기에 로그인 하세요',
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Signin()));
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
