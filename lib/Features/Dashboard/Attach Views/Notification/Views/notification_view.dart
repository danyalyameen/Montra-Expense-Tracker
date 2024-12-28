import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Notification/Views/notification_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class NotificationView extends StackedView<NotificationViewModel> {
  NotificationView({super.key});

  String appBarTitle = "Notification";
  String titleKey = "Title";
  String descriptionKey = "Description";
  String timeKey = "Time";

  @override
  Widget builder(
      BuildContext context, NotificationViewModel viewModel, Widget? child) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: blackAppBar(
        title: appBarTitle,
        width: width,
        height: height,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: width * 0.05),
            child: InkWell(
              borderRadius: BorderRadius.circular(width * 0.06),
              onTap: () {
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(width, 0, 0, height),
                  items: Database.menuItems.map(
                    (e) {
                      return PopupMenuItem(
                        value: e.toString(),
                        child: Text(
                          e.toString(),
                          style: TextStyle(
                            color: AppColors.primaryBlack,
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                );
              },
              child: SvgPicture.asset(
                IconsPath.menuDots,
                width: width * 0.06,
                height: width * 0.06,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    
                  },
                  child: ListTile(
                    title: Text(
                      Database.notificationsData[index][titleKey],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.primaryBlack.withOpacity(0.9),
                        fontSize: width * 0.042,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      Database.notificationsData[index][descriptionKey],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.black25,
                        fontWeight: FontWeight.w400,
                        fontSize: width * 0.035,
                      ),
                    ),
                    trailing: Text(
                      Database.notificationsData[index][timeKey],
                      style: TextStyle(
                        color: AppColors.primaryBlack.withOpacity(0.8),
                        fontSize: width * 0.035,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: AppColors.grey,
                  thickness: width * 0.0005,
                );
              },
              itemCount: Database.notificationsData.length,
            ),
          )
        ],
      ),
    );
  }

  @override
  NotificationViewModel viewModelBuilder(BuildContext context) =>
      NotificationViewModel();
}
