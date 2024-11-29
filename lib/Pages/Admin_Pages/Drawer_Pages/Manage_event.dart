import 'package:flutter/material.dart';
import 'package:xma_app1/Customs/Custom_PopupCard.dart';
import 'package:xma_app1/Customs/hero_dialog_route.dart';
import 'package:xma_app1/Data/Expo_data.dart';
import 'package:xma_app1/Pages/Admin_Pages/Admin_homepage.dart';
class ManageEvent_Homescreen extends StatelessWidget {
  const ManageEvent_Homescreen({super.key});

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ManageEvent_HomePage(),
    );
  }
}

class ManageEvent_HomePage extends StatefulWidget{
  const ManageEvent_HomePage({super.key});

  @override
  State<ManageEvent_HomePage> createState() => _ManageEvent_HomePageState();

}

class _ManageEvent_HomePageState extends State<ManageEvent_HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Admin_HomePage()));
            },
            icon: const Icon(Icons.arrow_back_sharp)),
        backgroundColor: Colors.blue,),

      body: StreamBuilder(
        stream: ExpoData().expoSelect(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: DataTable(
                columnSpacing: 20.0,
                columns: const [
                  DataColumn(label: Text("EID")),
                  DataColumn(label: Text("EName")),
                  DataColumn(label: Text("Description")),
                  DataColumn(label: Text("Available")),
                ],
                rows: snapshot.data!.map<DataRow>((expo) {
                  return DataRow(
                    cells: [
                      DataCell(Text('${expo.eid}')),
                      DataCell(Text(expo.ename)),
                      DataCell(Text(expo.description)),
                      DataCell(Text('${expo.available}')),
                    ],
                  );
                }).toList(),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsetsDirectional.only(end: 30.0,bottom: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              style: ButtonStyle(
                minimumSize:
                MaterialStateProperty.all<Size>(const Size(10, 40)),),
              onPressed: () {
                Navigator.of(context).push(
                  HeroDialogRoute(
                    builder: (context) => const Center(
                      child: Add_eventPopupCard(),
                    ),
                  ),
                );
              }, icon: const Icon(Icons.add),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_upward_rounded),
              style: ButtonStyle(
                minimumSize:
                MaterialStateProperty.all<Size>(const Size(10, 40)),),
                onPressed: (){
                  Navigator.of(context).push(
                      HeroDialogRoute(
                          builder: (context) =>  const Center(
                          child: Update_eventPopupCard())));
                },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              style: ButtonStyle(
                minimumSize:
                MaterialStateProperty.all<Size>(const Size(10, 40)),),
              onPressed: () {
                Navigator.of(context).push(
                  HeroDialogRoute(
                    builder: (context) =>  const Center(
                      child: Delete_eventPopupCard(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}