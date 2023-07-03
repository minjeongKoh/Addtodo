import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/style/app_color.dart';
import 'package:login_ui/style/text_style.dart';
import 'package:login_ui/widgets/formfield.dart';
import 'package:login_ui/widgets/richtext.dart';

import '../widgets/headers.dart';
import 'reset_password.dart';
import 'signup.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final auth = FirebaseAuth.instance;
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

  void signIn() async {
    try {
      await auth.signInWithEmailAndPassword(
        email: _emailcontroller.value.text.trim(),
        password: _passwordcontroller.value.text.trim(),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('오류'),
            content: const Text('비밀번호나 이메일이 틀렸습니다. 다시 한번 확인해 주세요!@'),
            actions: <Widget>[
              TextButton(
                child: const Text('확인'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
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
              text: 'Log in',
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ExitConfirmationDialog()),
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
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
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
                      child: Image.asset('asset/images/login.png'),
                    ),
                    const SizedBox(height: 24),
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
                        hintText: "최소 8자리이상 입력하세요",
                        obsecureText: true,
                        suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.visibility)),
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        controller: _passwordcontroller,
                        maxLines: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 24),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ResetPasswordPage()));
                            },
                            child: Text(
                              "비밀번호를 잊어버렸나요?",
                              style: TextStyle(
                                  color: AppColors.blue.withOpacity(0.7),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ElevatedButton(
                        onPressed: signIn,
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            fixedSize: const Size(600, 50),
                            backgroundColor: AppColors.blue),
                        child: const Text(
                          'Sign In',
                          style: KTextStyle.authButtonTextStyle,
                        ),
                      ),
                    ),
                    CustomRichText(
                      discription: "계정을 갖고 계시지 않은 가요?",
                      text: "Sign Up",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const SignUp())));
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

class ExitConfirmationDialog extends StatelessWidget {
  const ExitConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('나가기 확인'),
      content: const Text('정말로 나가시겠습니까?'),
      actions: <Widget>[
        TextButton(
          child: const Text('아니오'),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => const Signin()))); // 다이얼로그 닫기
          },
        ),
        TextButton(
          child: const Text('예'),
          onPressed: () {
            Navigator.of(context).pop(true); // 다이얼로그 닫기
          },
        ),
      ],
    );
  }
}
