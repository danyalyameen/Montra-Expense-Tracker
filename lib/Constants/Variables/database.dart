import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Account/Views/account_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/About/Views/about_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Currency/Views/currency_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Help/Views/help_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Notification/Views/notification_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Security/Views/security_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Theme/Views/theme_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Views/settings_view.dart';

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
  static List<Map<String, dynamic>> todayExpenseDatabase = [
    {
      "Category": "Shopping",
      "Description": "Buy Some Grocery",
      "Time": "10:00 AM",
      "Expense": "- \$120",
      "Icon": IconsPath.shopping,
      "Icon-Color": AppColors.primaryYellow,
      "Icon-Background": AppColors.yellow20,
    },
    {
      "Category": "Subscription",
      "Description": "Disney + Annual Subscription",
      "Time": "03:30 PM",
      "Expense": "- \$80",
      "Icon": IconsPath.subscription,
      "Icon-Color": AppColors.primaryViolet,
      "Icon-Background": AppColors.violet20,
    },
    {
      "Category": "Food",
      "Description": "Buy a ramen",
      "Time": "07:30 PM",
      "Expense": "- \$32",
      "Icon": IconsPath.food,
      "Icon-Color": AppColors.primaryRed,
      "Icon-Background": AppColors.red20,
    },
  ];

  static List<Map<String, dynamic>> settingsData = [
    {
      "Title": "Currency",
      "Default-Selection": "USD",
    },
    {
      "Title": "Theme",
      "Default-Selection": "Light",
    },
    {
      "Title": "Security",
      "Default-Selection": "Pin",
    },
    {
      "Title": "Notification",
      "Default-Selection": "",
    },
    {
      "Title": "About",
      "Default-Selection": "",
    },
    {
      "Title": "Help",
      "Default-Selection": "",
    },
  ];

  static List<Map<String, dynamic>> currencyData = [
    {"Currency": "United States (USD)", "isSelect": true, "Symbol": "USD"},
    {"Currency": "Pakistan (PKR)", "isSelect": false, "Symbol": "PKR"},
    {"Currency": "Indonesia (IDR)", "isSelect": false, "Symbol": "IDR"},
    {"Currency": "Japan (JPY)", "isSelect": false, "Symbol": "JPY"},
    {"Currency": "Russia (RUB)", "isSelect": false, "Symbol": "RUB"},
    {"Currency": "Germany (EUR)", "isSelect": false, "Symbol": "EUR"},
    {"Currency": "Korea (WON)", "isSelect": false, "Symbol": "WON"},
  ];
  static List<Map<String, dynamic>> themeData = [
    {"Theme": "Light", "isSelect": true},
    {"Theme": "Dark", "isSelect": false},
  ];
  static List<Map<String, dynamic>> securityData = [
    {"Security": "Pin", "isSelect": true},
    {"Security": "Fingerprint", "isSelect": false},
    {"Security": "Face ID", "isSelect": false},
  ];

  static List navigationViewsForSettings = [
    CurrencyView(),
    ThemeView(),
    SecurityView(),
    NotificationView(),
    AboutView(),
    HelpView(),
  ];

  static List navigationViewsForProfile = [
    AccountView(),
    SettingsView(),
    AccountView(),
    SettingsView(),
  ];

  static List<Map<String, dynamic>> profileData = [
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

  static List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  static List<Map<String, dynamic>> budgetData = [
    {
      "Category": "Shopping",
      "Color": AppColors.primaryYellow,
      "Icon" : IconsPath.shopping,
      "Icon-Color" : AppColors.primaryYellow,
      "Icon-Background" : AppColors.yellow20,
      "Limit": 1000,
      "Spend": 1200,
    },
    {
      "Category": "Transportation",
      "Color": AppColors.primaryBlue,
      "Icon" : IconsPath.transportation,
      "Icon-Color" : AppColors.primaryBlue,
      "Icon-Background" : AppColors.blue20,
      "Limit": 700,
      "Spend": 350,
    },
  ];
}
