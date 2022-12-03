import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPage extends StatefulWidget {
  const ResetPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ResetPage> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  var errorMessage = '';
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
    } on FirebaseAuthException catch (errorMessage) {
      print(errorMessage.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Reset password"),
      ),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                  'Enter your e-mail and you will receive the password reset link',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center),
              const SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "e-mail",
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => passwordReset(),
                    child: const Text('Send request',
                        style: TextStyle(fontSize: 20)),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
