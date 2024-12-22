import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Constants/Variables/image_path.dart';
import 'package:montra_expense_tracker/Features/Profile/Views/profile_view_model.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class ProfileView extends StackedView<ProfileViewModel> {
  ProfileView({super.key});

  String profileDataIconKey = "Icon";
  String profileDataPageNameKey = "Page-Name";
  String profileDataIconBackgroundColorKey = "Background-Color";
  String profileDataIconColorKey = "Icon-Color";
  String accountTitle = "Username";
  String username = "Danyal Yameen";

  @override
  Widget builder(
      BuildContext context, ProfileViewModel viewModel, Widget? child) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.profileBackground,
      body: Column(
        children: [
          UserAccount(username: username, accountTitle: accountTitle),
          SizedBox(
            height: height * 0.05,
          ),
          ProfilePages(
            profileData: Database.profileData,
            profileDataIconKey: profileDataIconKey,
            profileDataPageNameKey: profileDataPageNameKey,
            profileDataIconBackgroundColorKey:
                profileDataIconBackgroundColorKey,
            profileDataIconColorKey: profileDataIconColorKey,
            navigate: ({required index}) {
              viewModel.navigation(index: index);
            },
          ),
        ],
      ),
    );
  }

  @override
  ProfileViewModel viewModelBuilder(BuildContext context) => ProfileViewModel();
}

class UserAccount extends StatelessWidget {
  final String username, accountTitle;
  const UserAccount(
      {super.key, required this.username, required this.accountTitle});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(
        top: height * 0.06,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.violet60,
                    width: width * 0.006,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(width * 0.005),
                  child: CircleAvatar(
                    radius: width * 0.08,
                    backgroundImage: AssetImage(ImagePath.userImage),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: width * 0.04,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                accountTitle,
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: width * 0.035,
                ),
              ),
              SizedBox(
                height: height * 0.005,
              ),
              Text(
                username,
                style: TextStyle(
                  color: AppColors.primaryBlack,
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(
            width: width * 0.28,
          ),
          InkWell(
            child: SvgPicture.asset(
              IconsPath.edit,
              width: width * 0.03,
              height: height * 0.03,
            ),
          )
        ],
      ),
    );
  }
}

class ProfilePages extends StatelessWidget {
  final String profileDataIconKey,
      profileDataPageNameKey,
      profileDataIconBackgroundColorKey,
      profileDataIconColorKey;
  final List<Map<String, dynamic>> profileData;
  final Function({required int index}) navigate;
  const ProfilePages(
      {super.key,
      required this.profileData,
      required this.profileDataIconKey,
      required this.profileDataPageNameKey,
      required this.profileDataIconBackgroundColorKey,
      required this.profileDataIconColorKey,
      required this.navigate});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width * 0.9,
      height: height * 0.36,
      child: Card(
        color: AppColors.primaryLight,
        elevation: width * 0.008,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(width * 0.05),
        ),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                navigate(index: index);
              },
              child: ListTile(
                minTileHeight: height * 0.07,
                title: Text(
                  profileData[index][profileDataPageNameKey],
                  style: TextStyle(
                    color: AppColors.primaryBlack,
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                leading: Container(
                  width: width * 0.12,
                  height: width * 0.12,
                  decoration: BoxDecoration(
                    color: profileData[index]
                        [profileDataIconBackgroundColorKey],
                    borderRadius: BorderRadius.circular(width * 0.045),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      profileData[index][profileDataIconKey],
                      colorFilter: ColorFilter.mode(
                        profileData[index][profileDataIconColorKey],
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              color: AppColors.light20,
              thickness: width * 0.001,
            );
          },
          itemCount: profileData.length,
          padding: EdgeInsets.only(top: height * 0.008),
        ),
      ),
    );
  }
}
