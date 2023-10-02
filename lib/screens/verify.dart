// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

class Verify extends StatefulWidget {
  final String phoneNumber;

  const Verify({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  List<TextEditingController> otpControllers =
      List.generate(4, (_) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());
  bool isOtpValid = false;

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isPhoneNumberValid = widget.phoneNumber.length == 10;

   
    double screenWidth = MediaQuery.of(context).size.width;

    double buttonWidth = screenWidth * 0.8;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 40.0,
                horizontal: 120.0,
              ),
              child: Text(
                'OTP Verify',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Image.asset(
              'assets/image.jpg',
             height: screenWidth * 0.4, 
             width: screenWidth * 0.4, 
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  const Text(
                    'OTP sent to ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10.0,),
                  Text(
                    ' +91-  ${widget.phoneNumber}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      4,
                      (index) => SizedBox(
                        width: 60.0,
                        child: TextField(
                          controller: otpControllers[index],
                          focusNode: focusNodes[index],
                          onChanged: (value) {
                            setState(() {
                              isOtpValid = _isOtpValid();
                            });
                            if (value.isNotEmpty && index < otpControllers.length - 1) {
                              FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                            }
                          },
                          maxLength: 1,
                          decoration: InputDecoration(
                            counter: const Offstage(),
                            contentPadding: const EdgeInsets.all(16.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: buttonWidth,
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: isOtpValid
                          ? () {
                            _showVerificationDialog();
                          }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(169, 163, 56, 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: const Text(
                        'Verify OTP',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      'By signing up you agree with our Terms and Conditions',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isOtpValid() {
    return otpControllers.every((controller) => controller.text.isNotEmpty);
  }

  void _showVerificationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('OTP Verified'),
          content: const Text('Your details have been submitted'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
