class UserUID{
  final String uid;
  UserUID({required this.uid});
}

class UserData{
  final String uid;
  final String sugars;
  final String name;
  final int strength;

  UserData({required this.sugars,required this.name,required this.strength,required this.uid});

}