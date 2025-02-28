import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:plumber_manager/model/kaamgarmodel.dart';
import 'package:plumber_manager/view-model/kaamhgarprovider.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

class KaamGarScreen extends StatefulWidget {
  const KaamGarScreen({super.key});

  @override
  _KaamGarScreenState createState() => _KaamGarScreenState();
}

class _KaamGarScreenState extends State<KaamGarScreen> {
  @override
  Widget build(BuildContext context) {
    final kaamgarList = Provider.of<KaamGarProvider>(context).kaamGarList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('कामगार यादी'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: kaamgarList.isEmpty
            ? const Center(child: Text("कोणतेही कामगार नाहीत"))
            : ListView.builder(
                itemCount: kaamgarList.length,
                itemBuilder: (context, index) {
                  final kaamgar = kaamgarList[index];
                  print("Each Kamgar Is : $kaamgar");
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(kaamgar.toString()),
                      leading: const Icon(Icons.person, color: Colors.red),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _requestPermission(context),
        backgroundColor: Colors.red,
        child: const Icon(Icons.contacts),
      ),
    );
  }

  Future<void> _requestPermission(BuildContext context) async {
    if (await Permission.contacts.request().isGranted) {
      _pickContact(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Contacts permission is required!")),
      );
    }
  }

  Future<void> _pickContact(BuildContext context) async {
    try {
      Contact? contact = await FlutterContacts.openExternalPick();
      if (contact != null && contact.phones.isNotEmpty) {
        String name = contact.displayName ?? "अनोळखी";
        String phone = contact.phones.first.number ?? "0000000000";

        // Ensure phoneNumber is a string (removing non-numeric characters)
        String formattedPhone = phone.replaceAll(RegExp(r'\D'), '');
        print("Name And Phone Is : $name And $phone");
        Provider.of<KaamGarProvider>(context, listen: false).addKaamGar(
          KaamGarModel(
            name: name,
            phoneNumber: formattedPhone, // Store as String
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to pick contact: $e")),
      );
    }
  }
}
