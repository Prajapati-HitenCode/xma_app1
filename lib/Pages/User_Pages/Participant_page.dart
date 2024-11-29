
// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:xma_app1/Data/Expo_data.dart';
import 'package:xma_app1/Data/Participant_data.dart';
import 'package:xma_app1/Model/participant_model.dart';
import 'package:xma_app1/Pages/User_Pages/Home_page.dart';


class Participant_screen extends StatelessWidget{
  final eid;
  const Participant_screen({super.key, required this.eid});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ParticipantPage(eid: eid),
    );
  }
}

class ParticipantPage extends StatefulWidget {
  final eid;
  const ParticipantPage({super.key,required this.eid});

  @override
  State<ParticipantPage> createState() => _ParticipantPageState();
}

class _ParticipantPageState extends State<ParticipantPage> {
  String? gender = "";
  late TextEditingController pnamecontroller=TextEditingController();
  late TextEditingController pmnocontroller=TextEditingController();
  late int Nomember = 1;
  late int Nobooth=1;
  List<int> no_of_member=List.generate(50, (index) => index+1);
   late List<int> no_of_booth=[];
  @override
  void initState() {
    super.initState();
    ExpoData().getAvailableBooths(widget.eid).then((value) {
      setState(() {
          no_of_booth = List.generate(value, (index) => index + 1);
      });
    });
  }
  final Regformkey = GlobalKey<FormState>();
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("XMA"),
      ),
      body: Form(
        key: Regformkey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  padding: const EdgeInsetsDirectional.only(top: 30.0),
                  child: const Text(
                    "Participant",
                    style: TextStyle(fontSize: 50),
                  )),
              Container(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 35.0, right: 50.0, bottom: 10.0),
                child: TextFormField(
                  controller: pnamecontroller,
                  onFieldSubmitted: (value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Participant Name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    icon: const Icon(Icons.account_circle_outlined),
                    iconColor: Colors.lightBlueAccent,
                    hintText: "Enter Participant Name",
                    fillColor: Colors.lightBlueAccent.shade100,
                    filled: true,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: const BorderSide(color: Colors.black54),
                    ),
                  ),
                ),
              ),
              Center(
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0,top: 10.0),
                      child: Text("No.of Booth \n\t\tRequired",
                          style: TextStyle(fontSize: 20.0)),
                    ),
                    const SizedBox(width: 10),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        width: 90,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            borderRadius:BorderRadius.circular(30.0),
                            value: Nobooth,
                            isExpanded: true,
                            iconSize: 30,
                            items: no_of_booth.map((int number)
                            {
                              return DropdownMenuItem(
                                value: number,
                                child: Text(number.toString()),
                              );
                            }).toList(),
                            onChanged: (int? value) {
                              setState(() {
                                Nobooth=value!;
                                 });
                            },
                          ),
                        )
                    ),
                    const Padding(
                        padding: EdgeInsetsDirectional.only(start: 30.0),
                    child: Text("20 x 30m",
                    style: TextStyle(fontSize: 20.0),),)
                  ],
                ),
              ),
              Center(
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0,top: 10.0),
                      child: Text("No.of Member Required",
                          style: TextStyle(fontSize: 20.0)),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      width: 90,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          borderRadius:BorderRadius.circular(30.0),
                          value: Nomember,
                          isExpanded: true,
                          iconSize: 30,
                          items: no_of_member.map((int number)
                          {
                            return DropdownMenuItem(
                              value: number,
                              child: Text(number.toString()),
                            );
                          }).toList(),
                          onChanged: (int? value) {
                            setState(() {
                              Nomember=value!;
                            });
                          },
                        ),
                      )
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 20.0, left: 35.0, right: 50.0, bottom: 10.0),
                child: TextFormField(
                  controller: pmnocontroller,
                  onFieldSubmitted: (value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter 10 digit Phone Number';
                    } else if (value.length < 9) {
                      return 'Phone Number must be of 10 digit long';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    icon: const Icon(Icons.phone),
                    iconColor: Colors.lightBlueAccent,
                    hintText: "Enter Mobile No.",
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
                padding: const EdgeInsetsDirectional.only(top: 20.0),
                child: ElevatedButton(
                    style:  ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(const Size(200, 60)), // Set minimum size here
                      foregroundColor:
                      const MaterialStatePropertyAll<Color>(Colors.black),
                      backgroundColor:
                      const MaterialStatePropertyAll<Color>(Colors.blue),
                    ),
                    onPressed: ()  async {
                        try
                        {
                          int available= await ExpoData().getAvailableBooths(widget.eid);
                          int left=available-Nobooth;
                          var participate = Participantdata();
                          var data = participant_model(
                              pname: pnamecontroller.text,
                              no_of_booth: Nobooth,
                              no_of_member: Nomember,
                              pmno: int.parse(pmnocontroller.text));
                          participate.participantInsert(data);
                          ExpoData().expoparticipate(widget.eid, left);
                        }
                        catch(e)
                        {
                          debugPrint(e.toString());
                        }
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage())
                        );
                      },
                    child: const Text("Participate",
                      style: TextStyle(fontSize: 20.0),)),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

