import 'package:cloud_firestore/cloud_firestore.dart';

class PersonData {
  String? name;
  bool? imageUploaded;
  List<Wallets>? wallets;
  List<UserIncomeOptions>? userIncomeOptions;
  List<UserExpenseOptions>? userExpenseOptions;
  List<Budget>? budget;

  PersonData(
      {this.name,
      this.imageUploaded,
      this.wallets,
      this.userIncomeOptions,
      this.userExpenseOptions,
      this.budget});

  PersonData.store(Map<String, dynamic> json) {
    name = json['Name'];
    imageUploaded = json['imageUploaded'];
    if (json['Wallets'] != null) {
      wallets = <Wallets>[];
      json['Wallets'].forEach(
        (v) {
          wallets!.add(Wallets.store(v));
        },
      );
    }
    if (json['income options'] != null) {
      userIncomeOptions = <UserIncomeOptions>[];
      json['income options'].forEach(
        (v) {
          userIncomeOptions!.add(UserIncomeOptions.store(v));
        },
      );
    }
    if (json['expense options'] != null) {
      userExpenseOptions = <UserExpenseOptions>[];
      json['expense options'].forEach(
        (v) {
          userExpenseOptions!.add(UserExpenseOptions.store(v));
        },
      );
    }
    if (json['Budgets'] != null) {
      budget = <Budget>[];
      json['Budgets'].forEach(
        (v) {
          budget!.add(Budget.store(v));
        },
      );
    }
  }

  Map<String, dynamic> receive() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) data['Name'] = name;
    if (imageUploaded != null) data['imageUploaded'] = imageUploaded;
    if (wallets != null) {
      data['Wallets'] = wallets!.map((v) => v.receive()).toList();
    }
    if (userIncomeOptions != null) {
      data['income options'] =
          userIncomeOptions!.map((v) => v.recieve()).toList();
    }
    if (userExpenseOptions != null) {
      data['expense options'] =
          userExpenseOptions!.map((v) => v.recieve()).toList();
    }
    if (budget != null) {
      data['Budgets'] = budget!.map((v) => v.recieve()).toList();
    }
    return data;
  }
}

class Wallets {
  String? walletName;
  int? balance;
  String? accountType;
  List<Transactions>? transactions;

  Wallets({this.walletName, this.balance, this.accountType, this.transactions});

  Wallets.store(Map<String, dynamic> json) {
    walletName = json['walletName'];
    balance = json['balance'];
    accountType = json['accountType'];
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(Transactions.store(v));
      });
    }
  }

  Map<String, dynamic> receive() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (walletName != null) data['walletName'] = walletName;
    if (balance != null) data['balance'] = balance;
    if (accountType != null) data['accountType'] = accountType;
    if (transactions != null) {
      data['transactions'] = transactions!.map((v) => v.recieve()).toList();
    }
    return data;
  }
}

class Transactions {
  String? type;
  String? category;
  int? transactionPrice;
  String? description;
  Timestamp? time;

  Transactions(
      {this.type,
      this.category,
      this.transactionPrice,
      this.description,
      this.time});

  Transactions.store(Map<String, dynamic> json) {
    type = json['type'];
    category = json['category'];
    transactionPrice = json['transactionPrice'];
    description = json['description'];
    time = json['time'];
  }

  Map<String, dynamic> recieve() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['category'] = category;
    data['transactionPrice'] = transactionPrice;
    data['description'] = description;
    data['time'] = time;
    return data;
  }
}

class UserIncomeOptions {
  String? option;
  String? color;

  UserIncomeOptions({this.option, this.color});

  UserIncomeOptions.store(Map<String, dynamic> json) {
    option = json['option'];
    color = json['color'];
  }

  Map<String, dynamic> recieve() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['option'] = option;
    data['color'] = color;
    return data;
  }
}

class UserExpenseOptions {
  String? option;
  String? color;

  UserExpenseOptions({this.option, this.color});

  UserExpenseOptions.store(Map<String, dynamic> json) {
    option = json['option'];
    color = json['color'];
  }

  Map<String, dynamic> recieve() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['option'] = option;
    data['color'] = color;
    return data;
  }
}

class Budget {
  String? category, color;
  int? balance, alertLimit;
  Timestamp? month;

  Budget(
      {this.balance, this.category, this.alertLimit, this.month, this.color});

  Budget.store(Map<String, dynamic> json) {
    color = json['color'];
    balance = json['balance'];
    category = json['category'];
    alertLimit = json['alertLimit'];
    month = json['month'];
  }

  Map<String, dynamic> recieve() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['balance'] = balance;
    data['category'] = category;
    data['alertLimit'] = alertLimit;
    data['month'] = month;
    data['color'] = color;
    return data;
  }
}
