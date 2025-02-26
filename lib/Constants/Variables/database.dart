import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Budget/Views/budget_view.dart';
import 'package:montra_expense_tracker/Features/Dashboard/Views/dashboard_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Account/Views/account_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/About/Views/about_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Currency/Views/currency_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Help/Views/help_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Views/settings_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Views/profile_view.dart';
import 'package:montra_expense_tracker/Features/Transaction/Views/transaction_view.dart';

class Database {
  // On Boarding Data
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
  
  // Settings Data
  static List<Map<String, dynamic>> settingsData = [
    {
      "Title": "Currency",
      "Default-Selection": "USD",
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
  
  // Currencies
  static List<Map<String, dynamic>> currencyData = [
    {"Currency": "United States (USD)", "isSelect": true, "Symbol": "USD"},
    {"Currency": "Pakistan (PKR)", "isSelect": false, "Symbol": "PKR"},
    {"Currency": "Indonesia (IDR)", "isSelect": false, "Symbol": "IDR"},
    {"Currency": "Japan (JPY)", "isSelect": false, "Symbol": "JPY"},
    {"Currency": "Russia (RUB)", "isSelect": false, "Symbol": "RUB"},
    {"Currency": "Germany (EUR)", "isSelect": false, "Symbol": "EUR"},
    {"Currency": "Korea (WON)", "isSelect": false, "Symbol": "WON"},
  ];
  
  // Navigation Views
  static List navigationViewsForSettings = [
    const CurrencyView(),
    const AboutView(),
    const HelpView(),
  ];
  
  // Navigation Views For Profile
  static List navigationViewsForProfile = [
    const AccountView(),
    const SettingsView(),
  ];
  
  // Profile Data
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
  
  // Months
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

  // Bottom Navigation
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
  
  // Navigation Views
  static List bottomNavigationViews = [
    const DashboardUI(),
    const TransactionView(),
    const BudgetView(),
    const ProfileView(),
  ];
  
  // Types of Account
  static List<String> accountTypes = [
    "Wallet",
    "Bank",
  ];
  
  // filter Options
  static List<String> filterbyData = [
    "Income",
    "Expense",
    "Transfer",
  ];
  
  // Sort Options
  static List<String> sortbyData = [
    "Highest",
    "Lowest",
    "Newest",
    "Oldest",
  ];
}
