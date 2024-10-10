class ClientRegister {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? password;
  String? phoneNumber;
  int? age;
  int? sexuallyId;
  String? sexually;
  int? countryId;
  String? country;
  int? maritalStateId;
  String? maritalState;

  // ClientRegister(
  //     {this.firstName,
  //     this.lastName,
  //     this.username,
  //     this.email,
  //     this.password,
  //     this.phoneNumber,
  //     this.age,
  //     this.sexuallyId,
  //     this.countryId,
  //     this.maritalStateId});

  ClientRegister.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    firstName = json['firstName'] ?? "";
    lastName = json['lastName'] ?? "";
    username = json['username'] ?? "";
    email = json['email'] ?? "";
    password = json['password'] ?? "";
    phoneNumber = json['phoneNumber'] ?? "";
    age = json['age'] ?? 0;
    sexuallyId = json['sexuallyId'] ?? 0;
    sexually = json['sexually'] ?? "";
    countryId = json['countryId'] ?? 0;
    country = json['country'] ?? "";
    maritalStateId = json['marital_StateId'] ?? 0;
    maritalState = json['maritalState'] ?? "";
  }
}
