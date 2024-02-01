import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Common/expenseclass.dart';
import '../Common/expenseprovider.dart';

class Addexpensedialogs extends StatefulWidget {
  Addexpensedialogs({
    super.key,
  });

  @override
  State<Addexpensedialogs> createState() => _AddexpensedialogsState();
}

class _AddexpensedialogsState extends State<Addexpensedialogs> {
  DateTime selectedDate = DateTime.now();

  Future<void> datePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  final formKey = GlobalKey<FormState>();
  var currencies = ["Select one", "Medical", "Shopping", "Food", "Others"];
  String selectedCategory = "Select one";
  TextEditingController amountcontroller = TextEditingController();
  TextEditingController categorynamecontroller = TextEditingController();
  Future<void> savefrom(BuildContext context) async {
    final String category = selectedCategory;
    final double amount = double.tryParse(amountcontroller.text) ?? 0;
    final DateTime date = selectedDate;
    final String categoryName = categorynamecontroller.text;
    if (amount > 0 && category != "Select one") {
      final Expense expense = Expense(category, amount, date, categoryName);
      Provider.of<ExpenseProvider>(context, listen: false).addExpense(expense);
      amountcontroller.clear();
      categorynamecontroller.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('saved successfully.'),
        ),
      );
    } else if (category == "Select one") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid. Please select any category.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.cancel),
                    alignment: Alignment.centerRight,
                    color: Colors.grey,
                  ),
                ),
                const Text(
                  "Add Expences",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Categorie",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      )),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(15)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    dropdownColor: Colors.white,
                    value: selectedCategory,
                    isExpanded: true,
                    validator: (String? values) {
                      if (values!.isEmpty) {
                        return "can't empty";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (String? value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                    items: currencies
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Category Name",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      )),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty)
                        return 'Enter a category name ';
                      else
                        return null;
                    },
                    controller: categorynamecontroller,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(21.0),
                      suffixIcon: const Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Icon(
                          Icons.category,
                          color: Colors.grey,
                        ), // icon is 48px widget.
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Amount",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      )),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty)
                        return 'Enter a valid amount ';
                      else
                        return null;
                    },
                    controller: amountcontroller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(21.0),
                      suffixIcon: const Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Icon(
                          Icons.currency_rupee,
                          color: Colors.grey,
                        ), // icon is 48px widget.
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Date And Time",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      )),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 18, left: 18),
                  child: InkWell(
                    onTap: () => datePicker(),
                    child: Container(
                      height: height * 0.07,
                      width: width * 0.80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat("MMMM, dd, yyyy").format(selectedDate),
                            ),
                            const Icon(
                              Icons.calendar_month,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                InkWell(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      savefrom(context);
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green),
                    child: const Center(
                      child: Text(
                        "Save Expense",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


 // Padding(
            //   padding: const EdgeInsets.only(right: 18, left: 18),
            //   child: TextFormField(
            //     // controller:,
            //     decoration: InputDecoration(
            //       border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(15)),
            //       suffixIcon: const Padding(
            //         padding: EdgeInsets.all(0.0),
            //         child: Icon(
            //           Icons.arrow_drop_down,
            //           color: Colors.grey,
            //         ), // icon is 48px widget.
            //       ),
            //     ),
            //   ),
            // ),