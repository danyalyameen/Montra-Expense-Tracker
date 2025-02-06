class DefaultOptionsModel {
  List<IncomeOptions>? defaultIncomeOptions;
  List<ExpenseOptions>? defaultExpenseOptions;

  DefaultOptionsModel({this.defaultIncomeOptions, this.defaultExpenseOptions});

  DefaultOptionsModel.store(Map<String, dynamic> json) {
    if (json['income options'] != null) {
      defaultIncomeOptions = <IncomeOptions>[];
      json['income options'].forEach(
        (v) {
          defaultIncomeOptions!.add(IncomeOptions.store(v));
        },
      );
    }
    if (json['expense options'] != null) {
      defaultExpenseOptions = <ExpenseOptions>[];
      json['expense options'].forEach(
        (v) {
          defaultExpenseOptions!.add(ExpenseOptions.store(v));
        },
      );
    }
  }

  Map<String, dynamic> receive() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (defaultIncomeOptions != null) {
      data['income options'] =
          defaultIncomeOptions!.map((v) => v.recieve()).toList();
    }
    if (defaultExpenseOptions != null) {
      data['expense options'] =
          defaultExpenseOptions!.map((v) => v.recieve()).toList();
    }
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
