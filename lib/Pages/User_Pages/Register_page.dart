import 'package:flutter/material.dart';
import 'package:xma_app1/Data/user_data.dart';

import '../../Model/user_model.dart';

class Register_screen extends StatelessWidget {
  const Register_screen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String newgender="";
  final Regformkey = GlobalKey<FormState>();
  bool obscure=true;
  late TextEditingController unamecontroller=TextEditingController();
  late TextEditingController passcontroller=TextEditingController();
  late TextEditingController mnocontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("XMA"),
      ),
      body: Form(
        key: Regformkey,
        child: SingleChildScrollView(
          child:Column(
            children: <Widget>[
              Container(
                  padding: const EdgeInsetsDirectional.only(top: 30.0),
                  child: const Text("Registration",style: TextStyle(fontSize: 50),)
              ),
              Container(
                padding: const EdgeInsets.only(top: 10.0,left: 35.0,right: 50.0,bottom: 10.0),
                child: TextFormField(
                  controller: unamecontroller,
                  onFieldSubmitted: (value){},
                  validator: (value)
                  {
                    if(value!.isEmpty){
                      return 'Please enter User Name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
                    icon: const Icon(Icons.account_circle_outlined),
                    iconColor: Colors.lightBlueAccent,
                    hintText: "Enter UserName",
                    fillColor: Colors.lightBlueAccent.shade100,
                    filled: true,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: const BorderSide(color:Colors.black54),
                    ),
                  ),
                ),
              ),
            Container(
              padding: const EdgeInsets.only(top: 10.0,left: 35.0,right: 50.0,bottom: 10.0),
                child:TextFormField(
                  controller: passcontroller,
                 cursorColor: Colors.white,
                 validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter password';
                  }
                  else if (value.length < 8) {
                    return 'Password must be 8 characters long';
                  }
                  return null;
                },
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
                    icon: const Icon(Icons.account_circle_outlined),
                    iconColor: Colors.lightBlueAccent,
                    fillColor: Colors.lightBlueAccent.shade100,
                    filled: true,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: const BorderSide(color:Colors.black54),
                    ),
                  ),
                ),
            ),
              Container(
                padding: const EdgeInsets.only(top: 10.0,left: 35.0,right: 50.0,bottom: 20.0),
                child: TextFormField(
                  controller: mnocontroller,
                  onFieldSubmitted: (value){},
                  validator: (value)
                  {
                    if(value!.isEmpty){
                      return 'Please enter 10 digit Phone Number';
                    }
                    else if(value.length<9)
                      {
                        return 'Phone Number must be of 10 digit long';

                      }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
                    icon: const Icon(Icons.phone),
                    iconColor: Colors.lightBlueAccent,
                    hintText: "Enter Mobile No.",
                    fillColor: Colors.lightBlueAccent.shade100,
                    filled: true,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: const BorderSide(color:Colors.black54),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 20.0),
                    child:  const Text("Gender:",style: TextStyle(fontSize: 21.0),),
                  ),
                  Expanded(
                    child:RadioListTile(
                        contentPadding: const EdgeInsets.only(left: 10.0,right: 0.0),
                        title: const Text("Male",style: TextStyle(fontSize: 18.0)),
                        value: "Male",
                        groupValue: newgender,
                        onChanged: (value){
                          setState(() {
                            newgender=value!;
                          });
                        }
                    ),
                  ),

                  Expanded(
                    child: RadioListTile(
                        contentPadding: const EdgeInsets.all(0.0),
                        title: const Text("Female",style: TextStyle(fontSize: 18.0),),
                        value: "Female",
                        groupValue: newgender,
                        onChanged: (value){
                          setState(() {
                            newgender=value!;
                          });
                        }
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.only(left: 35.0,right: 50.0),
                child: TextFormField(
                  onFieldSubmitted: (value){},
                  validator: (value)
                  {
                    if(value!.isEmpty){
                      return 'Please Enter password';

                    }
                    else if(value.length<8) {
                      return 'Password must be 8 characters long';
                    }
                    return null;
                  },
                  obscureText:obscure,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
                    fillColor: Colors.lightBlueAccent.shade100,
                    filled: true,
                    icon: const Icon(Icons.lock),
                    iconColor: Colors.lightBlueAccent,
                    suffixIcon: IconButton(
                      padding: const EdgeInsetsDirectional.only(end: 20.0),
                      icon:  obscure? const Icon(Icons.visibility_off):const Icon(Icons.visibility),
                      onPressed: (){
                        setState(() {
                          obscure=!obscure;
                        });
                      },
                    ),
                    hintText: "Enter Password",
                    errorBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: const BorderSide(color:Colors.black54),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsetsDirectional.only(top: 20.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(const Size(150, 50)), // Set minimum size here
                      foregroundColor: const MaterialStatePropertyAll<Color>(Colors.black),
                      backgroundColor: const MaterialStatePropertyAll<Color>(Colors.blue),
                    ),
                    onPressed: ()
                    {
                      if(Regformkey.currentState!.validate()) {
                        try {
                          var userdata = UserData();
                          var data = user_model(
                            uname: unamecontroller.text,
                            password: passcontroller.text,
                            mno: int.parse(mnocontroller.text),
                            gender: newgender,
                          );
                          userdata.userInsert(data);
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      }
                    },
                    child: const Text("SIGN UP",style: TextStyle(fontSize: 20.0),)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



