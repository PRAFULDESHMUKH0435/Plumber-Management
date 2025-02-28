import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class KaamGarHiveModel {
  @HiveField(0)
  double phoneNumber;

  @HiveField(1)
  String name;

  @HiveField(2)
  List<KaamGarWorkHiveModel> workHistory;

  KaamGarHiveModel({
    required this.phoneNumber,
    required this.name,
    required this.workHistory,
  });
}

@HiveType(typeId: 1)
class KaamGarWorkHiveModel {
  @HiveField(0)
  bool isWorked;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  String location;

  KaamGarWorkHiveModel({
    required this.isWorked,
    required this.date,
    required this.location,
  });
}

class KaamGarHiveAdapter extends TypeAdapter<KaamGarHiveModel> {
  @override
  final int typeId = 0;

  @override
  KaamGarHiveModel read(BinaryReader reader) {
    return KaamGarHiveModel(
      phoneNumber: reader.readDouble(),
      name: reader.readString(),
      workHistory: (reader.read() as List).cast<KaamGarWorkHiveModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, KaamGarHiveModel obj) {
    writer.writeDouble(obj.phoneNumber);
    writer.writeString(obj.name);
    writer.write(obj.workHistory);
  }
}

class KaamGarWorkHiveAdapter extends TypeAdapter<KaamGarWorkHiveModel> {
  @override
  final int typeId = 1;

  @override
  KaamGarWorkHiveModel read(BinaryReader reader) {
    return KaamGarWorkHiveModel(
      isWorked: reader.readBool(),
      date: reader.read(),
      location: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, KaamGarWorkHiveModel obj) {
    writer.writeBool(obj.isWorked);
    writer.write(obj.date);
    writer.writeString(obj.location);
  }
}
