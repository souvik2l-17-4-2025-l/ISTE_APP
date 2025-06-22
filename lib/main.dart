import 'package:flutter/material.dart';
import 'package:iste_app/pages/domainspage.dart';
import 'package:iste_app/pages/homepage.dart';
import 'package:iste_app/pages/loginPage.dart';
import 'package:iste_app/pages/navigationpage.dart';
import 'package:iste_app/theme/theme.dart';
import 'package:iste_app/theme/themeprovider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) {
              themeprovider t = themeprovider();
              return t;
            },
          )
        ],
        child: Consumer<themeprovider>(
          builder: (context, t, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'ISTE APP',
              theme: lightmode,
              darkTheme: darkmode,
              themeMode: t.themeMode,
              home: navigationpage(),//domainspage(userRole: UserRole.mancom),
        ),
        )
    );

  }
}
