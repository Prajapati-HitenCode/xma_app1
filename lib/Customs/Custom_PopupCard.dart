// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:xma_app1/Customs/custom_rect_tween.dart';
import 'package:xma_app1/Data/Expo_data.dart';
import 'package:xma_app1/Data/user_data.dart';
import 'package:xma_app1/Model/expo_model.dart';
import 'package:xma_app1/Model/user_model.dart';

const String heroadd='Add Data';
class AddTodoPopupCard extends StatefulWidget {
  const AddTodoPopupCard({super.key});

  @override
  State<AddTodoPopupCard> createState() => _AddTodoPopupCardState();
}

class _AddTodoPopupCardState extends State<AddTodoPopupCard> {
  String newgender = "";
  final addkey = GlobalKey<FormState>();
  final unamecontroller = TextEditingController();
  final passcontroller = TextEditingController();
  final mnocontroller = TextEditingController();
  bool _isValid = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: addkey,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Hero(
            tag: heroadd,
            createRectTween: (begin, end) {
              return CustomRectTween(begin: begin!, end: end!);
            },
            child: Material(
              color: Colors.blueAccent,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                          children: [
                            TextFormField(
                              controller: unamecontroller,
                              decoration: const InputDecoration(
                                hintText: 'User Name',
                                border: InputBorder.none,
                              ),
                              cursorColor: Colors.white,
                            ),
                            const Divider(
                              color: Colors.white,
                              thickness: 0.2,
                            ),
                            TextFormField(
                              controller: passcontroller,
                              decoration: const InputDecoration(
                                hintText: 'Password',
                                border: InputBorder.none,
                              ),
                              cursorColor: Colors.white,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter password';
                                } else if (value.length < 8) {
                                  return 'Password must be 8 characters long';
                                }
                                return null;
                              },
                            ),
                            const Divider(
                              color: Colors.white,
                              thickness: 0.2,
                            ),
                            TextFormField(
                              controller: mnocontroller,
                              decoration: const InputDecoration(
                                hintText: 'Mobile No.',
                                border: InputBorder.none,
                              ),
                              cursorColor: Colors.white,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter 10 digit Phone Number';
                                } else if (value.length < 9) {
                                  return 'Phone Number must be of 10 digit long';
                                }
                                return null;
                              },
                            ),
                            const Divider(
                              color: Colors.white,
                              thickness: 0.2,
                            ),
                            Row(
                              children: [
                                const Text("Gender:", style: TextStyle(fontSize: 17.0),),
                                Expanded(
                                  child: RadioListTile(
                                      contentPadding: const EdgeInsets.only(left: 0.0, right: 10.0),
                                      title: const Text("Male", style: TextStyle(fontSize: 15.0),),
                                      value: "Male",
                                      groupValue: newgender,
                                      onChanged: (value) {
                                        setState(() {
                                          newgender = value!;
                                        });
                                      }
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile(
                                      contentPadding: const EdgeInsets.only(right: 10.0),
                                      title: const Text("Female", style: TextStyle(fontSize: 17.0),),
                                      value: "Female",
                                      groupValue: newgender,
                                      onChanged: (value) {
                                        setState(() {
                                          newgender = value!;
                                        });
                                      }
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              color: Colors.white,
                              thickness: 0.2,
                            ),
                            SizedBox(
                              height: 50.0,
                              width: 500.0,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    if (addkey.currentState!.validate()) {
                                      _isValid = true;
                                    } else {
                                      _isValid = false;
                                    }
                                  });
                                  if (_isValid) {
                                    try {
                                      var empdata = UserData();
                                      var data = user_model(
                                          uname: unamecontroller.text,
                                          password: passcontroller.text,
                                          mno: int.parse(mnocontroller.text),
                                          gender: newgender
                                      );
                                      empdata.userInsert(data);
                                      Navigator.pop(context);
                                    } catch (e) {
                                      // Handle the exception, show an error message or toast
                                      debugPrint(e.toString());
                                    }

                                  }
                                },
                                child: const Text("Add", style: TextStyle(fontSize: 20.0, color: Colors.black87),),
                              ),
                            )
                          ]
                      )
                  )
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DeleteTodoPopupCard extends StatefulWidget {
  const DeleteTodoPopupCard({super.key});

  @override
  DeleteTodoPopupCardState createState() => DeleteTodoPopupCardState();
}
class DeleteTodoPopupCardState extends State<DeleteTodoPopupCard> {
  final uidcontroller= TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: heroadd,
          createRectTween: (begin,end)
          {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
            color: Colors.blueAccent,
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        children: [
                          TextFormField(
                            controller: uidcontroller,
                            decoration: const InputDecoration(
                              hintText: 'Id',
                              border: InputBorder.none,
                            ),
                            cursorColor: Colors.white,
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 0.2,
                          ),
                          TextButton(
                            onPressed: (){
                              setState(() {
                                if (uidcontroller.text.isEmpty) {
                                  // Show an error message or toast
                                  return;
                                }
                                try {
                                  var empdata=UserData();
                                  var uid=int.parse(uidcontroller.text);
                                  empdata.userDelete(uid);
                                  Navigator.pop(context);
                                } catch (e) {
                                  // Handle the exception, show an error message or toast
                                  debugPrint("Error:-$e");
                                }
                              });

                            },
                            child: const Text("Delete",style:
                            TextStyle(fontSize: 20.0,color: Colors.black87),),),
                        ]
                    )
                )
            ),
          ),
        ),
      ),
    );
  }
}
class UpdateTodoPopupCard extends StatefulWidget {
  const UpdateTodoPopupCard({super.key});

  @override
  UpdateTodoPopupCardState createState() => UpdateTodoPopupCardState();
}

class UpdateTodoPopupCardState extends State<UpdateTodoPopupCard> {
  String updategender="";
  final idcontroller=TextEditingController();
  final updateunamecontroller= TextEditingController();
  final updatepasscontroller= TextEditingController();
  final updatemnocontroller= TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Hero(
          tag: heroadd,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },child: Material(
          color: Colors.blueAccent,
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)),
          child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                      children: [
                        TextFormField(
                          controller: idcontroller,
                          decoration: const InputDecoration(
                            hintText: 'ID',
                            border: InputBorder.none,
                          ),
                          cursorColor: Colors.white,
                        ),
                        const Divider(
                          color: Colors.white,
                          thickness: 0.2,
                        ),
                        TextFormField(
                          controller: updateunamecontroller,
                          decoration: const InputDecoration(
                            hintText: 'User Name',
                            border: InputBorder.none,
                          ),
                          cursorColor: Colors.white,
                        ),
                        const Divider(
                          color: Colors.white,
                          thickness: 0.2,
                        ),
                        TextFormField(
                          controller: updatepasscontroller,
                          decoration: const InputDecoration(
                            hintText: 'Password',
                            border: InputBorder.none,
                          ),
                          cursorColor: Colors.white,
                        ),
                        const Divider(
                          color: Colors.white,
                          thickness: 0.2,
                        ),
                        TextFormField(
                          controller: updatemnocontroller,
                          decoration: const InputDecoration(
                            hintText: 'Mobile No.',
                            border: InputBorder.none,
                          ),
                          cursorColor: Colors.white,
                        ),
                        const Divider(
                          color: Colors.white,
                          thickness: 0.2,
                        ),
                        Row(
                          children: [
                            const Text("Gender:",style: TextStyle(fontSize: 17.0),),
                            Expanded(
                              child:RadioListTile(
                                  contentPadding: const EdgeInsets.only(left: 0.0,right: 10.0),
                                  title: const Text("Male",style: TextStyle(fontSize: 15.0),),
                                  value: "Male",
                                  groupValue: updategender,
                                  onChanged: (value){
                                    setState(() {
                                      updategender=value!;
                                    });
                                  }
                              ),
                            ),
                            Expanded(
                              child: RadioListTile(
                                  contentPadding: const EdgeInsets.only(right:10.0),
                                  title: const Text("Female",style: TextStyle(fontSize: 17.0),),
                                  value: "Female",
                                  groupValue: updategender,
                                  onChanged: (value){
                                    setState(() {
                                      updategender=value!;
                                    });
                                  }
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.white,
                          thickness: 0.2,
                        ),
                        SizedBox(
                          height: 50.0,
                          child: TextButton(
                            onPressed: (){
                              setState(() {
                                if(idcontroller.text.isEmpty)
                                {
                                  return;
                                }
                                else if (updateunamecontroller.text.isEmpty || updatepasscontroller.text.isEmpty || updatemnocontroller.text.isEmpty) {
                                  return;
                                }
                                try {
                                  var empdata=UserData();
                                  int uid=int.parse(idcontroller.text);
                                  var data=user_model(
                                      uname: updateunamecontroller.text,
                                      password: updatepasscontroller.text,
                                      mno: int.parse(updatemnocontroller.text),
                                      gender: updategender
                                  );
                                  empdata.userUpdate(data,uid);
                                  Navigator.pop(context);
                                } catch (e) {
                                  // Handle the exception, show an error message or toast
                                  debugPrint(e.toString());
                                }
                              });
                            },
                            child: const Text("Update",style:
                            TextStyle(fontSize: 20.0,color: Colors.black87),),),
                        )
                      ]
                  )
              )
          ),
        ),
        ),
      ),
    );
  }
}

class Add_eventPopupCard extends StatefulWidget
{
  const Add_eventPopupCard({super.key});

  @override
  Add_eventPopupCardState createState()=> Add_eventPopupCardState();
}
class Add_eventPopupCardState extends State<Add_eventPopupCard> {
  final enamecontroller=TextEditingController();
  final edescriptioncotroller=TextEditingController();
  List<int> noavailable=List.generate(20, (index) => index+1);
  late int available=1;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Hero(
          tag: heroadd,
          createRectTween: (begin,end)
          {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
            color: Colors.blueAccent,
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)),
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        children: [
                          TextFormField(
                            controller: enamecontroller,
                            decoration: const InputDecoration(
                              hintText: 'Event Name',
                              border: InputBorder.none,
                            ),
                            cursorColor: Colors.white,
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 0.2,
                          ),
                          TextFormField(
                            controller: edescriptioncotroller,
                            decoration: const InputDecoration(
                              hintText: 'Description',
                              border: InputBorder.none,
                            ),
                            cursorColor: Colors.white,
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 0.2,
                          ),
                          Row(
                            children: [
                              const Padding(padding: EdgeInsetsDirectional.only(end: 60.0),
                              child: Text("Available",style: TextStyle(fontSize: 20.0),),),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 19.0),
                                width: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child:DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      borderRadius: BorderRadius.circular(30.0),
                                      value: available,
                                      isExpanded: true,
                                      iconSize: 30,
                                      items: noavailable.map((int number) {
                                        return DropdownMenuItem(
                                          value: number,
                                          child: Text(number.toString()),
                                        );
                                      }).toList(),
                                      onChanged: (int? value) {
                                        setState(() {
                                          available = value!;
                                        });
                                      },
                                    )
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 0.2,
                          ),
                          SizedBox(
                            height: 40.0,
                            width: 500.0,
                            child: TextButton(
                              onPressed: (){
                                setState(() {
                                  if (enamecontroller.text.isEmpty || edescriptioncotroller.text.isEmpty) {
                                    return;
                                  }
                                  else
                                    {
                                      try {
                                        var expodb=ExpoData();
                                        var expodata=expo_model(
                                            ename: enamecontroller.text,
                                            description: edescriptioncotroller.text,
                                            available: available);
                                        expodb.expoInsert(expodata);
                                        Navigator.pop(context);
                                      } catch (e) {
                                        // Handle the exception, show an error message or toast
                                        debugPrint(e.toString());
                                      }
                                    }
                                });

                              },
                              child: const Text("Add",style:
                              TextStyle(fontSize: 20.0,color: Colors.black87),),),
                          )
                        ]
                    )
                )
            ),
          ),
        ),
      ),
    );
  }
}
class Delete_eventPopupCard extends StatefulWidget {
  const Delete_eventPopupCard({super.key});

  @override
  Delete_eventPopupCardState createState() => Delete_eventPopupCardState();
}
class Delete_eventPopupCardState extends State<Delete_eventPopupCard> {
  final eidcontroller= TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: heroadd,
          createRectTween: (begin,end)
          {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
            color: Colors.blueAccent,
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        children: [
                          TextFormField(
                            controller: eidcontroller,
                            decoration: const InputDecoration(
                              hintText: 'Event Id',
                              border: InputBorder.none,
                            ),
                            cursorColor: Colors.white,
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 0.2,
                          ),
                          TextButton(
                            onPressed: (){
                              setState(() {
                                if (eidcontroller.text.isEmpty) {
                                  // Show an error message or toast
                                  return;
                                }
                                try {
                                  var expodb=ExpoData();
                                  var eid=int.parse(eidcontroller.text);
                                  expodb.expoDelete(eid);
                                } catch (e) {
                                  // Handle the exception, show an error message or toast
                                  debugPrint("Error:-$e");
                                }
                              });
                              Navigator.pop(context);
                            },
                            child: const Text("Delete",style:
                            TextStyle(fontSize: 20.0,color: Colors.black87),),),
                        ]
                    )
                )
            ),
          ),
        ),
      ),
    );
  }
}
class Update_eventPopupCard extends StatefulWidget {
  const Update_eventPopupCard({super.key});

  @override
  Update_eventPopupCardState createState() => Update_eventPopupCardState();
}

class Update_eventPopupCardState extends State<Update_eventPopupCard> {
  late TextEditingController eidcontroller=TextEditingController();
  late TextEditingController enamecontroller=TextEditingController();
  late TextEditingController edescriptioncotroller=TextEditingController();
  List<int> noavailable=List.generate(20, (index) => index+1);
  late int available=1;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Hero(
          tag: heroadd,
          createRectTween: (begin,end)
          {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
            color: Colors.blueAccent,
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)),
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        children: [
                          TextFormField(
                            controller: eidcontroller,
                            decoration: const InputDecoration(
                              hintText: 'Event ID',
                              border: InputBorder.none,
                            ),
                            cursorColor: Colors.white,
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 0.2,
                          ),
                          TextFormField(
                            controller: enamecontroller,
                            decoration: const InputDecoration(
                              hintText: 'Event Name',
                              border: InputBorder.none,
                            ),
                            cursorColor: Colors.white,
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 0.2,
                          ),
                          TextFormField(
                            controller: edescriptioncotroller,
                            decoration: const InputDecoration(
                              hintText: 'Description',
                              border: InputBorder.none,
                            ),
                            cursorColor: Colors.white,
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 0.2,
                          ),
                          Row(
                            children: [
                              const Padding(padding: EdgeInsetsDirectional.only(end: 60.0),
                                child: Text("Available",style: TextStyle(fontSize: 20.0),),),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 19.0),
                                width: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child:DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      borderRadius: BorderRadius.circular(30.0),
                                      value: available,
                                      isExpanded: true,
                                      iconSize: 30,
                                      items: noavailable.map((int number) {
                                        return DropdownMenuItem(
                                          value: number,
                                          child: Text(number.toString()),
                                        );
                                      }).toList(),
                                      onChanged: (int? value) {
                                        setState(() {
                                          available = value!;
                                        });
                                      },
                                    )
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 0.2,
                          ),
                          SizedBox(
                            height: 40.0,
                            width: 500.0,
                            child: TextButton(
                              onPressed: (){
                                setState(() {
                                  if (enamecontroller.text.isEmpty || edescriptioncotroller.text.isEmpty) {
                                    return;
                                  }
                                  else
                                  {
                                    try {
                                      int eid=int.parse(eidcontroller.text);
                                      var expodb=ExpoData();
                                      var expodata=expo_model(
                                          ename: enamecontroller.text,
                                          description: edescriptioncotroller.text,
                                          available: available);
                                      expodb.expoUpdate(expodata,eid);
                                      Navigator.pop(context);
                                    } catch (e) {
                                      // Handle the exception, show an error message or toast
                                      debugPrint(e.toString());
                                    }
                                  }
                                });
                              },
                              child: const Text("Update",style:
                              TextStyle(fontSize: 20.0,color: Colors.black87),),),
                          )
                        ]
                    )
                )
            ),
          ),
        ),
      ),
    );
  }
}
/*final enamecontroller=TextEditingController();
  final eidcontroller=TextEditingController();
  final edescriptioncotroller=TextEditingController();
  List<int> noavailable=List.generate(20, (index) => index+1);
  late int available=1;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Hero(
          tag: heroadd,
          createRectTween: (begin,end)
          {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
            color: Colors.blueAccent,
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)),
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        children: [
                          TextFormField(
                            controller: eidcontroller,
                            decoration: const InputDecoration(
                              hintText: 'Event Name',
                              border: InputBorder.none,
                            ),
                            cursorColor: Colors.white,
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 0.2,
                          ),
                          TextFormField(
                            controller: enamecontroller,
                            decoration: const InputDecoration(
                              hintText: 'Event Name',
                              border: InputBorder.none,
                            ),
                            cursorColor: Colors.white,
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 0.2,
                          ),
                          TextFormField(
                            controller: edescriptioncotroller,
                            decoration: const InputDecoration(
                              hintText: 'Description',
                              border: InputBorder.none,
                            ),
                            cursorColor: Colors.white,
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 0.2,
                          ),
                          Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              width: 90,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Row(
                                children: [
                                  const Text("Available:"),
                                   DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      borderRadius:BorderRadius.circular(30.0),
                                      value: available,
                                      isExpanded: true,
                                      iconSize: 30,
                                      items: noavailable.map((int number)
                                      {
                                        return DropdownMenuItem(
                                          value: number,
                                          child: Text(number.toString()),
                                        );
                                      }).toList(),
                                      onChanged: (int? value) {
                                        setState(() {
                                          available=value!;
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 0.2,
                          ),
                          TextButton(
                              onPressed: (){
                                setState(() {
                                  if (enamecontroller.text.isEmpty || edescriptioncotroller.text.isEmpty) {
                                    return;
                                  }
                                  else
                                  {
                                    try {
                                      var expodb=ExpoData();
                                       int eid=int.parse(eidcontroller.text);
                                      var expodata=expo_model(
                                          ename: enamecontroller.text,
                                          description: edescriptioncotroller.text,
                                          available: available);
                                      expodb.expoUpdate(expodata,eid);
                                      Navigator.pop(context);
                                    } catch (e) {
                                      // Handle the exception, show an error message or toast
                                      debugPrint(e.toString());
                                    }
                                  }
                                });
                              },
                              child: const Text("Add",style:
                              TextStyle(fontSize: 20.0,color: Colors.black87),),),
                        ]
                    )
                )
            ),
          ),
        ),
      ),
    );*/