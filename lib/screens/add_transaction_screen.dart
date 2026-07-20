// ignore_for_file: deprecated_member_use

import 'package:expense_tracker_app/l10n/app_localizations.dart';
import 'package:expense_tracker_app/models/category.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/models/transaction_type.dart';
import 'package:expense_tracker_app/services/expense_helper.dart';
import 'package:expense_tracker_app/widgets/grid_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class AddTransactionScreen extends StatefulWidget {
  final Expense? expense;
  final bool update;
  const AddTransactionScreen({super.key, this.expense, this.update = false});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  TType _transactionType = TType.expense;
  final TextEditingController _amountController = TextEditingController();
  Category _selectedCategory = Category.food;
  final TextEditingController _textController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.update) {
      _transactionType = widget.expense!.type;
      _amountController.text = widget.expense!.amount.toStringAsFixed(2);
      _selectedCategory = widget.expense!.category;
      _textController.text = widget.expense!.text;
      _selectedDate = widget.expense!.timestamp;
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _setItem(Category item) {
    setState(() {
      _selectedCategory = item;
    });
  }

  Future<void> _selectDate() async {
    DateTime now = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
      ),
      firstDate: DateTime(1947),
      lastDate: DateTime(now.year, now.month, now.day),
    );

    if (pickedDate == null) return;
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  Future<void> _removeExpense() async {
    await ExpensesHelper.remove(widget.expense!);
    Navigator.pop(context);
  }

  Future<void> _saveExpense() async {
    String text = _textController.text.trim();
    double amt = double.parse(_amountController.text.trim());
    Expense expense = Expense(
      text,
      amt,
      _transactionType,
      _selectedCategory,
      _selectedDate,
    );

    if (widget.update) {
      expense.id = widget.expense!.id;
      await ExpensesHelper.update(expense);
    } else {
      await ExpensesHelper.insert(expense);
    }
    
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: widget.update
            ? Text(locale.addTPUTitle)
            : Text(locale.addTPTitle),
        actions: [
          widget.update
              ? IconButton(
                  onPressed: _removeExpense,
                  icon: Icon(Icons.delete_outlined, color: Colors.red.shade700),
                )
              : SizedBox(width: 0),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: SegmentedButton<TType>(
                      showSelectedIcon: false,
                      selected: <TType>{_transactionType},
                      onSelectionChanged: (Set<TType> newSelection) {
                        setState(() {
                          _transactionType = newSelection.first;
                        });
                      },
                      segments: [
                        ButtonSegment<TType>(
                          value: TType.expense,
                          label: Text(locale.expenses(1)),
                        ),
                        ButtonSegment<TType>(
                          value: TType.income,
                          label: Text(locale.income),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              Container(
                height: 180,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: color.secondary.withOpacity(0.1),
                ),
                child: Column(
                  children: [
                    Text(
                      locale.amountSpent,
                      style: TextStyle(color: color.secondary, fontSize: 14),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          locale.currency,
                          style: TextStyle(
                            color: color.onSurface,
                            fontSize: 32,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            style: const TextStyle(fontSize: 28),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d{0,2}'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),
              Text(locale.selectCategory, style: TextStyle(color: color.secondary)),
              SizedBox(height: 12),

              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                primary: false,
                padding: EdgeInsets.all(6),
                crossAxisCount: 4,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
                children: [
                  GridItem(
                    setItem: _setItem,
                    selectedItem: _selectedCategory,
                    item: Category.food,
                  ),
                  GridItem(
                    setItem: _setItem,
                    selectedItem: _selectedCategory,
                    item: Category.transit,
                  ),
                  GridItem(
                    setItem: _setItem,
                    selectedItem: _selectedCategory,
                    item: Category.shop,
                  ),
                  GridItem(
                    setItem: _setItem,
                    selectedItem: _selectedCategory,
                    item: Category.bills,
                  ),
                  GridItem(
                    setItem: _setItem,
                    selectedItem: _selectedCategory,
                    item: Category.entertainment,
                  ),
                  GridItem(
                    setItem: _setItem,
                    selectedItem: _selectedCategory,
                    item: Category.health,
                  ),
                  GridItem(
                    setItem: _setItem,
                    selectedItem: _selectedCategory,
                    item: Category.home,
                  ),
                  GridItem(
                    setItem: _setItem,
                    selectedItem: _selectedCategory,
                    item: Category.edu,
                  ),
                ],
              ),

              SizedBox(height: 24),
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
                      Icon(Icons.border_color_outlined),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          style: TextStyle(color: color.primary),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),

              Center(
                child: Container(
                  height: 60,
                  width: double.infinity,
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
                        Icon(Icons.calendar_today_outlined),
                        SizedBox(width: 8),
                        Expanded(
                          child: InkWell(
                            onTap: _selectDate,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  DateFormat(
                                    'EEE, d MMM,y',
                                  ).format(_selectedDate),
                                ),
                                Icon(Icons.keyboard_arrow_down),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  await _saveExpense();
                },
                child: Text(locale.saveTransaction),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
