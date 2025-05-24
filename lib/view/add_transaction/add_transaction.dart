import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spendie_money_tracker/controller/add_transaction_controller.dart';
import 'package:spendie_money_tracker/utils/global_constants.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Add Transaction',
          style: TextStyle(
            color: GlobalConstants.text,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        toolbarHeight: 100,
        backgroundColor: GlobalConstants.primary.withAlpha(90),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _tabController != null
              ? TabBar(
                controller: _tabController,
                labelColor: GlobalConstants.primary,
                unselectedLabelColor: Colors.grey,
                indicatorColor: GlobalConstants.primary,
                tabs: [Tab(text: "Income"), Tab(text: "Expense")],
              )
              : SizedBox(),
          Expanded(
            child:
                _tabController != null
                    ? TabBarView(
                      controller: _tabController,
                      children: [_buildIncomeForm(), _buildExpenseForm()],
                    )
                    : Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }

  Widget _buildIncomeForm() {
    final screenState = context.watch<AddTransactionController>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Income",
                  style: TextStyle(
                    color: GlobalConstants.primary,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Transaction Name",
                  style: TextStyle(color: GlobalConstants.primary),
                ),
                TextFormField(
                  controller: screenState.incomenamecontroller,
                  decoration: InputDecoration(),
                ),
                SizedBox(height: 20),
                Text(
                  "Amount",
                  style: TextStyle(color: GlobalConstants.primary),
                ),
                TextFormField(
                  controller: screenState.incomeamountcontroller,
                  decoration: InputDecoration(),
                ),
                SizedBox(height: 20),
                Text("Date", style: TextStyle(color: GlobalConstants.primary)),
                TextFormField(
                  controller: screenState.incomedatecontroller,
                  readOnly: true,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.calendar_today),
                    border: UnderlineInputBorder(),
                  ),
                  onTap:
                      () => context.read<AddTransactionController>().selectDate(
                        context,
                      ),
                ),
                SizedBox(height: 20),

                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<AddTransactionController>().addIncome(
                      context: context,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: GlobalConstants.primary.withAlpha(90),
                  ),
                  child: Center(
                    child: Text(
                      "Save",
                      style: TextStyle(
                        fontSize: 18,
                        color: GlobalConstants.text,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpenseForm() {
    final screenState = context.watch<AddTransactionController>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Expense",
                  style: TextStyle(
                    color: GlobalConstants.primary,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Transaction Name",
                  style: TextStyle(color: GlobalConstants.primary),
                ),
                TextFormField(
                  controller: screenState.expensenamecontroller,
                  decoration: InputDecoration(),
                ),
                SizedBox(height: 20),
                Text(
                  "Amount",
                  style: TextStyle(color: GlobalConstants.primary),
                ),
                TextFormField(
                  controller: screenState.expenseamountcontroller,
                  decoration: InputDecoration(),
                ),
                SizedBox(height: 20),
                Text("Date", style: TextStyle(color: GlobalConstants.primary)),
                TextFormField(
                  controller: screenState.expensedatecontroller,
                  readOnly: true,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.calendar_today),
                    border: UnderlineInputBorder(),
                  ),
                  onTap:
                      () => context.read<AddTransactionController>().selectDate(
                        context,
                      ),
                ),
                SizedBox(height: 20),

                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<AddTransactionController>().addExpense(
                      context: context,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: GlobalConstants.primary.withAlpha(90),
                  ),
                  child: Center(
                    child: Text(
                      "Save",
                      style: TextStyle(
                        fontSize: 18,
                        color: GlobalConstants.text,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
