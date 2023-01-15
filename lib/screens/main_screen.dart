import 'package:dadamum/screens/mypage_screen.dart';
import 'package:dadamum/services/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String breakfast = "";
  String lunch = "";
  String dinner = "";

  String schoolName = '';
  String atptName = '';
  String schoolCode = '';
  DateTime now = DateTime.now();
  final List<String> week = ['월', '화', '수', '목', '금', '토', '일'];

  String dateFormat(DateTime now) {
    String month = "";
    String day = "";
    if (now.month <= 9) {
      month = '0${now.month}';
    } else {
      month = '${now.month}';
    }
    if (now.day <= 9) {
      day = '0${now.day}';
    } else {
      day = '${now.day}';
    }
    return '${now.year}$month$day';
  }

  void initPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('schoolCode') != null) {
      schoolCode = prefs.getString('schoolCode')!;
    }
    if (prefs.getString('atptName') != null) {
      atptName = prefs.getString('atptName')!;
    }
    if (prefs.getString('schoolName') != null) {
      schoolName = prefs.getString('schoolName')!;
    }
    setState(() {});
  }

  void setMeal() async {
    breakfast =
        await Api.getSchoolMeal(schoolCode, atptName, dateFormat(now), 0);
    lunch = await Api.getSchoolMeal(schoolCode, atptName, dateFormat(now), 1);
    dinner = await Api.getSchoolMeal(schoolCode, atptName, dateFormat(now), 2);
    setState(() {});
  }

  void onTapPrevDate() {
    now = now.add(const Duration(days: -1));
    setState(() {});
    setMeal();
  }

  void onTapNextDate() {
    now = now.add(const Duration(days: 1));
    setState(() {});
    setMeal();
  }

  @override
  void initState() {
    initPrefs();
    setMeal();
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: onTapPrevDate,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 24,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 4),
                    ],
                  ),
                ),
                Text(
                  '${now.year}년 ${now.month}월 ${now.day}일 ${week[now.weekday - 1]}요일',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
                GestureDetector(
                  onTap: onTapNextDate,
                  child: Row(
                    children: const [
                      SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 24,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 270,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 6,
                ),
                const Text(
                  '조식',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  breakfast
                      .replaceAll('<br/>', '\n')
                      .replaceAll('(산고)', '')
                      .replaceAll(RegExp('[0-9]'), "")
                      .replaceAll('.', '')
                      .replaceAll('(', '')
                      .replaceAll(')', ''),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 270,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 6,
                ),
                const Text(
                  '중식',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  lunch
                      .replaceAll('<br/>', '\n')
                      .replaceAll('(산고)', '')
                      .replaceAll(RegExp('[0-9]'), "")
                      .replaceAll('.', '')
                      .replaceAll('(', '')
                      .replaceAll(')', ''),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 270,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 6,
                ),
                const Text(
                  '석식',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  dinner
                      .replaceAll('<br/>', '\n')
                      .replaceAll('(산고)', '')
                      .replaceAll(RegExp('[0-9]'), "")
                      .replaceAll('.', '')
                      .replaceAll('(', '')
                      .replaceAll(')', ''),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: '급식표'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: '내정보'),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyPageScreen(),
                fullscreenDialog: true,
              ),
            );
          }
        },
        currentIndex: 0,
      ),
    );
  }
}
