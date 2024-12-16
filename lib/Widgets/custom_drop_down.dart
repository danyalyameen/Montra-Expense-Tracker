import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({super.key});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  List<String> options = [
    "Grocery",
    "Food",
    "Travel",
    "Gadgets",
    "Subscription",
    "Cosmetics"
  ];

  List colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
  ];

  Map<String, dynamic> selectedCategory = {
    "selected": "Category",
    "color": null
  };

  void updateCategory({required int index, required BuildContext context}) {
    setState(() {
      selectedCategory["selected"] = options[index];
      selectedCategory["color"] = colors[index];
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: width * 0.08),
      child: InkWell(
        onTap: () {
          CategoryBottomSheet.showBottomSheet(
            colors: colors,
            options: options,
            width: width,
            height: height,
            context: context,
            selectedCategory: selectedCategory,
            updateCategory: (index, context) {
              updateCategory(index: index, context: context);
            },
          );
        },
        child: Container(
          width: width * 0.9,
          height: height * 0.07,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(width * 0.04),
            border: Border.all(color: AppColors.light20, width: width * 0.005),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: width * 0.04),
                  child: selectedCategory["selected"] == "Category"
                      ? Text(
                          "Category",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(
                              top: height * 0.01, bottom: height * 0.01),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.primaryBlack,
                                  width: width * 0.002,
                                ),
                                borderRadius:
                                    BorderRadius.circular(width * 0.08)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    selectedCategory["selected"],
                                    style: TextStyle(
                                      color: AppColors.primaryBlack,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: width * 0.04),
                                  child: CircleAvatar(
                                    maxRadius: width * 0.01,
                                    backgroundColor: selectedCategory["color"],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
              Padding(
                padding: EdgeInsets.only(right: width * 0.035),
                child: SvgPicture.asset(
                  IconsPath.dropdownArrow,
                  colorFilter:
                      const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryBottomSheet {
  static void showBottomSheet({
    required List colors,
    required List options,
    required double width,
    required double height,
    required BuildContext context,
    required Map<String, dynamic> selectedCategory,
    required Function(int, BuildContext) updateCategory,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: height * 0.2,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(width * 0.05),
              topRight: Radius.circular(width * 0.05),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.1, vertical: height * 0.04),
                      child: InkWell(
                        onTap: () {
                          updateCategory(index, context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.primaryBlack,
                                width: width * 0.002,
                              ),
                              borderRadius:
                                  BorderRadius.circular(width * 0.08)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  options[index],
                                  style: TextStyle(
                                    color: AppColors.primaryBlack,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: width * 0.04),
                                child: CircleAvatar(
                                  maxRadius: width * 0.01,
                                  backgroundColor: colors[index],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: width * 0.35,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(AppColors.violet20),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(width * 0.05),
                            ),
                          ),
                        ),
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: AppColors.primaryViolet),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Create Category",
                        style: TextStyle(color: AppColors.primaryLight),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
