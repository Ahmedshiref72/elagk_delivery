class RegisterModel {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  List<String>? phones;
  List? roles;

  RegisterModel(
      {this.firstName,
        this.lastName,
        this.email,
        this.password,
        this.phones,
        this.roles});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    phones = json['phones'];
    roles = json['roles'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;

    data['email'] = email;
    data['password'] = password;
    data['phones'] = phones;
    data['roles'] = roles;

    return data;
  }
}

