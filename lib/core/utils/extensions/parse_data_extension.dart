extension ParseDataExtension on String {
  int get parseToInt => int.parse(this);
  DateTime get parseToDateTime => DateTime.parse(this);
}
