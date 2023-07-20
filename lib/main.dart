import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hexcolor/hexcolor.dart';
import 'Screens/Splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
  runApp(ECommerceApp(isDarkTheme: isDarkTheme));
}

class ECommerceApp extends StatelessWidget {
  final bool isDarkTheme;
  const ECommerceApp({super.key,required this.isDarkTheme});

  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.amber,
            appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
            textTheme: const TextTheme(
              bodyText1: TextStyle(color: Colors.black45),
            ),
          ),
          darkTheme: ThemeData(
            hintColor: Colors.white,
            inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(color: Colors.white),
              suffixStyle: TextStyle(color: Colors.white),
              iconColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            // outlinedButtonTheme: OutlinedButtonThemeData(style: ButtonStyle()),
            textSelectionTheme: TextSelectionThemeData(
              selectionColor: Colors.white,
            ),
            checkboxTheme: CheckboxThemeData(
              fillColor: MaterialStatePropertyAll(Colors.deepOrangeAccent),
            ),
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            scaffoldBackgroundColor: HexColor('333739'),
            buttonTheme: ButtonThemeData(buttonColor: Colors.white),
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                iconColor: MaterialStatePropertyAll(Colors.white),
                textStyle: MaterialStatePropertyAll(
                  TextStyle(color: Colors.white),
                ),
              ),
            ),
            textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
          ),
          themeMode: currentMode,
          // Fix this error [When the keyboard appears, the Flutter widgets resize.]
          home:  SplashScreen(),
        );

        },
    );

    // )

  }
}