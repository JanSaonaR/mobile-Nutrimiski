class ChildRegisterDto{
  final String firstName;
  final String lastName;
  final String dni;
  final String birthDate;
  final String sex;
  final double weight;
  final double height;
  final double imc;

  ChildRegisterDto(this.firstName, this.lastName, this.dni, this.birthDate, this.sex, this.weight, this.height, this.imc);

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'dni' : dni,
    'birthDate' : birthDate,
    'sex' : sex,
    'weight' : weight,
    'height' : height,
    'imc': imc
  };
  
}