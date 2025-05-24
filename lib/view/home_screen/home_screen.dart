import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spendie_money_tracker/controller/home_screen_controller.dart';
import 'package:spendie_money_tracker/helper/db_helper.dart';
import 'package:spendie_money_tracker/utils/global_constants.dart';
import 'package:spendie_money_tracker/view/add_transaction/add_transaction.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<HomeScreenController>().fetchTransaction();
      setState(() {});
    });
    final User? user = DbHelper.supabase.auth.currentUser;
    log('User ID: ${user?.id}');
    log('User Email: ${user?.email}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeState = context.watch<HomeScreenController>();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: GlobalConstants.primary.withAlpha(90),
        title: SingleChildScrollView(
          child: Row(
            children: [
              Text(
                "Spendie",
                style: TextStyle(
                  color: GlobalConstants.text,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10),
              CircleAvatar(
                backgroundImage: AssetImage("assets/images/piggy.png"),
              ),
            ],
          ),
        ),
        actions: [
          Icon(Icons.info),
          SizedBox(width: 20),
          Icon(Icons.logout),
          SizedBox(width: 20),
        ],
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Total balance",
                        style: TextStyle(
                          color: GlobalConstants.bg,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "₹${homeState.totalBalance}",
                        style: TextStyle(
                          color: GlobalConstants.bg,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 20),
                  Icon(
                    Icons.account_balance_wallet,
                    size: 80,
                    color: GlobalConstants.bg,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Income",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                homeState.totalIncome.toString(),
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_upward,
                            size: 40,
                            color: GlobalConstants.accent,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Expense",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                homeState.totalExpense.toString(),
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_downward,
                            size: 40,
                            color: GlobalConstants.bg,
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
                  Text(
                    "Recent Expenses",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddTransaction(),
                        ),
                      );
                      await context
                          .read<HomeScreenController>()
                          .fetchTransaction();
                      setState(() {});
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                homeState.transactionDetails.isEmpty
                    ? Center(
                      child: Column(
                        children: [
                          Text("No transactions found"),
                          SizedBox(height: 10),
                        ],
                      ),
                    )
                    : RefreshIndicator(
                      onRefresh: () async {
                        await context
                            .read<HomeScreenController>()
                            .fetchTransaction();
                        setState(() {});
                      },
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: homeState.transactionDetails.length,
                        itemBuilder:
                            (context, index) => Padding(
                              padding: const EdgeInsets.only(
                                bottom: 10,
                                left: 10,
                                right: 10,
                              ),
                              child: ListTile(
                                onTap: () async {
                                  return await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          "Transaction Details",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Name: ${homeState.transactionDetails[index]['t_name']}",
                                            ),
                                            Text(
                                              "Date: ${homeState.transactionDetails[index]['t_date']}",
                                            ),
                                            Text(
                                              "Amount: ${homeState.transactionDetails[index]['t_amount']}",
                                            ),
                                            Text(
                                              "Type: ${homeState.transactionDetails[index]['t_type'] == '1' ? 'Income' : 'Expense'}",
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed:
                                                () => Navigator.pop(context),
                                            child: Text(
                                              "Close",
                                              style: TextStyle(
                                                color: GlobalConstants.primary,
                                              ),
                                            ),
                                          ),

                                          IconButton(
                                            onPressed: () async {
                                              context
                                                  .read<HomeScreenController>()
                                                  .deleteTransaction(
                                                    id:
                                                        homeState
                                                            .transactionDetails[index]['id'],
                                                  );
                                              await context
                                                  .read<HomeScreenController>()
                                                  .fetchTransaction();
                                              setState(() {});
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: GlobalConstants.primary,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                style: ListTileStyle.list,
                                title: Text(
                                  homeState.transactionDetails[index]['t_name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                                subtitle: Text(
                                  homeState.transactionDetails[index]['t_date'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                trailing: Text(
                                  homeState.transactionDetails[index]['t_type']
                                              .toString() ==
                                          "1"
                                      ? '+' +
                                          homeState
                                              .transactionDetails[index]['t_amount']
                                              .toString()
                                      : '-${homeState.transactionDetails[index]['t_amount']}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                                tileColor: GlobalConstants.secondary.withAlpha(
                                  50,
                                ),
                              ),
                            ),
                      ),
                    ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTransaction()),
          );
          await context.read<HomeScreenController>().fetchTransaction();
          setState(() {}); // Force UI rebuild
        },
        backgroundColor: GlobalConstants.primary,
        child: Icon(Icons.add, color: GlobalConstants.bg),
      ),
    );
  }
}
