// ignore_for_file: camel_case_types

class expo_model
{
  int? eid;
  late String ename;
  late String description;
  late int available;
  expo_model({this.eid,
    required this.ename,
    required this.description,
    required this.available
  });

  expo_model.fromMap(Map map)
  {
    eid=map["eid"];
    ename=map["ename"];
    description=map["description"];
    available=map["available"];
  }
}