// ignore_for_file: file_names

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xma_app1/Data/user_data.dart';
import 'package:xma_app1/Pages/Admin_Pages/Admin_login_page.dart';
import 'package:xma_app1/Pages/User_Pages/Home_page.dart';
import 'package:xma_app1/Pages/User_Pages/Register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final logformkey = GlobalKey<FormState>();
  late TextEditingController usernamecontroller=TextEditingController();
  late TextEditingController passwordcontroller=TextEditingController();
  bool obscure=true;
  void initstate()
  {
    obscure=true;
  }
  @override
  void dispose() {
    usernamecontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("XMA"),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const Admin_loginPage()));
              },
              icon: const Icon(Icons.account_circle))
        ],
      ),
      body: Form(
        key: logformkey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  padding: const EdgeInsetsDirectional.only(top: 80.0),
                  child: const Text("Login", style: TextStyle(fontSize: 50),)
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 35.0, right: 50.0, bottom: 20.0),
                child: TextFormField(
                  controller: usernamecontroller,
                  onFieldSubmitted: (value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter User Name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    icon: const Icon(Icons.account_circle_outlined),
                    iconColor: Colors.lightBlueAccent,
                    hintText: "Enter UserName",
                    fillColor: Colors.lightBlueAccent.shade100,
                    filled: true,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: const BorderSide(color: Colors.black54),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 35.0, right: 50.0),
                child: TextFormField(
                  controller: passwordcontroller,
                  onFieldSubmitted: (value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter password';
                    }
                    else if (value.length < 8) {
                      return 'Password must be 8 characters long';
                    }
                    return null;
                  },
                  obscureText: obscure,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    fillColor: Colors.lightBlueAccent.shade100,
                    filled: true,
                    icon: const Icon(Icons.lock),
                    iconColor: Colors.lightBlueAccent,
                    suffixIcon: IconButton(
                      padding: const EdgeInsetsDirectional.only(end: 20.0),
                      icon: obscure
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          obscure = !obscure;
                        });
                      },
                    ),
                    hintText: "Enter Password",
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: const BorderSide(color: Colors.black54),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20.0),
                child: RichText(
                  text: TextSpan(
                      text: 'Don\'t Have an Account yet?',
                      style: const TextStyle(color: Colors.black87),
                      children: [
                        TextSpan(
                          text: " Sigh up ",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => const RegisterPage()));
                            },
                          style: const TextStyle(color: Colors.blue),
                        )
                      ]
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsetsDirectional.only(top: 20.0),
                child: ElevatedButton(
                    style:  ButtonStyle(
                      minimumSize: WidgetStateProperty.all<Size>(const Size(150, 50)), // Set minimum size here
                      foregroundColor: const WidgetStatePropertyAll<Color>(Colors.black),
                      backgroundColor: const WidgetStatePropertyAll<Color>(Colors.blue),
                    ),
                    onPressed: () async {
                      if (logformkey.currentState!.validate()) {
                        final userFound = await UserData().userFound(usernamecontroller.text,passwordcontroller.text);
                        if (userFound != null && userFound) {
                          Navigator.push(context,MaterialPageRoute(
                              builder: (context) => const HomePage()));
                        }
                        else
                          {
                            Fluttertoast.showToast(
                              msg: "User NotFound",
                              toastLength: Toast.LENGTH_SHORT, // Use ft.ToastLength.short
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.blue,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }
                      }
                    },
                    child: const Text("LOGIN IN",style: TextStyle(fontSize: 20.0),)
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}



