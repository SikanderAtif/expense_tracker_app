import 'package:expense_tracker_app/l10n/app_localizations.dart';
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
}

extension CategoryLabel on Category {
  String getLocalizedName(AppLocalizations locale) {
    switch (this) {
      case Category.food:
        return locale.food;
      case Category.transit:
        return locale.transit;
      case Category.shop:
        return locale.shop;
      case Category.bills:
        return locale.bills;
      case Category.entertainment:
        return locale.entertainment;
      case Category.health:
        return locale.health;
      case Category.home:
        return locale.home;
      case Category.edu:
        return locale.edu;
    }
  }
}

extension CategoryTheme on Category {
  Color color(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch(this) {
      case Category.food: 
        return isDark ? Colors.green : Colors.green.shade300;
      case Category.transit: 
        return isDark ? Colors.yellow.shade700 : Colors.yellow.shade200;
      case Category.shop: 
        return isDark ? Colors.pink : Colors.pink.shade300;
      case Category.bills: 
        return isDark ? Colors.blue.shade300 : Colors.blue.shade200;
      case Category.entertainment: 
        return isDark ? Colors.purple : Colors.purple.shade300;
      case Category.health: 
        return isDark ? Colors.red.shade800 : Colors.red.shade300;
      case Category.home: 
        return isDark ? Colors.brown : Colors.brown.shade300;
      case Category.edu: 
        return isDark ? Colors.teal : Colors.teal.shade300;
    }
  }
}