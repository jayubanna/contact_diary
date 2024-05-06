import 'package:contact_diary/view/contact_page.dart';
import 'package:contact_diary/view/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'controller/contact_provider.dart';
import 'view/detail_page.dart';
import 'view/home_page.dart';
import 'controller/logic_provider.dart';

final lightTheme=ThemeData(
    brightness: Brightness.light,
    textTheme: TextTheme(
        bodyLarge: TextStyle(
            color: Colors.black
        )
    )
);
final darkTheme=ThemeData(
    brightness: Brightness.dark,
    textTheme: TextTheme(
        bodyLarge: TextStyle(
            color: Colors.white
        )
    )
);

void main()
{
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => ContactProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: Provider.of<ThemeProvider>(context).getThemeMode(),            initialRoute: "/",
            routes: {
              "/": (context) => SplashScreen(),
              "home_page":(context) => Home(),
              "detail_page": (context) => DetailPage(),
              "contact_page":(context) => ContactPage(),
            },
          );
        },
      ),
    );
  }
}

