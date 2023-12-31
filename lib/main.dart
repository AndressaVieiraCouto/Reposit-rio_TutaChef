import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tutachef_project/views/pages_view.dart';

import 'controllers/home_controller.dart';

void main() {
  // Inicialize o Flutter primeiro

  WidgetsFlutterBinding.ensureInitialized();

  // Defina a orientação retrato
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      ChangeNotifierProvider<HomeController>(
        create: (context) => HomeController(),
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tutachef',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      //home: const ProfileView()
      home: PagesView(
        controller: HomeController(),
      ),
    );
  }
}
