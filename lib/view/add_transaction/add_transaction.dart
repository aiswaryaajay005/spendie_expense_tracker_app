import 'package:flutter/material.dart';
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
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        toolbarHeight: 100,
        backgroundColor: GlobalConstants.primary,
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
                Text(
                  "Transaction Name",
                  style: TextStyle(color: GlobalConstants.primary),
                ),
                TextFormField(decoration: InputDecoration()),
                SizedBox(height: 20),
                Text(
                  "Amount",
                  style: TextStyle(color: GlobalConstants.primary),
                ),
                TextFormField(decoration: InputDecoration()),
                SizedBox(height: 20),
                Text("Date", style: TextStyle(color: GlobalConstants.primary)),
                TextFormField(decoration: InputDecoration()),
                SizedBox(height: 20),

                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: GlobalConstants.primary,
                  ),
                  child: Center(
                    child: Text(
                      "Save",
                      style: TextStyle(fontSize: 18, color: Colors.white),
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
                Text(
                  "Transaction Name",
                  style: TextStyle(color: GlobalConstants.primary),
                ),
                TextFormField(decoration: InputDecoration()),
                SizedBox(height: 20),
                Text(
                  "Amount",
                  style: TextStyle(color: GlobalConstants.primary),
                ),
                TextFormField(decoration: InputDecoration()),
                SizedBox(height: 20),
                Text("Date", style: TextStyle(color: GlobalConstants.primary)),
                TextFormField(decoration: InputDecoration()),
                SizedBox(height: 20),

                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: GlobalConstants.primary,
                  ),
                  child: Center(
                    child: Text(
                      "Save",
                      style: TextStyle(fontSize: 18, color: Colors.white),
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
