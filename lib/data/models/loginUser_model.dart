class UserM {
  const UserM({
    required this.id,
    required this.username,
    required this.email,
    this.firstName,
    this.lastName,
    this.gender,
    required this.image,
    required this.accessToken,
  });

  final int? id;
  final String? username;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? image;
  final String? accessToken;

  factory UserM.fromJson(Map<String, dynamic> json) {
    return UserM(
      id: json["id"],
      username: json["username"],
      email: json["email"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      gender: json["gender"],
      image: json["image"],
      accessToken: json["accessToken"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "image": image,
        "accessToken": accessToken,
      };
}
