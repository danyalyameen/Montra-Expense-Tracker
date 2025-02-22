import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Transaction/Attach%20Views/Details%20Transaction/Views/details_transaction_view_model.dart';
import 'package:montra_expense_tracker/Providers/Currency/currency_provider.dart';
import 'package:montra_expense_tracker/Widgets/delete_sheet.dart';
import 'package:montra_expense_tracker/Widgets/white_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';

class DetailsTransactionView extends StackedView<DetailsTransactionViewModel> {
  final String balance, description, category, type;
  final Timestamp time;
  final Color color;
  const DetailsTransactionView(this.balance, this.description, this.time,
      this.category, this.type, this.color,
      {super.key});

  // On Creation of View
  @override
  void onViewModelReady(DetailsTransactionViewModel viewModel) {
    // Change Notification Bar Color
    viewModel.notificationBarService.whiteNotificationBar();
    super.onViewModelReady(viewModel);
  }

  // On Dispose of View
  @override
  void onDispose(DetailsTransactionViewModel viewModel) {
    // Change Notification Bar Color
    viewModel.notificationBarService.blackNotificationBar();
    super.onDispose(viewModel);
  }

  // Variables
  final String editButtonText = "Edit";
  final String appBarTitle = "Transaction Details";
  final String title = "Remove this Transaction?";
  final String subtitle =
      "Are you sure do you want to remove this Transaction?";

  @override
  Widget builder(BuildContext context, DetailsTransactionViewModel viewModel,
      Widget? child) {
    // Get Screen Size of Device
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: whiteAppBar(
        title: appBarTitle,
        width: width,
        height: height,
        backgroundColor: color,
        onTap: () => viewModel.navigationService.back(),
        actions: [
          // Delete Button
          InkWell(
            onTap: () {
              Delete.showSheet(
                context: context,
                width: width,
                height: height,
                title: title,
                subtitle: subtitle,
                onPressed: () {
                  viewModel.transactionsService.deleteTransaction(time: time);
                  viewModel.navigationService.popUntil(
                    (route) => route.settings.name == "/dashboard-view",
                  );
                },
              );
            },
            child: SvgPicture.asset(
              IconsPath.delete,
              colorFilter:
                  ColorFilter.mode(AppColors.primaryLight, BlendMode.srcIn),
              width: width * 0.08,
              height: width * 0.08,
            ),
          ),
          SizedBox(
            width: width * 0.04,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Background Color and Category Information
          _Background(
            width: width,
            height: height,
            color: color,
            balance: balance,
            description: description,
            time: time,
            type: type,
            category: category,
          ),
          // For Spacing
          SizedBox(
            height: height * 0.04,
          ),
          // Description and Attachment
          Padding(
            padding: EdgeInsets.only(
              left: width * 0.04,
              right: width * 0.04,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Description
                _Description(
                  width: width,
                  height: height,
                  description: description,
                ),
                // For Spacing
                SizedBox(
                  height: height * 0.02,
                ),
                // Attachments
                _Attachment(
                  width: width,
                  height: height,
                  time: time,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  DetailsTransactionViewModel viewModelBuilder(BuildContext context) =>
      DetailsTransactionViewModel();
}

class _Background extends StatelessWidget {
  final double width, height;
  final Color color;
  final Timestamp time;
  final String description, type, category, balance;
  const _Background(
      {required this.width,
      required this.height,
      required this.color,
      required this.description,
      required this.time,
      required this.type,
      required this.category,
      required this.balance});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Color Container
        Positioned(
          child: Container(
            width: width,
            height: height * 0.28,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(width * 0.1),
                bottomRight: Radius.circular(width * 0.1),
              ),
            ),
            child: Column(
              children: [
                // Balance
                _Balance(
                  width: width,
                  height: height,
                  balance: balance,
                  description: description,
                  time: time,
                ),
              ],
            ),
          ),
        ),
        // Types Means Category Information
        _Types(
          width: width,
          height: height,
          type: type,
          category: category,
        ),
      ],
    );
  }
}

class _Balance extends StatelessWidget {
  final double width, height;
  final String balance, description;
  final Timestamp time;
  const _Balance(
      {required this.width,
      required this.height,
      required this.description,
      required this.time,
      required this.balance});

  @override
  Widget build(BuildContext context) {
    
    // Providers
    var currencyProvider = Provider.of<CurrencyProvider>(context, listen: true);
    // Format the date
    final String formattedDate = DateFormat('EEEE d MMMM yyyy').format(DateTime(
        time.toDate().year,
        time.toDate().month,
        time.toDate().day,
        time.toDate().weekday));
    return Column(
      children: [
        // For Spacing
        SizedBox(
          height: height * 0.04,
        ),
        // Balance
        Text(
          "${currencyProvider.currency}$balance",
          style: TextStyle(
            color: AppColors.primaryLight,
            fontSize: width * 0.12,
            fontWeight: FontWeight.w800,
          ),
        ),
        // For Spacing
        SizedBox(
          height: height * 0.01,
        ),
        // Description
        Text(
          description,
          style: TextStyle(
            color: AppColors.primaryLight,
            fontSize: width * 0.04,
            fontWeight: FontWeight.w500,
          ),
        ),
        // For Spacing
        SizedBox(
          height: height * 0.01,
        ),
        // Time
        Text(
          "$formattedDate  ${time.toDate().hour > 12 ? (time.toDate().hour - 12).toString().padLeft(2, "0") : time.toDate().hour.toString().padLeft(2, "0")}:${time.toDate().minute.toString().padLeft(2, "0")} ${time.toDate().hour > 12 ? "PM" : "AM"}",
          style: TextStyle(
            color: AppColors.primaryLight,
            fontSize: width * 0.035,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _Types extends StatelessWidget {
  final double width, height;
  final String type, category;
  const _Types({
    required this.width,
    required this.height,
    required this.type,
    required this.category,
  });

  // Variables
  final String typeTitle = "Type";
  final String categoryTitle = "Category";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: width * 0.05,
        right: width * 0.05,
        top: height * 0.22,
      ),
      // Background Color
      child: Container(
        height: height * 0.1,
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(width * 0.04),
          border: Border.all(
            width: width * 0.0004,
            color: AppColors.primaryBlack,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Type
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Type Title
                Text(
                  typeTitle,
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // For Spacing
                SizedBox(
                  height: height * 0.01,
                ),
                // Transaction Type
                Text(
                  type,
                  style: TextStyle(
                    color: AppColors.primaryBlack,
                    fontSize: width * 0.045,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            // Category
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Category Title
                Text(
                  type == "Transfer" ? "Transfer" : categoryTitle,
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // For Spacing
                SizedBox(
                  height: height * 0.01,
                ),
                // Category
                Text(
                  type == "Transfer"
                      ? "${category.split(",").first} To ${category.split(",").last}"
                      : category,
                  style: TextStyle(
                    color: AppColors.primaryBlack,
                    fontSize: width * 0.045,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  final double width, height;
  final String description;
  const _Description(
      {required this.width, required this.height, required this.description});

  // Variables
  final String descriptionTitle = "Description";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Description Title
        Text(
          descriptionTitle,
          style: TextStyle(
            color: AppColors.grey,
            fontSize: width * 0.045,
            fontWeight: FontWeight.w500,
          ),
        ),
        // For Spacing
        SizedBox(
          height: height * 0.01,
        ),
        // Description
        Text(
          description,
          style: TextStyle(
            color: AppColors.primaryBlack,
            fontSize: width * 0.04,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _Attachment extends ViewModelWidget<DetailsTransactionViewModel> {
  final double width, height;
  final Timestamp time;
  const _Attachment(
      {required this.width, required this.height, required this.time});

  // Variables
  final String attachmentTitle = "Attachment";

  @override
  Widget build(BuildContext context, DetailsTransactionViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Attachment Title
        Text(
          attachmentTitle,
          style: TextStyle(
            color: AppColors.grey,
            fontSize: width * 0.045,
            fontWeight: FontWeight.w500,
          ),
        ),
        // For Spacing
        SizedBox(
          height: height * 0.02,
        ),
        // Attachment
        FutureBuilder(
          future: precacheImage(
            NetworkImage(viewModel.imageService.getImage(
              userPicture: false,
              imageName: time.toString(),
            )),
            context,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: width * 0.4,
                  height: height * 0.1,
                  decoration: BoxDecoration(
                    color: AppColors.light80,
                    borderRadius: BorderRadius.circular(width * 0.04),
                  ),
                ),
              );
            }
            return ClipRRect(
              borderRadius: BorderRadius.circular(width * 0.04),
              child: Image.network(
                viewModel.imageService.getImage(
                  userPicture: false,
                  imageName: time.toString(),
                ),
                width: width * 0.4,
                errorBuilder: (context, error, stackTrace) {
                  return Text(
                    "No Attachments",
                    style: TextStyle(
                      color: AppColors.primaryBlack,
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
