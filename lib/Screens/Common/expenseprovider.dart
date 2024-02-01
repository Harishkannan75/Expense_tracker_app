import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import 'expenseclass.dart';

class ExpenseProvider extends ChangeNotifier {
  List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;

  Future<void> fetchExpenseData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedExpenseString = prefs.getString('Expenses');

    if (storedExpenseString != null) {
      List<Map<String, dynamic>> decodedExpenses =
          List<Map<String, dynamic>>.from(json.decode(storedExpenseString));
      _expenses = decodedExpenses.map((expense) {
        String category = expense["Categorie"];
        String? categorysName = expense["categoryname"];
        double amount;
        try {
          amount = double.parse(expense["Amount"]);
        } catch (e) {
          amount = 0;
        }
        DateTime date;
        try {
          date =
              DateFormat('yyyy-MM-ddTHH:mm:ss.SSSSSS').parse(expense["date"]);
        } catch (e) {
          date = DateTime.now();
        }
        return Expense(category, amount, date, categorysName ?? "");
      }).toList();
      notifyListeners();
    }
  }
  // Expense(expense["Categorie"], expense["Amount"],
  //     DateTime.parse(expense["date"])))

  Future<void> addExpense(Expense expense) async {
    _expenses.add(expense);
    await _saveExpensesToStorage();
    notifyListeners();
  }

  Future<void> deleteExpense(int index) async {
    _expenses.removeAt(index);
    await _saveExpensesToStorage();
    notifyListeners();
  }

  Future<void> _saveExpensesToStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> encodedExpenses = _expenses.map((expense) {
      return {
        'Categorie': expense.category,
        'Amount': expense.amount.toString(),
        'categoryname': expense.categoryName,
        'date': expense.date.toIso8601String(),
      };
    }).toList();
    prefs.setString('Expenses', json.encode(encodedExpenses));
  }

  void setExpenses(List<Map<String, dynamic>> data) {
    _expenses = data
        .map((expense) => Expense(
            expense["Categorie"],
            double.parse(expense["Amount"]),
            DateTime.parse(expense["date"]),
            expense['categoryname']))
        .toList();
    notifyListeners();
  }

  double calculateTotalByCategory(String category) {
    return _expenses
        .where((expense) => expense.category == category)
        .fold(0, (double total, expense) => total + expense.amount);
  }

  double calculateTotalExpenses() {
    return _expenses.fold(0, (double total, expense) => total + expense.amount);
  }

  void deleteSelectedExpenses(List<int> selectedIndices) async {
    selectedIndices.sort((a, b) => b.compareTo(a));

    for (int index in selectedIndices) {
      _expenses.removeAt(index);
      await _saveExpensesToStorage();
    }

    notifyListeners();
  }
}
