import 'package:dadamum/screens/main_screen.dart';
import 'package:dadamum/services/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  String schoolName = "";
  String atptName = "";
  String schoolCode = "";

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

  String foramtAtptName(String atpt) {
    if (atpt == 'B10') {
      return "서울특별시교육청";
    } else if (atpt == 'C10') {
      return "부산광역시교육청";
    } else if (atpt == 'D10') {
      return "대구광역시교육청";
    } else if (atpt == 'E10') {
      return "인천광역시교육청";
    } else if (atpt == 'F10') {
      return "광주광역시교육청";
    } else if (atpt == 'G10') {
      return "대전광역시교육청";
    } else if (atpt == 'H10') {
      return "울산광역시교육청";
    } else if (atpt == 'I10') {
      return "세종특별자치시교육청";
    } else if (atpt == 'J10') {
      return "경기도교육청";
    } else if (atpt == 'K10') {
      return "강원도교육청";
    } else if (atpt == 'M10') {
      return "충청북도교육청";
    } else if (atpt == 'N10') {
      return "충청남도교육청";
    } else if (atpt == 'P10') {
      return "전라북도교육청";
    } else if (atpt == 'Q10') {
      return "전라남도교육청";
    } else if (atpt == 'R10') {
      return "경상북도교육청";
    } else if (atpt == 'S10') {
      return "경상남도교육청";
    } else if (atpt == 'T10') {
      return "제주특별자치도교육청";
    } else {
      return "";
    }
  }

  String returnATPTCode(String atpt) {
    return selectValue.substring(
        selectValue.indexOf('(') + 1, selectValue.length - 1);
  }

  void onTapResetInfo() async {
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

  void initPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    schoolName = prefs.getString('schoolName')!;
    atptName = foramtAtptName(prefs.getString('atptName')!);
    schoolCode = prefs.getString('schoolCode')!;
    setState(() {});
  }

  @override
  void initState() {
    initPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          schoolName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '현재 정보',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  '학교명 : $schoolName',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  '교육청명 : $atptName',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '정보 변경',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 20),
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
                  onTap: onTapResetInfo,
                  child: Container(
                    width: 260,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: const Center(
                      child: Text(
                        '변경하기',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: '급식표'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: '내정보'),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MainScreen(),
                fullscreenDialog: true,
              ),
            );
          }
        },
        currentIndex: 1,
      ),
    );
  }
}
