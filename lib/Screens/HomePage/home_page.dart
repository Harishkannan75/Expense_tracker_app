import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:focus_detector/focus_detector.dart';

import '../Add Expenses/add_expenses_popup_widget.dart';
import '../Common/expencecategoriclass.dart';
import '../Common/expenseprovider.dart';
import '../Common/themeprovider.dart';
import '../viewa All/view_all.dart';
import 'Home page Widgets/home_page_categorie.dart';
import 'Home page Widgets/home_page_category_list.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DateTime selectDate = DateTime.now();
  final List<ExpenseCategory> categories = [
    ExpenseCategory(
        categoriesName: "Medical",
        categoriesimageAssetPath: "Assets/medical.svg"),
    ExpenseCategory(
        categoriesName: "Shopping",
        categoriesimageAssetPath: "Assets/shopping.svg"),
    ExpenseCategory(
      categoriesName: "Food",
      categoriesimageAssetPath: "Assets/food.svg",
    ),
    ExpenseCategory(
      categoriesName: "others",
      categoriesimageAssetPath: "Assets/others.svg",
    )
  ];

  @override
  Widget build(BuildContext context) {
    final expenses = Provider.of<ExpenseProvider>(context).expenses;
    double totalExpenses =
        Provider.of<ExpenseProvider>(context).calculateTotalExpenses();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          "Hello",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  // showDialog(
                  //     context: context,
                  //     builder: (context) {
                  //       return const Getusername();
                  //     });
                },
                child: const Icon(
                  Icons.person_add_rounded,
                  color: Colors.black,
                  size: 26.0,
                ),
              )),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                //----------------------------
              },
              child: const Icon(
                Icons.notifications_active,
                color: Colors.black,
              ),
            ),
          ),
          // Consumer<ThemeProvider>(
          //     builder: (context, themeProvider, child) => Switch(
          //           value: themeProvider.isDarkMode,
          //           onChanged: (value) {
          //             themeProvider.toggleTheme(value);
          //           },
          //         )),
        ],
      ),
      body: Consumer<ExpenseProvider>(
        builder: (context, expencesmodel, child) => FocusDetector(
          onFocusGained: () async {
            await expencesmodel.fetchExpenseData();
            expencesmodel.calculateTotalByCategory(categories.toString());
          },
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: height * 0.03,
                ),
                Container(
                  height: height * 0.15,
                  width: width * 0.90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                        image: AssetImage("Assets/background.jpg.webp"),
                        fit: BoxFit.fill),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.02,
                      ),
                      const Text(
                        "Total Expenses",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        "₹ ${totalExpenses.toStringAsFixed(2)}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Categories",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.0,
                ),
                Homepagecategoriewidget(
                  categories: categories,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Latest Entriens",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Viewallpage()));
                        },
                        child: const Text(
                          "View all",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.0,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Container(
                  child: expenses.isNotEmpty
                      ? const Divider(
                          endIndent: 10,
                          indent: 10,
                          color: Colors.grey,
                          thickness: 1,
                        )
                      : null,
                ),
                // SizedBox(
                //   height: height * 0.0,
                // ),
                SizedBox(
                    height: height * 0.50,
                    child: HomePageCategoryList(expenses: expenses)),
                SizedBox(
                  height: height * 0.01,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: height * 0.09,
        color: Colors.grey[500],
        child: InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Addexpensedialogs();
                });
          },
          child: Center(
            child: Container(
              height: height * 0.07,
              width: width * 0.90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.green[500]),
              child: const Center(
                child: Text(
                  "Add Expenses",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
