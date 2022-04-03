import 'package:mobile_nutrimiski/model/entitie/parent_child.dart';
import 'package:mobile_nutrimiski/model/entitie/picture.dart';

class Child {
  final int? childId;
  final String? firstName;
  final String? lastName;
  final String? dni;
  final double? height;
  final double? weight;
  final String? sex;
  final String? birthDate;
  final double? imc;
  final int? age;
  final ParentChild? parent;
  final Picture? picture;

  Child({this.childId, this.firstName, this.lastName, this.dni, this.height, this.weight, this.sex,
    this.birthDate, this.imc, this.age, this.parent, this.picture});

  factory Child.fromJson(dynamic json) {

    Map<String, dynamic> childJson = json;
    return Child(
      childId: childJson['childId'],
      firstName: childJson['firstName'].toString(),
      lastName: childJson['lastName'].toString(),
      dni: childJson['dni'].toString(),
      height: childJson['height'],
      weight: childJson['weight'],
      sex: childJson['sex'],
      birthDate: childJson['birthDate'],
      imc: childJson['imc'],
      age: childJson['age'],
      parent: ParentChild.fromJson(childJson['parent']),
      //picture: Picture.fromJson(childJson['picture'])
    );
  }
}