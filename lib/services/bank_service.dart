import 'dart:convert';

import 'package:chang_mini/model/bank.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BankService extends ChangeNotifier {
  var f = NumberFormat('###,###,###,###');

  SharedPreferences? savedData;
  List<Bank> myBankList = [];

  BankService(SharedPreferences this.savedData) {
    getPrefsData();
  }

  createdBank(Bank bank) async {
    myBankList.add(bank);
    await saveData();

    notifyListeners();
  }

  bool sendMoney(Bank fromBank, Bank toBank, int money) {
    if ((fromBank.balance ?? 0) < money) {
      return false;
    }

    fromBank.balance = (fromBank.balance ?? 0) - money;
    toBank.balance = (toBank.balance ?? 0) + money;

    saveData();

    notifyListeners();
    return true;
  }

  getPrefsData() {
    String? savedString = savedData?.getString('banks');
    if (savedString != null) {
      myBankList = [];
      jsonDecode(savedString).forEach((e) {
        myBankList.add(Bank.fromJson(e));
      });
    }
  }

  saveData() {
    savedData?.setString(
      'banks',
      jsonEncode(
        myBankList.map((e) => e.toJson()).toList(),
      ),
    );
  }
}
