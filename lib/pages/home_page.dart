import 'package:chang_mini/services/bank_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class BankInformation {
  late String bankName;
  late int bankMoney;

  BankInformation(this.bankName, this.bankMoney);
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  List<String> bankNameList = ['카카오뱅크', '신한은행'];
  List<String> bankMoneyList = ['1,137,994,000원', '188,500,000원'];
  List<BankInformation> BankInforList = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<BankService>(
      builder: (context, service, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.grey[200],
            title: Row(
              children: [
                Text(
                  'toss',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            leading: IconButton(
              onPressed: () {
                print('토스아이콘클릭');
              },
              icon: Icon(
                Icons.home,
                color: Colors.grey[400],
                size: 30,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 1),
                child: IconButton(
                  onPressed: () {
                    print('QR클릭');
                  },
                  icon: Icon(
                    Icons.umbrella,
                    color: Colors.grey[400],
                  ),
                  iconSize: 30,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 1),
                child: IconButton(
                  onPressed: () {
                    print('말풍선클릭');
                  },
                  icon: Icon(
                    Icons.phone_in_talk_sharp,
                    color: Colors.grey[400],
                  ),
                  iconSize: 30,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 2),
                child: IconButton(
                  onPressed: () {
                    print('알림클릭');
                  },
                  icon: Icon(
                    Icons.alarm_on_sharp,
                    color: Colors.grey[400],
                  ),
                  iconSize: 30,
                ),
              ),
            ],
          ),
          body: Container(
            padding: EdgeInsets.only(
              left: 8,
              right: 8,
              bottom: 8,
            ),
            color: Colors.grey[200],
            child: Card(
              child: Column(
                children: [
                  Card(
                    child: ListTile(
                      leading: Text(
                        '자산',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // trailing: IconButton(onPressed: () {}, icon: Icon(Icons.control_point)
                      trailing: IconButton(
                        onPressed: () {
                          print('은행추가');
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: bankNameList.length,
                      itemBuilder: (context, index) {
                        String bankName = bankNameList[index];
                        String bankMoney = bankMoneyList[index];
                        return Card(
                          child: ListTile(
                            leading: Container(
                              height: double.infinity,
                              child: Icon(Icons.circle_sharp,
                                  size: 40, color: Colors.black),
                            ),
                            title: Text(
                              bankName,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            subtitle: Text(
                              bankMoney,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            trailing: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey[350],
                              ),
                              onPressed: () {
                                print('$bankName 송금하기');
                              },
                              child: Text(
                                '송금',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

