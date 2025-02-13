/// name : "user"
/// email : "suer@foe.com"
/// password : "user@1234"
class RegisterModel {
  String? name;
  String? email;
  String? password;

  RegisterModel(this.name, this.email, this.password);

  Map<String,dynamic> toJson() {
    Map<String,dynamic> data={};
    data['name']=name;
    data['email']=email;
    data['password']=password;
    return data;
  }
}