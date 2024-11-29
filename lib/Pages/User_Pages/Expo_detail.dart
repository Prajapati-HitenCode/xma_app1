import 'package:flutter/material.dart';
import 'package:xma_app1/Model/expo_model.dart';
import 'package:xma_app1/Pages/User_Pages/Participant_page.dart';
class Expo_detailscreen extends StatelessWidget {
  final expo_model expodata;
  const Expo_detailscreen({super.key, required this.expodata});

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Expo_detailPage(expoData: expodata),
    );
  }
}

class Expo_detailPage extends StatelessWidget{
  final expo_model expoData;
  const Expo_detailPage({super.key, required this.expoData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue,),
      body: Column(
        children: [
          Text("Expo Name: ${expoData.ename}"),
          Text("Description${expoData.description}"),
          Text("Available: ${expoData.available == 0 ? 'Not available' : expoData.available}"),
        ],
      ),
      floatingActionButton: expoData.available != 0 ? FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Participant_screen(eid: expoData.eid,)));
        },
        icon: const Icon(Icons.add),
        label: const Text("Participate"),
      ) : null,
    );
  }
}