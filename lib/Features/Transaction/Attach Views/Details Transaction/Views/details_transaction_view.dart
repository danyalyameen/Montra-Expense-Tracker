import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Transaction/Attach%20Views/Details%20Transaction/Views/details_transaction_view_model.dart';
import 'package:montra_expense_tracker/Widgets/custom_delete.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:stacked/stacked.dart';

class DetailsTransactionView extends StackedView<DetailsTransactionViewModel> {
  final String balance, description, time, category, type, accountType;
  final Color color;
  const DetailsTransactionView(this.balance, this.description, this.time,
      this.category, this.type, this.accountType, this.color,
      {super.key});

  final String attachments = "No Attachments";

  @override
  Widget builder(BuildContext context, DetailsTransactionViewModel viewModel,
      Widget? child) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
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
                      _AppBar(
                        width: width,
                        height: height,
                      ),
                      _Balance(
                        width: width,
                        height: height,
                        description: description,
                        time: time,
                      ),
                    ],
                  ),
                ),
              ),
              _Types(
                width: width,
                height: height,
                type: type,
                category: category,
                wallet: accountType,
              ),
            ],
          ),
          SizedBox(
            height: height * 0.04,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: width * 0.04,
              right: width * 0.04,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Description(
                  width: width,
                  height: height,
                  description: description,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                _Attachment(
                  width: width,
                  height: height,
                  attachment: attachments,
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.3,
          ),
          Center(
            child: CustomElevatedButton(
              width: width,
              height: height,
              text: "Edit",
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

class _AppBar extends StatelessWidget {
  final double width, height;
  const _AppBar({required this.width, required this.height});

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
          SvgPicture.asset(
            IconsPath.backArrow,
            colorFilter:
                ColorFilter.mode(AppColors.primaryLight, BlendMode.srcIn),
            width: width * 0.1,
            height: width * 0.1,
          ),
          Text(
            appBarTitle,
            style: TextStyle(
              color: AppColors.primaryLight,
              fontSize: width * 0.05,
              fontWeight: FontWeight.w700,
            ),
          ),
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
  final String description, time;
  const _Balance(
      {required this.width,
      required this.height,
      required this.description,
      required this.time});

  final String balance = "\$120";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: height * 0.04,
        ),
        Text(
          balance,
          style: TextStyle(
            color: AppColors.primaryLight,
            fontSize: width * 0.12,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Text(
          description,
          style: TextStyle(
            color: AppColors.primaryLight,
            fontSize: width * 0.04,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Text(
          "Saturday 4 June 2021 $time",
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
  final String type, category, wallet;
  const _Types(
      {required this.width,
      required this.height,
      required this.type,
      required this.category,
      required this.wallet});

  final String typeTitle = "Type";
  final String categoryTitle = "Cateogory";
  final String walletTitle = "Wallet";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: width * 0.05,
        right: width * 0.05,
        top: height * 0.32,
      ),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  typeTitle,
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  categoryTitle,
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  category,
                  style: TextStyle(
                    color: AppColors.primaryBlack,
                    fontSize: width * 0.045,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  walletTitle,
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  wallet,
                  style: TextStyle(
                    color: AppColors.primaryBlack,
                    fontSize: width * 0.045,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            )
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

  final String descriptionTitle = "Description";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          descriptionTitle,
          style: TextStyle(
            color: AppColors.grey,
            fontSize: width * 0.045,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: height * 0.01,
        ),
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

  final String attachmentTitle = "Attachment";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          attachmentTitle,
          style: TextStyle(
            color: AppColors.grey,
            fontSize: width * 0.045,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: height * 0.01,
        ),
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
