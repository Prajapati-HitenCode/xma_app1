import 'package:flutter/material.dart';
import 'package:xma_app1/Customs/Custom_PopupCard.dart';

import '../../../Customs/hero_dialog_route.dart';
import '../../../Data/user_data.dart';

class User_activity_screen extends StatelessWidget {
  const User_activity_screen({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: User_activity_Page(),
    );
  }
}

class User_activity_Page extends StatefulWidget {
  const User_activity_Page({super.key});

  @override
  State<User_activity_Page> createState() => User_activity_PageState();
}

class User_activity_PageState extends State<User_activity_Page> {
  final Useractformkey = GlobalKey<FormState>();
  bool obscure = true;
  var empData = UserData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("XMA"),
      ),
      body: StreamBuilder(
            stream: UserData().userSelect(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: DataTable(
                    columnSpacing: 20.0,
                    columns: const [
                        DataColumn(label: Text("ID")),
                        DataColumn(label: Text("Name")),
                        DataColumn(label: Text("Password")),
                        DataColumn(label: Text("Mobile No.")),
                        DataColumn(label: Text("Gender")),
                    ],
                    rows: snapshot.data!.map<DataRow>((user) {
                      return DataRow(
                        cells: [
                          DataCell(Text('${user.uid}')),
                          DataCell(Text(user.uname)),
                          DataCell(Text(user.password)),
                          DataCell(Text('${user.mno}')),
                          DataCell(Text(user.gender)),
                        ],
                      );
                    }).toList(),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const Text("No Data Found");
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
                      child: AddTodoPopupCard(),
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
              onPressed: () {
                Navigator.of(context).push(
                  HeroDialogRoute(
                    builder: (context) =>  const Center(
                      child: UpdateTodoPopupCard(),
                    ),
                  ),
                );
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
                      child: DeleteTodoPopupCard(),
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
