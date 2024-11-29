import 'package:flutter/material.dart';
import 'package:xma_app1/Data/Expo_data.dart';
import 'package:xma_app1/Pages/Admin_Pages/Drawer_Pages/Manage_event.dart';
import 'package:xma_app1/Pages/Admin_Pages/Drawer_Pages/User_activity.dart';
import 'package:xma_app1/Pages/Admin_Pages/Drawer_Pages/participant_view.dart';

import '../../Customs/Custom_PopupCard.dart';
import '../../Customs/hero_dialog_route.dart';
class Admin_Homescreen extends StatelessWidget {
  const Admin_Homescreen({super.key});

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Admin_HomePage(),
    );
  }
}

class Admin_HomePage extends StatefulWidget{
  const Admin_HomePage({super.key});

  @override
  State<Admin_HomePage> createState() => _Admin_HomePageState();

}

class _Admin_HomePageState extends State<Admin_HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("XMA"),
      ),
      drawer: Drawer(
        child: ListView(
          children:   [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_forward)),
            ),
            const SizedBox(
              width: 100,
              height: 150,
            ),
            const Divider(color: Colors.black87,),
               ListTile(
              title: const Text("Manage Expo Activity"),
                 onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context)=> const ManageEvent_Homescreen()));
                 },
            ),
            const Divider(color: Colors.black87,),
            ListTile(
              title: const Text("Manage User Activity"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const User_activity_Page()));
              },
            ),
            const Divider(color: Colors.black87,),
            ListTile(
              title: const Text("View Participants"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const participant_HomePage()));
              },
            ),
             const Divider(color: Colors.black87,),
             const ListTile(
               leading: Icon(Icons.settings),
              title: Text("Settings"),
            ),
          ],
        ),
      ),
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
                      DataCell(SizedBox(
                        width: 100, // adjust the width as per your needs
                        child: Text(
                          expo.description,
                          textAlign: TextAlign.left,
                          maxLines: 3, // adjust the maxLines as per your needs
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),),
                      DataCell(Text('${expo.available == 0 ? 'Not available' : expo.available}')),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.of(context).push(
              HeroDialogRoute(
              builder: (context) => const Center(
              child: Add_eventPopupCard(),
              ),
              ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Events"),),
    );
  }
}