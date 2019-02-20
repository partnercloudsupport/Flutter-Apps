import 'package:flutter/material.dart';
import 'package:login_bloc/screens/login_screen.dart';
import '../src/ blocs/provider.dart';


class App extends StatelessWidget {
  build(context) {
    return Provider(
      child: MaterialApp(
        title: "Log Me In",
        home: Scaffold(
          body: LoginScreen(),
        ),
      ),
    );
  }
}