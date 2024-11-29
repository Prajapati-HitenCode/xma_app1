
import 'package:flutter/material.dart';
import 'package:xma_app1/Data/Expo_data.dart';
import 'package:xma_app1/Pages/User_Pages/Expo_detail.dart';
class Login_screen extends StatelessWidget {
const Login_screen({super.key});

// This widget is the root of your application.
@override
Widget build(BuildContext context) {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
      home: HomePage(),
);
  }
}

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("XMA"),
      ),
      body:StreamBuilder(
        stream: ExpoData().expoSelect(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context,index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Expo_detailPage(
                                expoData: snapshot.data![index],
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          title: Text("Expo Name:-${snapshot.data![index].ename}"),
                          subtitle: Text("Available:-"'${snapshot.data![index].available}'),
                        ),
                      ),
                      const Divider(
                        thickness: 0.2,
                        color: Colors.black87,
                      )
                    ],
                  );
                }
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