class User {
  String? name;
  String? email;
  String? password;

  User({
    this.name,
    this.email,
    this.password,
  });

  factory User.fromMap(Map<String, String> mp) {
    return User(
      name: mp["name"],
      email: mp["email"],
      password: mp["password"],
    );
  }

  Map<String, String> toMap(){
    return {
      "name" :  name!,
      "email" : email!, 
      "password" : password!,
    };
  }
}
