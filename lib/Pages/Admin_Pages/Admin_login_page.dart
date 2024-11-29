// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:xma_app1/Pages/Admin_Pages/Admin_homepage.dart';

class Admin_login_screen extends StatelessWidget {
  const Admin_login_screen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const Admin_loginPage();
  }
}

class Admin_loginPage extends StatefulWidget {
  const Admin_loginPage({super.key});

  @override
  State<Admin_loginPage> createState() => _Admin_loginPageState();
}

class _Admin_loginPageState extends State<Admin_loginPage> {
  String? gender = "";
  final Adminformkey = GlobalKey<FormState>();
  late TextEditingController anamecontroller = TextEditingController();
  late TextEditingController passcontroller = TextEditingController();
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_sharp)),
        backgroundColor: Colors.blue,
        title: const Text("XMA"),
      ),
      body: Form(
        key: Adminformkey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  padding: const EdgeInsetsDirectional.only(top: 80.0),
                  child: const Text("ADMIN", style: TextStyle(fontSize: 50),)
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 35.0, right: 50.0, bottom: 20.0),
                child: TextFormField(
                  controller: anamecontroller,
                  onFieldSubmitted: (value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Admin Name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    icon: const Icon(Icons.account_circle_outlined),
                    iconColor: Colors.lightBlueAccent,
                    hintText: "Enter AdminID",
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
                  controller: passcontroller,
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
                padding: const EdgeInsetsDirectional.only(top: 20.0),
                child: ElevatedButton(
                    style:  ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(const Size(150, 50)), // Set minimum size here
                      foregroundColor: const MaterialStatePropertyAll<Color>(Colors.black),
                      backgroundColor: const MaterialStatePropertyAll<Color>(Colors.blue),
                    ),
                    onPressed: () async {

                      if (Adminformkey.currentState!.validate()) {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => const Admin_HomePage()));
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
