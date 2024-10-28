import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabBarCustom extends StatelessWidget {
  const TabBarCustom({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    List<String> tabTitles = [
      'Mens Clothing',
      'Jewelery',
      'Electronics',
      'Women Clothing',
    ];

    List<Widget> buildTabList() {
      return tabTitles.map((title) => Tab(text: title)).toList();
    }

    return Container(
      //decoration: BoxDecoration(color: Colors.grey.shade100),
      child: TabBar(
          labelStyle: TextStyle(fontSize: 20.w, fontWeight: FontWeight.bold),
          isScrollable: true,
          controller: _tabController,
          labelColor: Colors.red,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.red,
          tabs: buildTabList()),
    );
  }
}


