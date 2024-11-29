import 'package:flutter/material.dart';
import 'package:xma_app1/Data/Participant_data.dart';
class Participant_homescreen extends StatelessWidget {
  const Participant_homescreen({super.key});

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: participant_HomePage(),
    );
  }
}

class participant_HomePage extends StatefulWidget{
  const participant_HomePage({super.key});

  @override
  State<participant_HomePage> createState() => _participant_HomePageState();

}

class _participant_HomePageState extends State<participant_HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue),
      body:StreamBuilder(
        stream: Participantdata().participantSelect(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
            child: DataTable(
              columns:  const [
                DataColumn(label: Text("PID")),
                DataColumn(label: Text("PName")),
                DataColumn(label: Text("No.of Booth"),),
                DataColumn(label: Text("No. of member"),),
                DataColumn(label: Text("PMno")),
              ],
              rows: snapshot.data!.map<DataRow>((participant) {
                return DataRow(
                cells:[
                    DataCell(Text(('${participant.pid}'))),
                    DataCell(Text(participant.pname)),
                    DataCell(Text('${participant.no_of_booth}')),
                    DataCell(Text('${participant.no_of_member}')),
                    DataCell(Text('${participant.pmno}')),
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
          );
  }
}
