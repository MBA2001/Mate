class User {
  final String uid;
  final String? email;
  String? username;

  User(this.uid,this.email);


  setUsername(String name){
    username = name;
  }
}