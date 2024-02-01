import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screens/Common/expenseprovider.dart';
import 'Screens/Common/themeprovider.dart';
import 'Screens/HomePage/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ExpenseProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter App ',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // brightness: Brightness.,
          primarySwatch: Colors.blue,
          // brightness: Provider.of<ThemeProvider>(context).isDarkMode
          //     ? Brightness.dark
          //     : Brightness.light,
        ),
        home: const Homepage(),
      ),
    );
  }
}
