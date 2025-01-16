class PersonData {
  String? name;
  List<Wallets>? wallets;
  List<IncomeOptions>? incomeOptions;
  List<ExpenseOptions>? expenseOptions;

  PersonData({this.name, this.wallets, this.incomeOptions, this.expenseOptions});

  PersonData.store(Map<String, dynamic> json) {
    name = json['name'];
    if (json['Wallets'] != null) {
      wallets = <Wallets>[];
      json['Wallets'].forEach(
        (v) {
          wallets!.add(Wallets.store(v));
        },
      );
    }
    if (json['income options'] != null) {
      incomeOptions = <IncomeOptions>[];
      json['income options'].forEach(
        (v) {
          incomeOptions!.add(IncomeOptions.store(v));
        },
      );
    }
    if (json['expense options'] != null) {
      expenseOptions = <ExpenseOptions>[];
      json['expense options'].forEach(
        (v) {
          expenseOptions!.add(ExpenseOptions.store(v));
        },
      );
    }
  }

  Map<String, dynamic> receive() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) data['name'] = name;
    if (wallets != null) {
      data['Wallets'] = wallets!.map((v) => v.receive()).toList();
    }
    if (incomeOptions != null) {
      data['income options'] = incomeOptions!.map((v) => v.recieve()).toList();
    }
    if (expenseOptions != null) {
      data['expense options'] = expenseOptions!.map((v) => v.recieve()).toList();
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

  Transactions(
      {this.type, this.category, this.transactionPrice, this.description});

  Transactions.store(Map<String, dynamic> json) {
    type = json['type'];
    category = json['category'];
    transactionPrice = json['transactionPrice'];
    description = json['description'];
  }

  Map<String, dynamic> recieve() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['category'] = category;
    data['transactionPrice'] = transactionPrice;
    data['description'] = description;
    return data;
  }
}

class IncomeOptions {
  String? option;
  String? color;

  IncomeOptions({this.option, this.color});

  IncomeOptions.store(Map<String, dynamic> json) {
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

class ExpenseOptions {
  String? option;
  String? color;

  ExpenseOptions({this.option, this.color});

  ExpenseOptions.store(Map<String, dynamic> json) {
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
