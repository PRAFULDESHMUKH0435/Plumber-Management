import 'package:hive/hive.dart';

@HiveType(typeId: 1) // Ensure a unique typeId
class KaamGarModel {
  @HiveField(0)
  String phoneNumber; // Changed from double to String

  @HiveField(1)
  String name;

  @HiveField(2)
  List<KaamGarWorkModel> workHistory;

  KaamGarModel({
    required this.phoneNumber,
    required this.name,
    this.workHistory = const [],
  });
}

@HiveType(typeId: 2)
class KaamGarWorkModel {
  @HiveField(0)
  bool isWorked;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  String location;

  KaamGarWorkModel({
    required this.isWorked,
    required this.date,
    required this.location,
  });
}
