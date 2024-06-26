import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:survey_jys/authentication/login_screen.dart';
import 'package:survey_jys/authentication/student_number_screen.dart';
import 'package:survey_jys/authentication/widgets/auth_button.dart';
import 'package:survey_jys/constants/gaps.dart';
import 'package:survey_jys/constants/sizes.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void onLoginTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void onEmailTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const StudentNumberScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size40,
          ),
          child: Column(
            children: [
              Gaps.v80,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "RISEPOINT",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: Sizes.size24,
                      fontFamily: 'ONEMobilePOP',
                    ),
                  ),
                  const Text(
                    " 계정 만들기",
                    style: TextStyle(
                      fontSize: Sizes.size24,
                      fontFamily: 'ONEMobilePOP',
                    ),
                  ),
                ],
              ),
              Gaps.v20,
              const Text(
                "RISEPOINT 계정을 만들어\n"
                "라이징에 참여하세요 !",
                style: TextStyle(
                  fontSize: Sizes.size16,
                  color: Colors.black45,
                  fontFamily: 'ONEMobilePOP',
                ),
                textAlign: TextAlign.center,
              ),
              Gaps.v40,
              AuthButton(
                onTap: (p0) => onEmailTap(context),
                icon: const FaIcon(FontAwesomeIcons.user),
                text: "학번 & 비밀번호로 회원가입하기",
              ),
              Gaps.v16,
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade50,
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "이미 계정을 가지고 있나요 ?",
                style: TextStyle(
                  fontFamily: 'KBODia',
                ),
              ),
              Gaps.h5,
              GestureDetector(
                onTap: () => onLoginTap(context),
                child: Text(
                  "로그인하기",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'KBODia',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
