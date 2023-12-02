import 'package:flutter/material.dart';
import 'package:mobilestock/global.dart' as global;

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  final TextEditingController _hostController = TextEditingController();
  final TextEditingController _providerController = TextEditingController();
  final TextEditingController _dbNameController = TextEditingController();

  @override
  void initState() {
    global.loadConfig();
    _hostController.text = (global.serverHost.isNotEmpty) ? global.serverHost : 'http://demo.smlaccount.com';
    _providerController.text = (global.serverProvider.isNotEmpty) ? global.serverProvider : 'PRESENT';
    _dbNameController.text = (global.serverDatabase.isNotEmpty) ? global.serverDatabase : 'DEMO';
    super.initState();
  }

  void _saveSettings() {
    global.appStorage.write("host", _hostController.text);
    global.appStorage.write("provider", _providerController.text);
    global.appStorage.write("database", _dbNameController.text);
    global.loadConfig();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text('บันทึกการตั้งค่าเรียบร้อยแล้ว'),
      ),
    );
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ตั้งค่าการเชื่อมต่อฐานข้อมูล'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _hostController,
              decoration: const InputDecoration(
                labelText: 'Host',
                hintText: 'http://localhost:3000',
              ),
              keyboardType: TextInputType.url,
            ),
            TextField(
              controller: _providerController,
              decoration: const InputDecoration(labelText: 'Provider', hintText: 'DEMO'),
            ),
            TextField(
              controller: _dbNameController,
              decoration: const InputDecoration(labelText: 'Database', hintText: 'DEMO'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: _saveSettings,
              child: const Text(
                'บันทึกการตั้งค่า',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
