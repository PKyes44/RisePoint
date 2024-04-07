import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:survey_jys/authentication/password_screen.dart';
import 'package:survey_jys/constants/gaps.dart';
import 'package:survey_jys/constants/sizes.dart';
import 'package:survey_jys/widgets/form_button.dart';

class StudentNumberScreen extends StatefulWidget {
  const StudentNumberScreen({super.key});

  @override
  State<StudentNumberScreen> createState() => _StudentNumberScreenState();
}

class _StudentNumberScreenState extends State<StudentNumberScreen> {
  final TextEditingController _studentNumberController =
      TextEditingController();
  String _studentNumber = "";
  List<String> alreadyStudentNumberList = [];

  @override
  void initState() {
    super.initState();
    readUserData();
    _studentNumberController.addListener(() {
      setState(() {
        _studentNumber = _studentNumberController.text;
      });
    });
  }

  @override
  void dispose() {
    _studentNumberController.dispose();
    super.dispose();
  }

  void onPasswordTap() {
    if (_studentNumber.isEmpty || isStudentNumberValid() != null) {
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PasswordScreen(
          userData: {
            'studentNumber': _studentNumber,
          },
        ),
      ),
    );
  }

  void onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void readUserData() async {
    final reference = FirebaseDatabase.instance.ref();
    DataSnapshot snapshot = await reference.child('user/').get();

    if (snapshot.value == null) {
      return;
    }
    try {
      final data = snapshot.value as Map<dynamic, dynamic>;
      for (var key in data.keys) {
        alreadyStudentNumberList.add(key);
      }
      setState(() {});
      print(alreadyStudentNumberList);
    } catch (e) {
      return;
    }
  }

  String? isStudentNumberValid() {
    if (_studentNumber.isEmpty) {
      return null;
    }
    final regExp = RegExp('^[1-3][1-8](?:0[1-9]|[1][0-9]|[2][0])\$');
    if (!regExp.hasMatch(_studentNumber)) {
      return "자신의 학번을 숫자 4자리로 알맞게 써주세요";
    }
    if (alreadyStudentNumberList.contains(_studentNumber)) {
      return "이미 해당 학번으로 생성된 계정이 존재합니다";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onScaffoldTap,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Sign Up",
            style: TextStyle(
              fontFamily: 'ONEMobilePOP',
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size36,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v40,
              const Text(
                "당신의 학번을 입력해주세요",
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontFamily: 'KBODia',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gaps.v8,
              const Text(
                "계정 생성 후 바꿀 수 없습니다",
                style: TextStyle(
                  fontSize: Sizes.size12,
                  color: Colors.black54,
                  fontFamily: 'KBODia',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Gaps.v16,
              TextFormField(
                onSaved: (newValue) {
                  _studentNumber = newValue.toString();
                },
                keyboardType: TextInputType.number,
                controller: _studentNumberController,
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  errorText: isStudentNumberValid(),
                  hintText: "학번을 입력해주세요  ex) 3213",
                  hintStyle: const TextStyle(
                    fontFamily: 'KBODia',
                    fontWeight: FontWeight.w200,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
              ),
              Gaps.v16,
              GestureDetector(
                onTap: onPasswordTap,
                child: FormButton(
                  widthSize: MediaQuery.of(context).size.width,
                  disabled: isStudentNumberValid() != null,
                  text: "다음",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
