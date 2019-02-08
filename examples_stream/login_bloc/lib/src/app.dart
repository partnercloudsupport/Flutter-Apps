import 'package:flutter/material.dart';
import 'package:login_bloc/screens/login_screen.dart';

class App extends StatelessWidget {
  build(context) {
    return MaterialApp(
      title: "Log Me In",
      home: Scaffold(
        body: LoginScreen(),
      ),
    );
  }
}