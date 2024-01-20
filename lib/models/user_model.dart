class UserModel {
  final String name;
  final String email;
  final String phoneNumber;
  final String password;
  final String userName;
  final String? country;

  UserModel({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.userName,
    this.country
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['Name'],
      email: json['Email'],
      phoneNumber: json['phone_number'],
      password: json['Password'],
      userName: json['UserName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Name": name,
      "Email": email,
      "phone_number": phoneNumber,
      "Password": password,
      "UserName": userName,
      "Country": country,
    };
  }
}