import 'package:chang_mini/services/bank_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/colors.dart';
import '../model/bank.dart';

class SendPage extends StatefulWidget {
  final Bank? fromBank;

  const SendPage({
    Key? key,
    this.fromBank,
  }) : super(key: key);

  @override
  State<SendPage> createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  Bank? toBank;
  TextEditingController moneyController = TextEditingController();
  FocusNode moneyNode = FocusNode();

  @override
  void initState() {
    toBank = widget.fromBank;
    super.initState();
  }

  @override
  void dispose() {
    moneyController.dispose();
    moneyNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BankService>(
      builder: (context, bankService, child) {
        return GestureDetector(
          onTap: () {},
          child: Scaffold(
            backgroundColor: TossColor.grey2,
            appBar: createAppBar(context),
            body: createBody(bankService),
            bottomNavigationBar: createNavigationBar(context, bankService),
          ),
        );
      },
    );
  }

  ElevatedButton createNavigationBar(context, bankService) {
    return ElevatedButton(
      onPressed: () {
        if ((widget.fromBank?.balance ?? 0) <
            (int.tryParse(
                  moneyController.text.replaceAll(',', ''),
                ) ??
                0)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: TossColor.bluegrey,
              content: Text("잔액이 부족해요"),
            ),
          );
        } else if (toBank != null && moneyController.text != '') {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Image.asset(
                  'assets/money_icon.png',
                  width: 32,
                ),
                title: Text(
                  '${toBank?.name} 으로 ${int.tryParse(
                    moneyController.text.replaceAll(',', ''),
                  )} 원을 보내시겠어요?',
                  style: const TextStyle(
                    color: TossColor.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      bankService.sendMoney(
                        widget.fromBank,
                        toBank!,
                        int.tryParse(
                                moneyController.text.replaceAll(',', '')) ??
                            0,
                      );
                      Navigator.pop(context);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: TossColor.blue,
                          content: Text("전송 완료"),
                        ),
                      );
                    },
                    child: const Text("보내기"),
                  )
                ],
              );
            },
          );
        }
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 52),
        onPrimary: TossColor.white,
        primary: TossColor.blue,
      ),
      child: const Text("보내기"),
    );
  }

  Container createBody(BankService bankService) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          createSenderText(),
          SizedBox(
            height: 20,
          ),
          createWhereText(),
          SizedBox(
            height: 8,
          ),
          createDropDownArea(bankService),
          createTextfieldArea(bankService),
          const SizedBox(
            height: 16,
          ),
          createBalanceArea(bankService),
          const Spacer(),
        ],
      ),
    );
  }

  Container createBalanceArea(bankService) {
    int balance = widget.fromBank?.balance ?? 0;
    return Container(
      alignment: Alignment.centerRight,
      child: Text("현재 잔액 : ${balance} 원"),
    );
  }

  TextFormField createTextfieldArea(BankService bankService) {
    return TextFormField(
      textAlign: TextAlign.end,
      controller: moneyController,
      focusNode: moneyNode,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        if (value != '') {
          String money = bankService.f.format(
            int.tryParse(
              value.replaceAll(
                ',',
                '',
              ),
            ),
          );
          moneyController.value = TextEditingValue(
            text: money,
            selection: TextSelection.collapsed(
              offset: money.length,
            ),
          );
        }
      },
      decoration: const InputDecoration(
        suffix: Text("원"),
      ),
    );
  }

  DropdownButton<Bank> createDropDownArea(BankService bankService) {
    return DropdownButton<Bank>(
      value: toBank,
      items: bankService.myBankList
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e.name ?? ''),
            ),
          )
          .toList(),
      onChanged: (bank) {
        setState(() {
          toBank = bank;
        });
      },
    );
  }

  Text createWhereText() {
    return Text(
      "어디로 보낼까요?",
      style: TextStyle(
        color: TossColor.blue,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Text createSenderText() {
    return Text(
      "송금하기",
      style: TextStyle(
        color: TossColor.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  AppBar createAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: TossColor.black,
        ),
      ),
      backgroundColor: TossColor.grey1,
      elevation: 0,
    );
  }
}
