class User {
  final int? userId;
  final String? firstName;
  final String? lastName;
  final String? dni;
  final String? email;
  final String? rol;
  final String? sex;
  final String? birthDate;
  final String? phone;
  final String? registerDate;

  User({this.userId, this.firstName, this.lastName, this.dni, this.email, this.rol, this.sex,
    this.birthDate, this.phone, this.registerDate});

  factory User.fromJson(dynamic json) {

    Map<String, dynamic> userJson = json;
    return User(
      userId: userJson['userId'],
      firstName: userJson['firstName'].toString(),
      lastName: userJson['lastName'].toString(),
      dni: userJson['dni'].toString(),
      email: userJson['email'].toString(),
      rol: userJson['rol'],
      sex: userJson['sex'],
      birthDate: userJson['birthDate'],
      phone: userJson['phone'],
      registerDate: userJson['registerDate'],
    );
  }
}
