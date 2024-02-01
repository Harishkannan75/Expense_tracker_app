import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Common/categorimages.dart';
import '../../Common/expenseclass.dart';

class HomePageCategoryList extends StatelessWidget {
  const HomePageCategoryList({super.key, required this.expenses});
  final List<Expense> expenses;
  @override
  Widget build(BuildContext context) {
    List<Expense> sortedExpenses = [...expenses].reversed.toList();

    return Container(
        child: sortedExpenses.isNotEmpty
            ? ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: Colors.grey,
                    indent: 10,
                    endIndent: 10,
                    thickness: 1,
                  );
                },
                itemCount: min(sortedExpenses.length + 1, 5),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  if (index == expenses.length) {
                  } else {
                    final expensegetdata = sortedExpenses[index];
                    return Container(
                      child: ListTile(
                        title: Text(
                          expensegetdata.categoryName,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        subtitle: Text(
                            DateFormat('MMMM, dd, yyyy')
                                .format(expensegetdata.date),
                            style: TextStyle(color: Colors.grey[600])),
                        leading: CategorImages()
                            .categoryimages(expensegetdata.category),
                        trailing: Text(
                          "₹ ${expensegetdata.amount}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    );
                  }
                },
              )
            : Center(
                child: Container(
                    height: 300,
                    child: const Text(
                      "NO Expense",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )),
              ));
  }
}
