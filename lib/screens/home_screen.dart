import 'package:dadamum/screens/main_screen.dart';
import 'package:dadamum/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool hasData = true;

  Future initPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final isVisited = prefs.getBool('isVisited');

    if (isVisited == null || !isVisited) {
      pushSettingScreen();
    } else {
      pushMainScreen();
    }
  }

  void pushSettingScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingScreen()),
    );
  }

  void pushMainScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(),
    );
  }
}
