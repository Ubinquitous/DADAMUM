import 'package:dadamum/screens/main_screen.dart';
import 'package:dadamum/services/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String selectValue = '부산광역시교육청 (C10)';
  final schoolEditController = TextEditingController();

  final List<String> atptValue = [
    '서울특별시교육청 (B10)',
    '부산광역시교육청 (C10)',
    '대구광역시교육청 (D10)',
    '인천광역시교육청 (E10)',
    '광주광역시교육청 (F10)',
    '대전광역시교육청 (G10)',
    '울산광역시교육청 (H10)',
    '세종특별자치시교육청 (I10)',
    '경기도교육청 (J10)',
    '강원도교육청 (K10)',
    '충청북도교육청 (M10)',
    '충청남도교육청 (N10)',
    '전라북도교육청 (P10)',
    '전라남도교육청 (Q10)',
    '경상북도교육청 (R10)',
    '경상남도교육청 (S10)',
    '제주특별자치도교육청 (T10)'
  ];

  String returnATPTCode(String atpt) {
    return selectValue.substring(
        selectValue.indexOf('(') + 1, selectValue.length - 1);
  }

  @override
  void dispose() {
    schoolEditController.dispose();
    super.dispose();
  }

  void onTapMoveMainPage() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('schoolName', schoolEditController.text);
    prefs.setString('atptName', returnATPTCode(selectValue));
    prefs.setBool('isVisited', true);
    prefs.setString(
        'schoolCode',
        await Api.getSchoolCode(
            schoolEditController.text, returnATPTCode(selectValue)));
    navigatorPushMain();
  }

  void navigatorPushMain() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MainScreen(),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 70,
                      child: Image.network('https://url.kr/zjodia'),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    const Text(
                      '다담음에 오신 것을 환영해요!',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 260,
                      child: DropdownButton(
                        isExpanded: true,
                        value: selectValue,
                        items: atptValue.map(
                          (value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectValue = value!;
                          });
                        },
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 260,
                      child: TextField(
                        controller: schoolEditController,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        decoration: const InputDecoration(
                          hintText: '학교명을 정확히 입력해주세요.',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    GestureDetector(
                      onTap: onTapMoveMainPage,
                      child: Container(
                        width: 260,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: const Center(
                          child: Text(
                            '시작하기',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
    );
  }
}
