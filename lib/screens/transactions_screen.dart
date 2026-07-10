// ignore_for_file: deprecated_member_use

import 'package:expense_tracker_app/models/category.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/models/transaction_type.dart';
import 'package:expense_tracker_app/services/expense_helper.dart';
import 'package:expense_tracker_app/widgets/empty_state.dart';
import 'package:expense_tracker_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';

  void _filterSearch() {
    String text = _searchController.text.trim();

    setState(() {
      _selectedFilter = text;
    });
  }

  void _setFilter(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  Future<List<Expense>> _initExpense() async {
    if (_selectedFilter == 'All') {
      return await ExpensesHelper.retrieve(null);
    }

    String? filterType;
    for (TType value in TType.values) {
      if (value.label == _selectedFilter) {
        filterType = 'Type';
      }
    }
    if (filterType == null) {
      for (Category value in Category.values) {
        if (value.label == _selectedFilter) {
          filterType = 'Category';
        }
      }
    }

    if (filterType == null) {
      return await ExpensesHelper.search(_selectedFilter);
    }

    return await ExpensesHelper.retrieveBy(filterType, _selectedFilter);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    final List<String> filterList = ['All'];

    for (TType value in TType.values) {
      filterList.add(value.label);
    }

    for (Category value in Category.values) {
      filterList.add(value.label);
    }

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        title: Text('All Transactions'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: Column(
            children: [
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: color.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: color.secondary.withOpacity(0.1),
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 8,
                    right: 8,
                    bottom: 8,
                    top: 3,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.search),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onSubmitted: (_) {
                            _filterSearch();
                          },
                          style: TextStyle(color: color.primary),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: "Search transactions...",
                            hintStyle: TextStyle(color: color.secondary),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filterList.length,
                  itemBuilder: (BuildContext context, int index) {
                    String filterItem = filterList[index];
                    bool isSelected = filterItem == _selectedFilter;

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: InkWell(
                        onTap: () {
                          _setFilter(filterItem);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(18),
                            color: isSelected
                                ? color.onSurface
                                : color.secondary.withOpacity(0.1),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 6,
                              right: 24,
                              left: 24,
                            ),
                            child: Text(
                              filterList[index],
                              style: TextStyle(
                                color: isSelected
                                    ? color.primary
                                    : color.secondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
      body: FutureBuilder<List<Expense>>(
        future: _initExpense(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error Retrieving Data'));
          }

          if (snapshot.data!.isEmpty) {
            return EmptyState();
          }

          return TransactionList(expenses: snapshot.data!);
        },
      ),
    );
  }
}
