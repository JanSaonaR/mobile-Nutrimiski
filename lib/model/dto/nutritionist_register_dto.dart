class NutritionistRegisterDto{
  final String firstName;
  final String lastName;
  final String dni;
  final String email;
  final String password;
  final String birthDate;
  final String phone;
  final String sex;
  final String collegiate;

  NutritionistRegisterDto(this.firstName, this.lastName, this.dni, this.email, this.password, this.birthDate, this.phone, this.sex, this.collegiate);

  Map toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'dni' : dni,
    'email' : email,
    'password' : password,
    'birthDate' : birthDate,
    'phone' : phone,
    'sex' : sex,
    'collegiate': collegiate
  };
}