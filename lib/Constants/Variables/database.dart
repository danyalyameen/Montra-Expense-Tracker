import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';

class Database {
  static List<Map<String, dynamic>> walletOptions = [
    {
      "Wallet": "Jazz Cash",
      "Balance": 1000,
      "Account Type": "Wallet",
      "Picture": IconsPath.jazzcash
    },
    {
      "Wallet": "Easypaisa",
      "Balance": 100,
      "Account Type": "Wallet",
      "Picture": IconsPath.easypaisa
    },
    {
      "Wallet": "UBL",
      "Balance": 9899,
      "Account Type": "Bank",
      "Picture": IconsPath.ubl
    },
  ];
  static List<Map<String, dynamic>> categoryOptions = [
    {
      "Category": "Grocery",
      "Colors": AppColors.primaryRed,
    },
    {
      "Category": "Food",
      "Colors": AppColors.primaryBlue,
    },
    {
      "Category": "Travel",
      "Colors": AppColors.primaryGreen,
    },
    {
      "Category": "Gadgets",
      "Colors": AppColors.primaryYellow,
    },
    {
      "Category": "Subscription",
      "Colors": AppColors.primaryViolet,
    },
  ];

  static List<Map<String, dynamic>> incomeOptions = [
    {
      "Income": "Business",
      "Colors": AppColors.primaryRed,
    },
    {
      "Income": "Rent",
      "Colors": AppColors.primaryBlue,
    },
    {
      "Income": "Job",
      "Colors": AppColors.primaryGreen,
    },
    {
      "Income": "Investment",
      "Colors": AppColors.primaryYellow,
    },
  ];
}
