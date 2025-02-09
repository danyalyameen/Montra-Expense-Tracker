import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Constants/Variables/variables.dart';
import 'package:montra_expense_tracker/Features/Transaction/Attach%20Views/Details%20Transaction/Views/details_transaction_view_model.dart';
import 'package:montra_expense_tracker/Widgets/delete_sheet.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DetailsTransactionView extends StackedView<DetailsTransactionViewModel> {
  final String balance, description, category, type;
  final DateTime time;
  final Color color;
  const DetailsTransactionView(this.balance, this.description, this.time,
      this.category, this.type, this.color,
      {super.key});

  // On Creation of View
  @override
  void onViewModelReady(DetailsTransactionViewModel viewModel) {
    viewModel.notificationBarService.whiteNotificationBar();
    super.onViewModelReady(viewModel);
  }

  // On Dispose of View
  @override
  void onDispose(DetailsTransactionViewModel viewModel) {
    viewModel.notificationBarService.blackNotificationBar();
    super.onDispose(viewModel);
  }

  // Variables
  final String attachments = "No Attachments";
  final String editButtonText = "Edit";

  @override
  Widget builder(BuildContext context, DetailsTransactionViewModel viewModel,
      Widget? child) {
    // Get Screen Size of Device
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Background Color and App Bar
          _Background(
            width: width,
            height: height,
            color: color,
            balance: balance,
            description: description,
            time: time,
            type: type,
            category: category,
            navigationService: viewModel.navigationService,
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
                  attachment: attachments,
                ),
              ],
            ),
          ),
          // For Spacing
          SizedBox(
            height: height * 0.24,
          ),
          // Edit Button
          Center(
            child: CustomElevatedButton(
              width: width,
              height: height,
              text: editButtonText,
            ),
          )
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
  final DateTime time;
  final String description, type, category, balance;
  final NavigationService navigationService;
  const _Background(
      {required this.width,
      required this.height,
      required this.color,
      required this.description,
      required this.time,
      required this.type,
      required this.category,
      required this.navigationService,
      required this.balance});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Color Container
        Positioned(
          child: Container(
            width: width,
            height: height * 0.36,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(width * 0.1),
                bottomRight: Radius.circular(width * 0.1),
              ),
            ),
            child: Column(
              children: [
                // App Bar
                _AppBar(
                  width: width,
                  height: height,
                  navigationService: navigationService,
                ),
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

class _AppBar extends StatelessWidget {
  final double width, height;
  final NavigationService navigationService;
  const _AppBar(
      {required this.width,
      required this.height,
      required this.navigationService});

  // Variables
  final String appBarTitle = "Transaction Details";
  final String title = "Remove this Transaction?";
  final String subtitle =
      "Are you sure do you want to remove this Transaction?";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: height * 0.05,
        left: width * 0.04,
        right: width * 0.04,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button
          InkWell(
            onTap: () => navigationService.back(),
            child: SvgPicture.asset(
              IconsPath.backArrow,
              colorFilter:
                  ColorFilter.mode(AppColors.primaryLight, BlendMode.srcIn),
              width: width * 0.1,
              height: width * 0.1,
            ),
          ),
          // Title
          Text(
            appBarTitle,
            style: TextStyle(
              color: AppColors.primaryLight,
              fontSize: width * 0.05,
              fontWeight: FontWeight.w700,
            ),
          ),
          // Delete Button
          InkWell(
            onTap: () {
              Delete.showSheet(
                context: context,
                width: width,
                height: height,
                title: title,
                subtitle: subtitle,
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
        ],
      ),
    );
  }
}

class _Balance extends StatelessWidget {
  final double width, height;
  final String balance, description;
  final DateTime time;
  const _Balance(
      {required this.width,
      required this.height,
      required this.description,
      required this.time,
      required this.balance});

  @override
  Widget build(BuildContext context) {
    // Format the date
    final String formattedDate = DateFormat('EEEE d MMMM yyyy')
        .format(DateTime(time.year, time.month, time.day, time.weekday));
    return Column(
      children: [
        // For Spacing
        SizedBox(
          height: height * 0.04,
        ),
        // Balance
        Text(
          "${Variables.currency}$balance",
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
          "$formattedDate  ${time.hour > 12 ? (time.hour - 12).toString().padLeft(2, "0") : time.hour.toString().padLeft(2, "0")}:${time.minute.toString().padLeft(2, "0")} ${time.hour > 12 ? "PM" : "AM"}",
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
        top: height * 0.32,
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

class _Attachment extends StatelessWidget {
  final double width, height;
  final String attachment;
  const _Attachment(
      {required this.width, required this.height, required this.attachment});

  // Variables
  final String attachmentTitle = "Attachment";

  @override
  Widget build(BuildContext context) {
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
          height: height * 0.01,
        ),
        // Attachment
        Text(
          attachment,
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
