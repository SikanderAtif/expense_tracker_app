import 'package:flutter/material.dart';

enum Category {
  food,
  transit,
  shop,
  bills,
  entertainment,
  health,
  home,
  edu;

  String get label {
    switch (this) {
      case food:
        return 'Food';
      case transit:
        return 'Transit';
      case shop:
        return 'Shop';
      case bills:
        return 'Bills';
      case entertainment:
        return 'Entertainment';
      case health:
        return 'Health';
      case home:
        return 'Home';
      case edu:
        return 'Education';
    }
  }

    IconData get icon {
    switch (this) {
      case food:
        return Icons.lunch_dining_outlined;
      case transit:
        return Icons.train_outlined;
      case shop:
        return Icons.shopping_bag_outlined;
      case bills:
        return Icons.receipt_outlined;
      case entertainment:
        return Icons.live_tv_outlined;
      case health:
        return Icons.favorite_outlined;
      case home:
        return Icons.home_outlined;
      case edu:
        return Icons.school_outlined;
    }
  }

  Color get color {
    switch(this) {
      case food: return Colors.green;
      case transit: return Colors.yellow;
      case shop: return Colors.pink;
      case bills: return Colors.blue.shade300;
      case entertainment: return Colors.purple;
      case health: return Colors.red.shade800;
      case home: return Colors.brown;
      case edu: return Colors.teal;
    }
  }
}
