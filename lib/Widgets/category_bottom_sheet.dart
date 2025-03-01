import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/App/app.locator.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Widgets/custom_bottom_sheet.dart';
import 'package:stacked_services/stacked_services.dart';

class CategoryBottomSheet extends StatefulWidget {
  final Future<List> fetchingCategoryOptions;
  final VoidCallback onPressed;
  final Map<String, dynamic> storeSelectedCategory;
  final String dropDown;
  const CategoryBottomSheet(
      {super.key,
      required this.fetchingCategoryOptions,
      required this.onPressed,
      required this.storeSelectedCategory,
      required this.dropDown});
  @override
  State<CategoryBottomSheet> createState() => _CategoryState();
}

class _CategoryState extends State<CategoryBottomSheet> {
  // Variables
  final String createCategory = "Create Category";
  final NavigationService navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: height * 0.05),
      // Custom Bottom Sheet For UI like Text Field
      child: CustomBottomSheet(
        buttonsBottomHight: height * 0.08,
        buttonText: createCategory,
        buttonWidth: width * 0.38,
        bottomSheetHight: height * 0.29,
        hintText: widget.dropDown,
        storeSelectedItem: widget.storeSelectedCategory,
        // Show Items
        showItems: _ShowItemsForCategory(
          width: width,
          height: height,
          data: widget.fetchingCategoryOptions,
          updateCategory: (index) async {
            var data = await widget.fetchingCategoryOptions;
            widget.storeSelectedCategory["option"] = data[index].option;
            widget.storeSelectedCategory["color"] = data[index].color;
            navigationService.back();
            setState(() {});
          },
        ),
        // Selected Item
        showSelectedItemOnHintText: _ShowSelectedCategory(
          width: width,
          height: height,
          storeSelectedCategory: widget.storeSelectedCategory,
        ),
        // On Pressed
        onPressed: () {
          Navigator.pop(context);
          widget.onPressed();
        },
      ),
    );
  }
}

class _ShowSelectedCategory extends StatelessWidget {
  final double width, height;
  final Map<String, dynamic> storeSelectedCategory;
  const _ShowSelectedCategory({
    required this.width,
    required this.height,
    required this.storeSelectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.01, bottom: height * 0.01),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primaryBlack,
            width: width * 0.002,
          ),
          borderRadius: BorderRadius.circular(width * 0.08),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Selected Category Name
            Padding(
              padding: EdgeInsets.all(width * 0.02),
              child: Text(
                storeSelectedCategory["option"],
                style: TextStyle(
                    color: AppColors.primaryBlack, fontWeight: FontWeight.w500),
              ),
            ),
            // For Spacing
            SizedBox(
              width: width * 0.02,
            ),
            // Selected Category Color
            Padding(
              padding: EdgeInsets.only(right: width * 0.04),
              child: CircleAvatar(
                maxRadius: width * 0.01,
                backgroundColor:
                    Color(int.parse(storeSelectedCategory["color"])),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ShowItemsForCategory extends StatelessWidget {
  final double width, height;
  final Function(int index) updateCategory;
  final Future<List> data;
  const _ShowItemsForCategory({
    required this.width,
    required this.height,
    required this.updateCategory,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: FutureBuilder<List>(
        future: data,
        builder: (context, snapshot) {
          // Loading STate
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final data = snapshot.data![index];
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.1, vertical: height * 0.057),
                child: InkWell(
                  onTap: () {
                    updateCategory(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primaryBlack,
                        width: width * 0.002,
                      ),
                      borderRadius: BorderRadius.circular(width * 0.08),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Option Means Category
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            data.option!,
                            style: TextStyle(
                              color: AppColors.primaryBlack,
                            ),
                          ),
                        ),
                        // For Spacing
                        SizedBox(
                          width: width * 0.02,
                        ),
                        // Color
                        Padding(
                          padding: EdgeInsets.only(right: width * 0.04),
                          child: CircleAvatar(
                            maxRadius: width * 0.01,
                            backgroundColor: Color(int.parse(data.color!)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
