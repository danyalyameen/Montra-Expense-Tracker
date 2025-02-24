import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Budget/Views/budget_view.dart';
import 'package:montra_expense_tracker/Features/Dashboard/Views/dashboard_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Account/Views/account_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/About/Views/about_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Currency/Views/currency_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Help/Views/help_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Notification/Views/notification_settings_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Views/settings_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Views/profile_view.dart';
import 'package:montra_expense_tracker/Features/Transaction/Views/transaction_view.dart';

class Database {
  static List<Map<String, dynamic>> onBoardingData = [
    {
      "Icon": IconsPath.gainMoney,
      "Title": "Gain total control of your money",
      "Description": "Become your own money manager and make every cent count",
    },
    {
      "Icon": IconsPath.trackMoney,
      "Title": "Know where your money goes",
      "Description":
          "Track your transaction easily, with categories and financial report ",
    },
    {
      "Icon": IconsPath.plans,
      "Title": "Planning ahead",
      "Description": "Setup your budget for each category so you in control",
    },
  ];

  static List<Map<String, dynamic>> settingsData = [
    {
      "Title": "Currency",
      "Default-Selection": "USD",
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

  static List navigationViewsForSettings = [
    CurrencyView(),
    const NotificationSettingsView(),
    AboutView(),
    HelpView(),
  ];

  static List navigationViewsForProfile = [
    const AccountView(),
    const SettingsView(),
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

  static List<Map<String, dynamic>> financialReport = [
    {
      "Background": AppColors.primaryRed,
      "Title": "This Month",
      "Description": "You Spend 💸",
      "Spend": 332,
      "Biggest-Spending-Title": "Your Biggest Spending is from",
      "Biggest-Spending": 120,
      "Category": "Shopping",
      "Icon": IconsPath.shopping,
      "Icon-Color": AppColors.primaryYellow,
      "Icon-Background": AppColors.yellow20,
    },
    {
      "Background": AppColors.primaryGreen,
      "Title": "This Month",
      "Description": "You Earned 💰",
      "Spend": 6000,
      "Biggest-Spending-Title": "Your Biggest Income is from",
      "Biggest-Spending": 5000,
      "Category": "Salary",
      "Icon": IconsPath.money,
      "Icon-Color": AppColors.primaryGreen,
      "Icon-Background": AppColors.green20,
    },
  ];

  static List<Map<String, dynamic>> bottomNavigationData = [
    {
      "Icon": IconsPath.home,
      "Title": "Home",
    },
    {
      "Icon": IconsPath.transaction,
      "Title": "Transaction",
    },
    {
      "Icon": IconsPath.budget,
      "Title": "Budget",
    },
    {
      "Icon": IconsPath.userProfile,
      "Title": "Profile",
    },
  ];

  static List bottomNavigationViews = [
    const DashboardUI(),
    const TransactionView(),
    const BudgetView(),
    const ProfileView(),
  ];

  static List<Map<String, dynamic>> notificationsData = [
    {
      "Title": "Shopping budget has exceeds the limit",
      "Description": "Your shopping budget has exceeds the limit",
      "Time": "19.30",
    },
    {
      "Title": "Utilities budget has exceeds the limit",
      "Description": "Your utilities budget has exceeds the limit",
      "Time": "17.28",
    },
    {
      "Title": "Travel budget has exceeds the limit",
      "Description": "Your travel budget has exceeds the limit",
      "Time": "23.07",
    },
  ];

  static List<String> accountTypes = [
    "Wallet",
    "Bank",
  ];

  static List<String> menuItems = [
    "Mark All Read",
    "Remove all",
  ];

  static List<String> filterbyData = [
    "Income",
    "Expense",
    "Transfer",
  ];

  static List<String> sortbyData = [
    "Highest",
    "Lowest",
    "Newest",
    "Oldest",
  ];

  static List<Map<String, dynamic>> attachmentData = [
    {
      "Icon": IconsPath.camera,
      "Title": "Camera",
    },
    {
      "Icon": IconsPath.gallery,
      "Title": "Gallery",
    },
  ];
}
