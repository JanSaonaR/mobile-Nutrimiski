class AlternativeMealDto {
  final double? calories;
  final String? schedule;

  AlternativeMealDto({this.calories, this.schedule});

  Map toJson() => {
    'calories': calories,
    'schedule': schedule
  };

}