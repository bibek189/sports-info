import 'package:SportsInfo/pages/home.dart';
import 'package:SportsInfo/providers/sports_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() =>
  runApp(MultiProvider(
    providers:[
      ChangeNotifierProvider<SportsProvider>.value(value: SportsProvider()),
    ],
    child: MyApp()));


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}