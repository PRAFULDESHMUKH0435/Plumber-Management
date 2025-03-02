import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:plumber_manager/model/kaamgarmodel.dart';
import 'package:telephony/telephony.dart';

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

  Map<String, String> splitNamePhone(String namePhone) {
    List<String> parts = namePhone.split('-');

    if (parts.length == 2) {
      return {
        'name': parts[0].trim(),
        'phone': parts[1].trim(),
      };
    } else {
      throw FormatException("Invalid format. Expected 'Name-PhoneNumber'");
    }
  }

  /// ✅ **Added markAttendance function**
  Future<void> markAttendance(BuildContext context, String namePhoneMap,
      DateTime date, String location) async {
    final kaamGar = Hive.box("KaamGarBox").get(namePhoneMap);
    print("KaamGar Data Name And Phone Map Is : $namePhoneMap");

    print(
        "Work History Model Of $namePhoneMap Is : ${Hive.box("KaamGarBox").get(namePhoneMap)}");
    List<dynamic> workitem = [true, date.toIso8601String(), location];

    List existingworklist = Hive.box("KaamGarBox").get(namePhoneMap);
    existingworklist.add(workitem);
    print("Newly Created Work List Is : $existingworklist");
    await Hive.box("KaamGarBox").put(namePhoneMap, kaamGar);
    _kaamGarList = Hive.box("KaamGarBox").keys.toList();
    sendSMS(context, namePhoneMap);
    notifyListeners();
  }

  final Telephony telephony = Telephony.instance;

  Future<void> sendSMS(BuildContext context, String namePhoneMap) async {
    bool? permissionsGranted = await telephony.requestPhoneAndSmsPermissions;

    Map<String, String> result = splitNamePhone(namePhoneMap);
    String name = result['name'] ?? "Unknown";
    String phone = result['phone'] ?? "Unknown";
    print("Name: ${result['name']}");
    print("Phone: ${result['phone']}");

    if (permissionsGranted ?? false) {
      telephony.sendSms(
        to: phone,
        message: "$name, तुमची उपस्थिती दिनांक ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} रोजी नोंदवली गेली आहे",
      );
      print("SMS Sent to $phone");
    } else {
      print("SMS Permission Denied");
    }
  }
}
