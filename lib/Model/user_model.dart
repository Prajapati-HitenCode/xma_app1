
class user_model
{
   int? uid;
   int? mno;
  late String uname,password,gender;
  user_model({
    this.uid,
    required this.uname,
    required this.password,
    required this.mno,
    required this.gender,
  });

  user_model.fromMap(Map map)
  {
    uid=map["uid"];
    uname=map["uname"];
    password=map["password"];
    mno=map["mno"];
    gender=map["gender"];
  }
}