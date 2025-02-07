import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:montra_expense_tracker/Models/default_options_model.dart';
import 'package:montra_expense_tracker/Models/person_model.dart';
import 'package:montra_expense_tracker/Service/Authentication/auth_service.dart';

class OptionService {
  DocumentReference user = FirebaseFirestore.instance
      .collection('users')
      .doc(AuthService().getUser()!.uid);
  DocumentReference incomeOption = FirebaseFirestore.instance
      .collection("default options")
      .doc("income options");
  DocumentReference expenseOption = FirebaseFirestore.instance
      .collection('default options')
      .doc("expense options");

  Future<bool> addExpenseOption(
      {required String name, required Color color}) async {
    var error = false;
    String hexCode = '0xFF'
        '${(color.a * 255).round().toRadixString(16).padLeft(2, '0').toUpperCase()}'
        '${(color.r * 255).round().toRadixString(16).padLeft(2, '0').toUpperCase()}'
        '${(color.g * 255).round().toRadixString(16).padLeft(2, '0').toUpperCase()}'
        '${(color.b * 255).round().toRadixString(16).padLeft(2, '0').toUpperCase()}';
    var data = await user.get();
    var defaultExpenseOptionsData = await expenseOption.get();
    PersonData personData =
        PersonData.store(data.data() as Map<String, dynamic>);
    var defaultExpenseCategories = DefaultOptionsModel.store(
        defaultExpenseOptionsData.data() as Map<String, dynamic>);
    personData.userExpenseOptions ??= [];
    if (personData.userExpenseOptions!.isNotEmpty) {
      for (var defaultCategory
          in defaultExpenseCategories.defaultExpenseOptions!) {
        if (defaultCategory.option == name) {
          error = true;
          break;
        } else {
          if (defaultCategory ==
              defaultExpenseCategories.defaultExpenseOptions!.last) {
            for (var userExpenseCategory in personData.userExpenseOptions!) {
              if (userExpenseCategory.option == name) {
                error = true;
                break;
              } else {
                if (userExpenseCategory ==
                    personData.userExpenseOptions!.last) {
                  personData.userExpenseOptions!.add(UserExpenseOptions(
                      option: name, color: color.toString()));
                  await user.update(PersonData(
                          userExpenseOptions: personData.userExpenseOptions!)
                      .receive());
                  error = false;
                }
              }
            }
          }
        }
      }
    } else {
      for (var defaultCategory
          in defaultExpenseCategories.defaultExpenseOptions!) {
        if (defaultCategory.option == name) {
          error = true;
          break;
        } else {
          if (defaultCategory ==
              defaultExpenseCategories.defaultExpenseOptions!.last) {
            personData.userExpenseOptions!
                .add(UserExpenseOptions(option: name, color: hexCode));
            await user.update(
                PersonData(userExpenseOptions: personData.userExpenseOptions!)
                    .receive());
            error = false;
          }
        }
      }
    }
    return error;
  }

  Future<List> getExpenseOptions() async {
    var data = await user.get();
    PersonData personData =
        PersonData.store(data.data() as Map<String, dynamic>);
    var expenseOptionsData = await expenseOption.get();
    DefaultOptionsModel expenseOptions = DefaultOptionsModel.store(
        expenseOptionsData.data() as Map<String, dynamic>);
    List expenses = [];
    expenses = [
      ...personData.userExpenseOptions ?? [],
      ...expenseOptions.defaultExpenseOptions ?? []
    ];
    return expenses;
  }

  Future<bool> addIncomeOption(
      {required String name, required Color color}) async {
    var error = false;
    String hexCode = '0xFF'
        '${(color.a * 255).round().toRadixString(16).padLeft(2, '0').toUpperCase()}'
        '${(color.r * 255).round().toRadixString(16).padLeft(2, '0').toUpperCase()}'
        '${(color.g * 255).round().toRadixString(16).padLeft(2, '0').toUpperCase()}'
        '${(color.b * 255).round().toRadixString(16).padLeft(2, '0').toUpperCase()}';
    var data = await user.get();
    var defaultIncomeOptionsData = await incomeOption.get();
    PersonData personData =
        PersonData.store(data.data() as Map<String, dynamic>);
    var defaultIncomeSources = DefaultOptionsModel.store(
        defaultIncomeOptionsData.data() as Map<String, dynamic>);
    personData.userIncomeOptions ??= [];
    if (personData.userIncomeOptions!.isNotEmpty) {
      for (var defaultIncome in defaultIncomeSources.defaultIncomeOptions!) {
        if (defaultIncome.option == name) {
          error = true;
          break;
        } else {
          if (defaultIncome ==
              defaultIncomeSources.defaultIncomeOptions!.last) {
            for (var userIncomeSources in personData.userIncomeOptions!) {
              if (userIncomeSources.option == name) {
                error = true;
                break;
              } else {
                if (userIncomeSources == personData.userIncomeOptions!.last) {
                  personData.userIncomeOptions!.add(
                      UserIncomeOptions(option: name, color: color.toString()));
                  await user.update(PersonData(
                          userIncomeOptions: personData.userIncomeOptions!)
                      .receive());
                  error = false;
                }
              }
            }
          }
        }
      }
    } else {
      for (var defaultIncome in defaultIncomeSources.defaultIncomeOptions!) {
        if (defaultIncome.option == name) {
          error = true;
          break;
        } else {
          if (defaultIncome ==
              defaultIncomeSources.defaultIncomeOptions!.last) {
            personData.userIncomeOptions!
                .add(UserIncomeOptions(option: name, color: hexCode));
            await user.update(
                PersonData(userIncomeOptions: personData.userIncomeOptions!)
                    .receive());
            error = false;
          }
        }
      }
    }
    return error;
  }

  Future<List> getIncomeOptions() async {
    var data = await user.get();
    PersonData personData =
        PersonData.store(data.data() as Map<String, dynamic>);
    var incomeOptionsData = await incomeOption.get();
    DefaultOptionsModel incomeOptions = DefaultOptionsModel.store(
        incomeOptionsData.data() as Map<String, dynamic>);
    List incomes = [];
    incomes = [
      ...personData.userIncomeOptions ?? [],
      ...incomeOptions.defaultIncomeOptions ?? []
    ];
    return incomes;
  }
}
