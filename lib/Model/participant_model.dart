class participant_model
{
  late int no_of_booth,no_of_member,pmno;
  int? pid;
  late String pname;
  participant_model({this.pid,
    required this.pname,
    required this.no_of_booth,
    required this.no_of_member,
    required this.pmno});

  participant_model.fromMap(Map map)
  {
    pid=map["pid"];
    pname=map["pname"];
    no_of_booth=map["no_of_booth"];
    no_of_member=map["no_of_member"];
    pmno=map["pmno"];
  }
}
