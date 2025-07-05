import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:plumber_manager/Utils/kaamgarmodeladapter.dart';
import 'package:plumber_manager/view-model/counterprovider.dart';
import 'package:plumber_manager/view-model/kaamgarprovider.dart';
import 'package:plumber_manager/view/counter.dart';
import 'package:plumber_manager/view/homescreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(KaamGarHiveAdapter());
  Hive.registerAdapter(KaamGarWorkHiveAdapter());
  await Hive.openBox('KaamGarBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => KaamGarProvider()),
        ChangeNotifierProvider(create: (_) => CounterProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Plumber Manager',
        theme: ThemeData(
          primarySwatch: Colors.red,
          scaffoldBackgroundColor: Colors.white,
        ),
        // ✅ Add localization delegates
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', ''), // English
          Locale('mr', ''), // Marathi
        ],
        home: const CounterScreen(),
      ),
    );
  }
}
