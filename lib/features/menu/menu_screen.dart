import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mobilestock/bloc/authentication/authentication_bloc.dart';
import 'package:mobilestock/bloc/webservice/webservice_bloc.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationLogout) {
          Navigator.of(context).pushReplacementNamed('/login');
        }
      },
      child: BlocListener<WebserviceBloc, WebserviceState>(
        listener: (context, state) {},
        child: Scaffold(
          appBar: AppBar(
            title: const Text('SMLMobileStock', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 27)),
            actions: [
              IconButton(
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLoggedOut());
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        backgroundColor: Colors.green.shade600,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/cartlist');
                      },
                      child: const Text(
                        "ตะกร้าตรวจนับ",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        backgroundColor: Colors.orangeAccent.shade700,
                      ),
                      onPressed: () {},
                      child: const Text(
                        "รายการอนุมัติ",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
