class AlternativeMealDto {
  final double? calories;
  final String? type;

  AlternativeMealDto({this.calories, this.type});

  Map toJson() => {
    'calories': calories,
    'type': type
  };

}