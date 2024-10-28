/*import 'package:flutter/material.dart';
import 'package:shopping_app/feature/home/cubit/item/item_cubit.dart';
import 'package:shopping_app/feature/home/view/grid_view.dart';
import 'package:shopping_app/feature/home/view/home_view.dart';
import 'package:shopping_app/product/global/global_model/global_item_model.dart';

mixin HomeViewModel on State<HomeView>{
   late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  MaskGridView tabItem(List<GlobalItemModel> items, int tabIndex) {
    final categoryFilters = [
      'men\'s clothing',
      'jewelery',
      'electronics',
      'women\'s clothing'
    ];

    return MaskGridView(
      items: items
          .where((item) => item.category == categoryFilters[tabIndex])
          .toList(),
    );
  }

  double calculateTotalPrice(ItemState state) {
    return state.sepetItems.fold(0.0, (total, item) {
      final count = state.counterValues[item.title] ?? 1;
      return total + (item.price ?? 0) * count;
    });
  }
}*/