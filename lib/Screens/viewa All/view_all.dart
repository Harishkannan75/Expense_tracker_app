import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Common/categorimages.dart';
import '../Common/expenseprovider.dart';

class Viewallpage extends StatefulWidget {
  const Viewallpage({super.key});

  @override
  State<Viewallpage> createState() => _ViewallpageState();
}

class _ViewallpageState extends State<Viewallpage> {
  Set<int> selectedIndex = Set<int>();
  @override
  Widget build(BuildContext context) {
    final expenses = Provider.of<ExpenseProvider>(context).expenses;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Expense List"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            if (selectedIndex.isNotEmpty)
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // Delete selected expenses here using _selectedIndices set
                  Provider.of<ExpenseProvider>(context, listen: false)
                      .deleteSelectedExpenses(selectedIndex.toList());
                  // Clear the selection after deletion
                  setState(() {
                    selectedIndex.clear();
                  });
                },
              ),
          ],
        ),
        body: Container(
            child: expenses.isNotEmpty
                ? ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      );
                    },
                    itemCount: expenses.length + 1,
                    itemBuilder: (context, index) {
                      if (index == expenses.length) {
                      } else {
                        final expensegetdata = expenses[index];
                        final isSelected = selectedIndex.contains(index);
                        return InkWell(
                          onLongPress: () {
                            setState(() {
                              selectedIndex.add(index);
                            });
                          },
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selectedIndex.remove(index);
                              } else {
                                selectedIndex.add(index);
                              }
                            });
                          },
                          child: Container(
                            color: isSelected
                                ? Colors.grey.withOpacity(0.3)
                                : Colors.white,
                            child: ListTile(
                              title: Text(expensegetdata.categoryName),
                              subtitle: Text(DateFormat('MMMM, dd, yyyy')
                                  .format(expensegetdata.date)),
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
                          ),
                        );
                      }
                    },
                  )
                : Center(
                    child: Container(height: 300, child: Text("NO Expense")),
                  )),
      ),
    );
  }
}
