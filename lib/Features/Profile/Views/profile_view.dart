import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Profile/Views/profile_view_model.dart';
import 'package:montra_expense_tracker/Models/person_model.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StackedView<ProfileViewModel> {
  const ProfileView({super.key});

  @override
  Widget builder(
      BuildContext context, ProfileViewModel viewModel, Widget? child) {
    // Get Screen Size of a Device
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.profileBackground,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            // User Account
            _UserAccount(),
            // For Spacing
            SizedBox(
              height: height * 0.05,
            ),
            // Profile Pages
            _ProfilePages(
              navigate: ({required index}) {
                viewModel.navigation(index: index);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  ProfileViewModel viewModelBuilder(BuildContext context) => ProfileViewModel();
}

class _UserAccount extends ViewModelWidget<ProfileViewModel> {
  // Variables
  final String accountTitle = "Username";
  final String username = "Danyal Yameen";

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    // Get Screen Size of a Device
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder(
      // Loading User Image and Details
      future: Future.wait([
        precacheImage(
            NetworkImage(
              viewModel.imageService
                  .getImage(userPicture: true, imageName: "user"),
            ),
            context),
        viewModel.auth.getUserDetails()
      ]),
      builder: (context, snapshot) {
        // Loading State
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: width * 0.9,
              height: height * 0.15,
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
              ),
              margin: EdgeInsets.only(
                top: height * 0.06,
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryViolet,
                borderRadius: BorderRadius.circular(width * 0.05),
              ),
            ),
          );
        }
        // User Details
        var userDetails = snapshot.data![1] as PersonData;
        // Background Container
        return InkWell(
          onTap: () async {
            await viewModel.navigationService
                .navigateToEditProfileView(name: userDetails.name!);
            viewModel.notifyListeners();
          },
          child: Container(
            width: width * 0.9,
            height: height * 0.15,
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
            ),
            margin: EdgeInsets.only(
              top: height * 0.06,
            ),
            decoration: BoxDecoration(
              color: AppColors.primaryViolet,
              borderRadius: BorderRadius.circular(width * 0.05),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black25,
                  blurRadius: width * 0.01,
                  offset: Offset(0, width * 0.01),
                ),
              ],
            ),
            child: Row(
              children: [
                // User Image
                ValueListenableBuilder(
                  valueListenable: viewModel.imageError,
                  builder: (context, value, child) {
                    return Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primaryLight,
                          width: width * 0.006,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(width * 0.005),
                        child: CircleAvatar(
                          radius: width * 0.08,
                          backgroundColor: value
                              ? AppColors.primaryViolet
                              : Colors.transparent,
                          backgroundImage: value
                              ? null
                              : NetworkImage(viewModel.imageService.getImage(
                                  userPicture: true, imageName: "user")),
                          child: value
                              ? Text(userDetails.name![0].toUpperCase(),
                                  style: TextStyle(
                                      color: AppColors.primaryLight,
                                      fontSize: width * 0.06,
                                      fontWeight: FontWeight.w600))
                              : null,
                          onBackgroundImageError: (exception, stackTrace) {
                            viewModel.imageError.value = true;
                          },
                        ),
                      ),
                    );
                  },
                ),
                // For Spacing
                SizedBox(
                  width: width * 0.04,
                ),
                // Username
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Account Title
                    Text(
                      accountTitle,
                      style: TextStyle(
                        color: AppColors.light60,
                        fontSize: width * 0.035,
                      ),
                    ),
                    // For Spacing
                    SizedBox(
                      height: height * 0.005,
                    ),
                    // Username
                    Text(
                      userDetails.name!,
                      style: TextStyle(
                        color: AppColors.primaryLight,
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                // For Spacing
                const Spacer(),
                // Edit Icon
                InkWell(
                  child: SvgPicture.asset(
                    IconsPath.edit,
                    width: width * 0.03,
                    height: height * 0.03,
                    colorFilter: ColorFilter.mode(
                        AppColors.primaryLight, BlendMode.srcIn),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProfilePages extends StatelessWidget {
  final Function({required int index}) navigate;
  _ProfilePages({required this.navigate});

  // Variables
  final String profileDataIconKey = "Icon";
  final String profileDataIconColorKey = "Icon-Color";
  final String profileDataIconBackgroundColorKey = "Background-Color";
  final String profileDataPageNameKey = "Page-Name";
  final List<Map<String, dynamic>> data = Database.profileData;

  @override
  Widget build(BuildContext context) {
    // Get Screen Size of a Device
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width * 0.9,
      height: height * 0.28,
      child: Card(
        color: AppColors.primaryLight,
        elevation: width * 0.008,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(width * 0.05),
        ),
        child: ListView.separated(
          itemBuilder: (context, index) {
            // Each Profile Page
            return InkWell(
              onTap: () {
                navigate(index: index);
              },
              child: ListTile(
                minTileHeight: height * 0.07,
                // Name
                title: Text(
                  data[index][profileDataPageNameKey],
                  style: TextStyle(
                    color: AppColors.primaryBlack,
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // Icon
                leading: Container(
                  width: width * 0.12,
                  height: width * 0.12,
                  decoration: BoxDecoration(
                    color: data[index][profileDataIconBackgroundColorKey],
                    borderRadius: BorderRadius.circular(width * 0.045),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      data[index][profileDataIconKey],
                      colorFilter: ColorFilter.mode(
                        data[index][profileDataIconColorKey],
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            // Divider or Separator
            return Divider(
              color: AppColors.light20,
              thickness: width * 0.001,
            );
          },
          // Item Count
          itemCount: data.length,
          padding: EdgeInsets.only(top: height * 0.008),
        ),
      ),
    );
  }
}
