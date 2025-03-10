import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Models/person_model.dart';
import 'package:montra_expense_tracker/Providers/Currency/currency_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked_services/stacked_services.dart';

class UserTransactions extends StatefulWidget {
  final double? width, height;
  final Future<List<Transactions>> transactions;
  final Future<List<Map<String, dynamic>>> icons;
  final int? itemCount;
  final NavigationService navigationService;
  const UserTransactions({
    super.key,
    required this.transactions,
    required this.icons,
    this.width,
    this.height,
    this.itemCount,
    required this.navigationService,
  });

  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  @override
  Widget build(BuildContext context) {
    // Get Screen Size of a Device
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    // Providers
    var currencyProvider = Provider.of<CurrencyProvider>(context);
    return SizedBox(
      height: widget.height ?? height * 0.5,
      width: widget.width ?? width * 0.9,
      child: FutureBuilder<List<Transactions>>(
        future: widget.transactions,
        builder: (context, snapshot) {
          // Loading State
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: ListView(
                children: List.generate(
                  5,
                  (index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        margin: EdgeInsets.only(top: height * 0.01),
                        width: width * 0.9,
                        height: height * 0.1,
                        decoration: BoxDecoration(
                          color: AppColors.light80,
                          borderRadius: BorderRadius.circular(width * 0.04),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
          // Check Data is not null and not empty
          if (snapshot.data != null) {
            if (snapshot.data!.isNotEmpty) {
              return FutureBuilder<List<Map<String, dynamic>>?>(
                future: widget.icons,
                builder: (context, icons) {
                  return ListView.builder(
                    itemCount: widget.itemCount == null ||
                            snapshot.data!.length < widget.itemCount!
                        ? snapshot.data!.length
                        : widget.itemCount,
                    itemBuilder: (context, index) {
                      // Loading State
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      }
                      final transaction = snapshot.data![index];
                      if (icons.data != null) {
                        final icon = icons.data![index];
                        return InkWell(
                          onTap: () async {
                            // Navigate to Details Transaction View
                            await widget.navigationService
                                .navigateToDetailsTransactionView(
                              balance: transaction.transactionPrice.toString(),
                              description: transaction.description!,
                              time: transaction.time!,
                              category: transaction.category!,
                              type: transaction.type!,
                              color: switch (transaction.type!) {
                                "Income" => AppColors.primaryGreen,
                                "Transfer" => AppColors.primaryBlue,
                                "Expense" => AppColors.primaryRed,
                                String() => throw UnimplementedError(),
                              },
                            );
                            setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: height * 0.01),
                            width: width * 0.9,
                            height: height * 0.1,
                            decoration: BoxDecoration(
                              color: AppColors.light80,
                              borderRadius: BorderRadius.circular(width * 0.04),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Icon
                                Padding(
                                  padding: EdgeInsets.only(left: width * 0.04),
                                  child: Container(
                                    width: width * 0.15,
                                    height: width * 0.15,
                                    decoration: BoxDecoration(
                                      color: icon["iconBackgroundColor"],
                                      borderRadius:
                                          BorderRadius.circular(width * 0.04),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        icon["icon"],
                                        colorFilter:
                                            icon["icon"] == IconsPath.other
                                                ? null
                                                : ColorFilter.mode(
                                                    icon["iconColor"],
                                                    BlendMode.srcIn,
                                                  ),
                                        width: width * 0.09,
                                        height: width * 0.09,
                                      ),
                                    ),
                                  ),
                                ),
                                // Title and Description
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: height * 0.02, left: width * 0.04),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Title
                                      Text(
                                        transaction.type! == "Transfer"
                                            ? "${transaction.category!.split(',').first} To ${transaction.category!.split(',').last}"
                                            : transaction.category!,
                                        style: TextStyle(
                                          color: AppColors.primaryBlack,
                                          fontSize: width * 0.042,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      // For Spacing
                                      SizedBox(
                                        height: height * 0.002,
                                      ),
                                      // Description
                                      Text(
                                        transaction.description!.length > 20
                                            ? "${transaction.description!.substring(0, 20)}..."
                                            : transaction.description!,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: AppColors.grey,
                                          fontSize: width * 0.035,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // For Spacing
                                const Spacer(),
                                // Price and Time
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: width * 0.04, top: height * 0.02),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        transaction.type! == "Income"
                                            ? "${currencyProvider.currency}${transaction.transactionPrice!}"
                                            : "- ${currencyProvider.currency}${transaction.transactionPrice!}",
                                        style: TextStyle(
                                          color: transaction.type == "Income"
                                              ? AppColors.primaryGreen
                                              : AppColors.primaryRed,
                                          fontSize: width * 0.045,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.005,
                                      ),
                                      Text(
                                        "${transaction.time!.toDate().hour > 12 ? (transaction.time!.toDate().hour - 12).toString().padLeft(2, "0") : transaction.time!.toDate().hour.toString().padLeft(2, "0")}:${transaction.time!.toDate().minute.toString().padLeft(2, "0")} ${transaction.time!.toDate().hour >= 12 ? "PM" : "AM"}",
                                        style: TextStyle(
                                          color: AppColors.grey,
                                          fontSize: width * 0.032,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  );
                },
              );
            } else {
              return Center(
                child: Text(
                  "No Transactions",
                  style: TextStyle(
                    color: AppColors.primaryBlack,
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }
          } else {
            return Center(
              child: Text(
                "No Transactions",
                style: TextStyle(
                  color: AppColors.primaryBlack,
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
