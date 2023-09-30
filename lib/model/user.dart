class User {
  int? id;
  String? name;
  String? email;
  String? passwrod;
  String? phoneNumber;
  bool? emailverified;
  bool? phoneverified;

  User(
      {this.id,
        this.name,
        this.email,
        this.passwrod,
        this.phoneNumber,
        this.emailverified,
        this.phoneverified});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    passwrod = json['passwrod'];
    phoneNumber = json['phoneNumber'];
    emailverified = json['emailverified']==1?true:false;
    phoneverified = json['phoneverified']==1?true:false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['passwrod'] = this.passwrod;
    data['phoneNumber'] = this.phoneNumber;
    data['emailverified'] = this.emailverified==true?"1":"0";
    data['phoneverified'] = this.phoneverified==true?"1":"0";
    return data;
  }
}