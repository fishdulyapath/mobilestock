import 'package:flutter/material.dart';
import 'package:mobilestock/global.dart' as global;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      _loadConfig();
    });
    super.initState();
  }

  Future<void> _loadConfig() async {
    if (global.userCode.isNotEmpty && global.userName.isNotEmpty && global.serverDatabase.isNotEmpty && global.serverProvider.isNotEmpty) {
      Navigator.of(context).pushNamedAndRemoveUntil('/menu', (route) => false);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/logo/logo.png'),
          )
        ],
      ),
    );
  }
}
