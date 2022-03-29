import 'package:mobile_nutrimiski/model/entitie/child.dart';
import 'package:mobile_nutrimiski/model/entitie/user.dart';

class Parent {
  final int? parentId;
  final User? user;
  final List<Child>? children;


  Parent({this.parentId, this.user, this.children});

  factory Parent.fromJson(dynamic json) {

    Map<String, dynamic> parentJson = json;
    return Parent(
      parentId: parentJson['userId'],
      user: User.fromJson(parentJson['user']),
      children: parentJson['children'].map((e) => Child.fromJson(e)).toList()
    );
  }
}