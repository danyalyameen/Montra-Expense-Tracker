import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Models/person_model.dart';

class TransactionViewModel extends ViewModel {
  // Non Final Fields
  String _selectedFilter = Database.sortbyData[0];
  String _selectedSort = Database.sortbyData[0];
  List<Transactions> userTransactions = [];
  List<Transactions> sortTransactions = [];
  bool isApply = false;
  // Get Non Final Fields
  String get selectedFilter => _selectedFilter;
  String get selectedSort => _selectedSort;

  // Store New Filter Value
  void onChangeFilter(String value) {
    _selectedFilter = value;
  }

  // Store New Sort Value
  void onChangeSort(String value) {
    _selectedSort = value;
  }

  // Apply Button Function
  Future<List<Transactions>> filter() async {
    // Make it true
    isApply = true;
    // Get Transactions
    var transactions = await transactionsService.getTransactions();
    // Store transactions
    userTransactions = transactions;
    // Initiazlie Sorted Transactions List
    List<Transactions> sortedTransactions = [];
    // Filter Transactions into Three Categories
    var expenseTransactions =
        transactions.where((element) => element.type == "Expense").toList();
    var incomeTransactions =
        transactions.where((element) => element.type == "Income").toList();
    var transferTransactions =
        transactions.where((element) => element.type == "Transfer").toList();
    // Filtered the Transaction According to Selected Type
    if (_selectedFilter.isNotEmpty) {
      switch (selectedFilter) {
        case "Expense":
          switch (_selectedSort) {
            case "Highest":
              sortedTransactions = [];
              sortedTransactions = sortOut(
                transactions: expenseTransactions,
                reversed: true,
                byTime: false,
              );
              break;
            case "Lowest":
              sortedTransactions = [];
              sortedTransactions = sortOut(
                transactions: expenseTransactions,
                reversed: false,
                byTime: false,
              );
              break;
            case "Newest":
              sortedTransactions = [];
              sortedTransactions = sortOut(
                transactions: expenseTransactions,
                reversed: true,
                byTime: true,
              );
              break;
            case "Oldest":
              sortedTransactions = [];
              sortedTransactions = sortOut(
                transactions: expenseTransactions,
                reversed: false,
                byTime: true,
              );
              break;
          }
          break;
        case "Income":
          switch (_selectedSort) {
            case "Highest":
              sortedTransactions = [];
              sortedTransactions = sortOut(
                transactions: incomeTransactions,
                reversed: true,
                byTime: false,
              );
              break;
            case "Lowest":
              sortedTransactions = [];
              sortedTransactions = sortOut(
                transactions: incomeTransactions,
                reversed: false,
                byTime: false,
              );
              break;
            case "Newest":
              sortedTransactions = [];
              sortedTransactions = sortOut(
                transactions: incomeTransactions,
                reversed: true,
                byTime: true,
              );
              break;
            case "Oldest":
              sortedTransactions = [];
              sortedTransactions = sortOut(
                transactions: incomeTransactions,
                reversed: false,
                byTime: true,
              );
              break;
          }
          break;
        case "Transfer":
          switch (_selectedSort) {
            case "Highest":
              sortedTransactions = [];
              sortedTransactions = sortOut(
                transactions: transferTransactions,
                reversed: true,
                byTime: false,
              );
              break;
            case "Lowest":
              sortedTransactions = [];
              sortedTransactions = sortOut(
                transactions: transferTransactions,
                reversed: false,
                byTime: false,
              );
              break;
            case "Newest":
              sortedTransactions = [];
              sortedTransactions = sortOut(
                transactions: transferTransactions,
                reversed: true,
                byTime: true,
              );
              break;
            case "Oldest":
              sortedTransactions = [];
              sortedTransactions = sortOut(
                transactions: transferTransactions,
                reversed: false,
                byTime: true,
              );
              break;
          }
          break;
      }
    } else {
      switch (_selectedSort) {
        case "Highest":
          sortedTransactions = [];
          sortedTransactions = sortOut(
            transactions: transactions,
            reversed: true,
            byTime: false,
          );
          break;
        case "Lowest":
          sortedTransactions = [];
          sortedTransactions = sortOut(
            transactions: transactions,
            reversed: false,
            byTime: false,
          );
          break;
        case "Newest":
          sortedTransactions = [];
          sortedTransactions = sortOut(
            transactions: transactions,
            reversed: true,
            byTime: true,
          );
          break;
        case "Oldest":
          sortedTransactions = [];
          sortedTransactions = sortOut(
            transactions: transactions,
            reversed: false,
            byTime: true,
          );
          break;
      }
    }
    // Store Sort Transactions into Global Variables
    sortTransactions = sortedTransactions;
    // Return Sorted Transactions
    return sortedTransactions;
  }

  // Make a sort out method to sort the transactions and make code reuseful
  List<Transactions> sortOut(
      {required List<Transactions> transactions,
      required bool reversed,
      required bool byTime}) {
    List<Transactions> sortedTransactions = [];
    sortedTransactions = transactions;
    reversed
        ? byTime
            ? sortedTransactions.sort(
                (a, b) => b.time!.compareTo(a.time!),
              )
            : sortedTransactions.sort(
                (a, b) => b.transactionPrice!.compareTo(a.transactionPrice!),
              )
        : byTime
            ? sortedTransactions.sort(
                (a, b) => a.time!.compareTo(b.time!),
              )
            : sortedTransactions.sort(
                (a, b) => a.transactionPrice!.compareTo(b.transactionPrice!),
              );
    return sortedTransactions;
  }
}
