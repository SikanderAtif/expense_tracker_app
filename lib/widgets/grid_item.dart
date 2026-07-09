// ignore_for_file: deprecated_member_use

import 'package:expense_tracker_app/models/category.dart';
import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
  final void Function(Category) _setItem;
  final Category _selectedItem;
  final Category _item;
  const GridItem({
    super.key,
    required this._setItem,
    required this._selectedItem,
    required this._item,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    final bool isSelected = _selectedItem == _item;

    return GestureDetector(
      onTap: () => _setItem(_item),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? color.onSurface
                    : color.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected
                      ? color.onSurface
                      : color.secondary.withOpacity(0.1),
                  width: 2,
                ),
              ),
              child: Icon(
                _item.icon,
                color: isSelected ? color.primary : color.secondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _item.label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? color.onSurface : color.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
