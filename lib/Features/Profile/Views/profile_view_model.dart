import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';

class ProfileViewModel extends ViewModel {
  List<Map<String, dynamic>> profileData = [
    {
      "Icon": IconsPath.account,
      "Page-Name": "Account",
      "Icon-Color": AppColors.primaryViolet,
      "Background-Color": AppColors.violet20,
    },
    {
      "Icon": IconsPath.settings,
      "Page-Name": "Settings",
      "Icon-Color": AppColors.primaryViolet,
      "Background-Color": AppColors.violet20,
    },
    {
      "Icon": IconsPath.export,
      "Page-Name": "Export Data",
      "Icon-Color": AppColors.primaryViolet,
      "Background-Color": AppColors.violet20,
    },
    {
      "Icon": IconsPath.logout,
      "Page-Name": "Logout",
      "Icon-Color": AppColors.primaryRed,
      "Background-Color": AppColors.logoutBackground,
    },
  ];
}
