import 'package:flutter/material.dart';
import 'package:spendie_money_tracker/utils/global_constants.dart';
import 'package:spendie_money_tracker/view/add_transaction/add_transaction.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: GlobalConstants.primary.withAlpha(90),
        title: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Good morning",
                style: TextStyle(color: GlobalConstants.text, fontSize: 20),
              ),
              Text(
                "Aiswarya Ajayakumar",
                style: TextStyle(color: GlobalConstants.text, fontSize: 25),
              ),
            ],
          ),
        ),
        actions: [Icon(Icons.info), SizedBox(width: 10), Icon(Icons.logout)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(20),
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: GlobalConstants.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        "Total balance",
                        style: TextStyle(
                          color: GlobalConstants.bg,
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        "₹16000",
                        style: TextStyle(
                          color: GlobalConstants.bg,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 100,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: GlobalConstants.primary.withAlpha(50),
                      ),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text("Income", style: TextStyle(fontSize: 20)),
                              Text("₹ 35.1K", style: TextStyle(fontSize: 25)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 100,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: GlobalConstants.accent,
                      ),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text("Expense", style: TextStyle(fontSize: 20)),
                              Text("₹ 20.1K", style: TextStyle(fontSize: 25)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Text("Recent Expenses", style: TextStyle(fontSize: 20)),
                  Spacer(),
                  Icon(Icons.add),
                ],
              ),
            ),
            Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder:
                      (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          style: ListTileStyle.list,
                          title: Text("Rent"),
                          subtitle: Text("12/10/24"),
                          trailing: Text("-₹10.00"),
                          tileColor: GlobalConstants.secondary.withAlpha(50),
                        ),
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTransaction()),
          );
        },
        backgroundColor: GlobalConstants.primary,
        child: Icon(Icons.add, color: GlobalConstants.bg),
      ),
    );
  }
}
