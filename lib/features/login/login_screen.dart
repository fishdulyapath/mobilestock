import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilestock/bloc/authentication/authentication_bloc.dart';
import 'package:mobilestock/global.dart' as global;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final TextEditingController _dbNameController = TextEditingController();
  final TextEditingController _providerController = TextEditingController();
  @override
  void initState() {
    _providerController.text = "PRESENT";
    _dbNameController.text = "demo";
    _usernameController.text = "SUPERADMIN";
    _passwordController.text = "superadmin";

    super.initState();
  }

  void _login() {
    if (_usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty && _providerController.text.isNotEmpty && _dbNameController.text.isNotEmpty) {
      BlocProvider.of<AuthenticationBloc>(context)
          .add(AuthenticationLoggedIn(_usernameController.text, _passwordController.text, _providerController.text, _dbNameController.text));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("กรุณากรอกข้อมูลให้ครบถ้วน"),
        ),
      );
    }
  }

  void _openServerSettings() {
    Navigator.of(context).pushNamed('/config');
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                content: Text('เข้าสู่ระบบเรียบร้อยแล้ว'),
              ),
            );

            Navigator.of(context).pushNamedAndRemoveUntil('/menu', (route) => false);
          } else if (state is AuthenticationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.message),
              ),
            );
          }
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFa7bfe8), Color(0xFFffffff)],
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 80.0),
                  Center(child: Image.asset('assets/logo/logo.png', fit: BoxFit.cover)),
                  const SizedBox(height: 30.0),
                  TextField(
                    controller: _providerController,
                    decoration: const InputDecoration(
                      labelText: 'Provider',
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextField(
                    controller: _dbNameController,
                    decoration: const InputDecoration(
                      labelText: 'Database',
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Usercode',
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 35.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: _login,
                    child: const Text(
                      'เข้าสู่ระบบ',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.white,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //   ),
                  //   onPressed: _openServerSettings,
                  //   child: const Text('ตั้งค่า server', style: TextStyle(fontSize: 16)),
                  // ),
                ],
              ),
            ),
          ),
        ));
  }
}
