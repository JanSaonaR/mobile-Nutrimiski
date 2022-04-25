class ParentRegisterDto{
  String firstName;
  String lastName;
  String dni;
  String email;
  String password;
  String birthDate;
  String phone;
  String sex;

  ParentRegisterDto(this.firstName, this.lastName, this.dni, this.email, this.password, this.birthDate, this.phone, this.sex);

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'dni' : dni,
    'email' : email,
    'password' : password,
    'birthDate' : birthDate,
    'phone' : phone,
    'sex' : sex
  };
}