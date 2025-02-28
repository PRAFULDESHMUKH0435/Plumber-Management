import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:plumber_manager/model/kaamgarmodel.dart';

class KaamGarProvider extends ChangeNotifier {
  List<dynamic> _kaamGarList = Hive.box("KaamGarBox").keys.toList();
  final String _hiveBoxName = 'KaamGarBox';
  List<dynamic> get kaamGarList => _kaamGarList;

  Future<void> addKaamGar(KaamGarModel kaamGar) async {
    final box = await Hive.openBox("KaamGarBox");
    await box.put("${kaamGar.name}-${kaamGar.phoneNumber}", []);
    _kaamGarList = box.keys.toList();
    print("KamGar List Is : ${_kaamGarList.length}");
    notifyListeners();
  }

  /// ✅ **Added markAttendance function**
  Future<void> markAttendance(
      String namePhoneMap, DateTime date, String location) async {
    final kaamGar = Hive.box("KaamGarBox").get(namePhoneMap);
    print("KaamGar Data Name And Phone Map Is : $namePhoneMap");
    print(
        "Work History Model Of $namePhoneMap Is : ${Hive.box("KaamGarBox").get("${namePhoneMap}")}");
    List<dynamic> workitem = [true, date.toIso8601String(), location];

    List existingworklist = Hive.box("KaamGarBox").get(namePhoneMap);
    existingworklist.add(workitem);
    print("Newly Created Work List Is : ${existingworklist}");
    await Hive.box("KaamGarBox").put(namePhoneMap, kaamGar);
    _kaamGarList = Hive.box("KaamGarBox").keys.toList();
    notifyListeners();
  }
}
