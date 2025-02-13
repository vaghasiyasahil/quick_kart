/// email : "suer@foe.com"
/// password : "user@1234"
class LoginModel {
  String? email;
  String? password;

  LoginModel(this.email, this.password);

  Map<String,dynamic> toJson() {
    Map<String,dynamic> data={};
    data['email']=email;
    data['password']=password;
    return data;
  }
}