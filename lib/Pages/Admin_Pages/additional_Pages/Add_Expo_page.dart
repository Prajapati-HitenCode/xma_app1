import 'package:flutter/material.dart';
import 'package:xma_app1/Data/Expo_data.dart';
import 'package:xma_app1/Model/expo_model.dart';
import 'package:xma_app1/Pages/Admin_Pages/Admin_homepage.dart';

class Add_expo_screen extends StatelessWidget {
  const Add_expo_screen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Navigator(
        initialRoute: '/add-expo',
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          if (settings.name == '/add-expo') {
            builder = (BuildContext context) => const Add_expo_Page();
          } else if (settings.name == '/') {
            // Handle the '/' route here
              builder = (BuildContext context) => const Admin_HomePage();
          } else {
            throw Exception('Invalid route: ${settings.name}');
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
      ),
    );
  }
}

class Add_expo_Page extends StatefulWidget {
  const Add_expo_Page({super.key});

  @override
  State<Add_expo_Page> createState() => _Add_expo_PageState();
}

class _Add_expo_PageState extends State<Add_expo_Page> {
  late TextEditingController expoNameController= TextEditingController();
  late TextEditingController expoDescriptionController= TextEditingController();
  List<int> available=List.generate(20, (index) => index+1);
  int selectedMember=1;
  final addFormKey = GlobalKey<FormState>();
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("XMA"),
      ),
      body: Form(
        key: addFormKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  padding: const EdgeInsetsDirectional.only(top: 30.0),
                  child: const Text(
                    "Expo Data",
                    style: TextStyle(fontSize: 50),
                  )),
              Container(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 35.0, right: 50.0, bottom: 10.0),
                child: TextFormField(
                  controller: expoNameController,
                  onFieldSubmitted: (value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter your Expo Name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    icon: const Icon(Icons.account_circle_outlined),
                    iconColor: Colors.lightBlueAccent,
                    hintText: "Enter Expo Name",
                    fillColor: Colors.lightBlueAccent.shade100,
                    filled: true,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(color: Colors.black54),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 35.0, right: 50.0, bottom: 10.0),
                child: TextFormField(
                  minLines: 5,
                  maxLines: null,
                  controller: expoDescriptionController,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Some Expo description';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    icon: const Icon(Icons.account_circle_outlined),
                    iconColor: Colors.lightBlueAccent,
                    hintText: "Enter description",
                    fillColor: Colors.lightBlueAccent.shade100,
                    filled: true,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(color: Colors.black54),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  const Padding(
                      padding: EdgeInsetsDirectional.only(start: 40.0,end: 20.0),
                    child: Text("Select No. of Available",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      width: 90,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          borderRadius:BorderRadius.circular(0.0),
                          value: selectedMember,
                          isExpanded: true,
                          iconSize: 30,
                          items: available.map((int number)
                          {
                            return DropdownMenuItem(
                              value: number,
                              child: Text(number.toString()),
                            );
                          }).toList(),
                          onChanged: (int? value) {
                            setState(() {
                              selectedMember=value!;
                            });
                          },
                        ),
                      )
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsetsDirectional.only(top: 20.0),
                child: ElevatedButton(
                    style:  ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(const Size(200, 60)), // Set minimum size here
                      foregroundColor:
                      const MaterialStatePropertyAll<Color>(Colors.black),
                      backgroundColor:
                      const MaterialStatePropertyAll<Color>(Colors.blue),
                    ),
                    onPressed: () {
                      setState(() {
                          if (expoNameController.text.isEmpty) {
                                return;
                           }
                          try {
                            var expodata=ExpoData();
                            var data=expo_model(
                                ename: expoNameController.text,
                                description: expoDescriptionController.text,
                                available: selectedMember,
                            );
                                expodata.expoInsert(data);
                          } catch (e) {
                            // Handle the exception, show an error message or toast
                            debugPrint(e.toString());
                          }
                            });
                      Navigator.pop(context);
                        },
                    child: const Text("Add",
                      style: TextStyle(fontSize: 20.0),)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

