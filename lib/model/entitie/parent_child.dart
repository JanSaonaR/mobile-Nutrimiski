class ParentChild {
  final int? parentId;

  ParentChild({this.parentId});

  factory ParentChild.fromJson(dynamic json) {

    Map<String, dynamic> parentJson = json;
    return ParentChild(
        parentId: parentJson['parentId']
    );
  }
}