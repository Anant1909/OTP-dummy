import 'package:flutter/material.dart';
import 'package:otp/screens/loading.dart';
import 'package:otp/screens/login.dart';
import 'package:otp/screens/verify.dart';


void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/',
  routes: {
    '/': (context) =>const Loading(),
    '/login': (context) =>const Login(),
    '/verify': (context) =>const  Verify(phoneNumber: '',),

    },
));