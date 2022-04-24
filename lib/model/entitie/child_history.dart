class ChildHistory{
  final int? childId;
  final int? age;
  final DateTime? date;
  final double? height;
  final double? weight;
  final double? imc;

  ChildHistory({this.childId, this.age, this.date, this.height, this.weight, this.imc});

  factory ChildHistory.fromJson(dynamic json) {

    Map<String, dynamic> childHistoryJson = json;
    return ChildHistory(
        childId: childHistoryJson['childLogId'],
        age: childHistoryJson['age'],
        date: DateTime.parse(childHistoryJson['date']),
        height: childHistoryJson['height'],
        weight: childHistoryJson['weight'],
        imc: childHistoryJson['imc']
    );
  }
}
