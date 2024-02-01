import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../Common/expencecategoriclass.dart';
import '../../Common/expenseprovider.dart';

class Homepagecategoriewidget extends StatelessWidget {
  final List<ExpenseCategory> categories;
  Homepagecategoriewidget({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.47,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          // crossAxisSpacing: 5.0,
          // mainAxisSpacing: 5.0,
        ),
        itemCount: categories.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          ExpenseCategory category = categories[index];
          double totalExpense = Provider.of<ExpenseProvider>(context)
              .calculateTotalByCategory(category.categoriesName);
          return InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: height * 0.20,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white30),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.green[50],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.0,
                    ),
                    Container(
                      height: height * 0.06,
                      width: width * 0.13,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[300]),
                      child: Center(
                        child: SvgPicture.asset(
                          category.categoriesimageAssetPath,
                          width: width * 0.01,
                          height: height * 0.04,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Text(
                        category.categoriesName,
                        style: TextStyle(fontSize: 19.0),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: Text(
                        "₹ ${totalExpense.toStringAsFixed(2)}",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
