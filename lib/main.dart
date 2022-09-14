// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_note/providers/category_provider.dart';
import 'package:my_note/providers/notes_provider.dart';
import 'package:my_note/ui/home.dart';
import 'package:my_note/ui/note_editor.dart';
import 'package:my_note/ui/splahscreen.dart';
import 'package:my_note/services/sl.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NotesProvider()..readFromStorage(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyNote',
        darkTheme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          primaryColor: Colors.white,
          buttonColor: Color.fromRGBO(112, 237, 238, 5),
          unselectedWidgetColor: Color.fromRGBO(46, 46, 46, 6),
          disabledColor: Color.fromRGBO(182, 182, 182, 50),
          brightness: Brightness.light,
          textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'SFUI'),
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
          }),
        ),
        theme: ThemeData(
          brightness: Brightness.light,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.purple,
          ),
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.black,
          unselectedWidgetColor: Color.fromRGBO(235, 235, 235, 1),
          buttonColor: Colors.lightBlueAccent,
          disabledColor: Colors.grey.shade300,
          fontFamily: 'SFUI',
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
          }),
        ),
        home: Splash(),
        routes: {
          '/home': (BuildContext context) => MyHomePage(),
          // '/lockscreen': (BuildContext context) => LockScreen(note:),
          '/workspace': (BuildContext context) => NoteEditor(),
        },
      ),
    );
  }
}
