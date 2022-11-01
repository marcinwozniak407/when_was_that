import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    Key? key,
  }) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var isCreatingAccount = false;
  var errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("When was that?"),
      ),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello!',
                style: GoogleFonts.manrope(
                    fontSize: 40,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                isCreatingAccount == true ? 'SIGN UP' : 'SIGN IN',
                style: GoogleFonts.notoSerif(
                    fontSize: 20,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: widget.emailController,
                decoration: const InputDecoration(hintText: "e-mail"),
              ),
              TextField(
                controller: widget.passwordController,
                obscureText: true,
                decoration: const InputDecoration(hintText: "password"),
              ),
              const SizedBox(height: 20),
              Text(errorMessage),
              const SizedBox(height: 10),
              Container(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (isCreatingAccount == true) {
                      //rejestracja
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: widget.emailController.text,
                                password: widget.passwordController.text);
                      } catch (error) {
                        setState(() {
                          errorMessage = error.toString();
                        });
                      }
                    } else {
                      //logowanie
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: widget.emailController.text,
                            password: widget.passwordController.text);
                      } catch (error) {
                        setState(() {
                          errorMessage = error.toString();
                        });
                      }
                    }
                  },
                  child:
                      Text(isCreatingAccount == true ? 'Sign up' : 'Sign in'),
                ),
              ),
              const SizedBox(height: 20),
              if (isCreatingAccount == false) ...[
                TextButton(
                  onPressed: () {
                    setState(() {
                      isCreatingAccount = true;
                    });
                  },
                  child: const Text('Create an account'),
                ),
              ],
              if (isCreatingAccount == true) ...[
                Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            isCreatingAccount = false;
                          });
                        },
                        child: const Text('Do you have an account?')),
                  ],
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
