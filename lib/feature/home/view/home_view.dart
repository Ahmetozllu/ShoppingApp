import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shopping_app/feature/home/cubit/item/item_cubit.dart';
import 'package:shopping_app/feature/home/view/grid_view.dart';
import 'package:shopping_app/feature/home/widget/tabbar_widget.dart';
import 'package:shopping_app/product/global/global_model/global_item_model.dart';
import 'package:shopping_app/product/theme/cubit/theme_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.w),
              child: TabRow(
                size: 30.sp, 
                text: 'Our Products',
                onPressed: () {
                  _showBottomSheet(context);
                },
              ),
            ),
            TabBarCustom(tabController: _tabController),
            Expanded(
              child: BlocBuilder<ItemCubit, ItemState>(
                builder: (context, state) {
                  if (state.itemState == ItemStateNow.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.itemState == ItemStateNow.error) {
                    return Center(child: Text(state.errorMessage));
                  } else if (state.itemState == ItemStateNow.success) {
                    return TabBarView(
                      controller: _tabController,
                      children: List.generate(4, (index) {
                        return tabItem(state.item, index);
                      }),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showBottomSheet(BuildContext context) {
    return showModalBottomSheet(
     //backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (contextt) {
        return BlocProvider.value(
          value: context.read<ItemCubit>(),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 850.h,
                  child: Padding(
                    padding: EdgeInsets.all(8.0.w),
                    child: Column(
                      children: [
                        TabRowSize(size: 30.sp),
                        SizedBox(height: 30.h),
                        Expanded(
                          child: BlocBuilder<ItemCubit, ItemState>(
                            builder: (context, state) {
                              if (state.itemState == ItemStateNow.loading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              if (state.itemState == ItemStateNow.success &&
                                  state.item.isNotEmpty) {
                                return ListView.builder(
                                  itemCount: state.sepetItems.length,
                                  itemBuilder: (context, index) =>
                                      _buildItemCard(context, state, index),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                        SizedBox(height: 50.h),
                        Padding(
                          padding: EdgeInsets.all(20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total Price",
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold)),
                              BlocBuilder<ItemCubit, ItemState>(
                                builder: (context, state) {
                                  return Text(
                                    '\$${calculateTotalPrice(state).toStringAsFixed(2)}',
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        _buildBottomNavigation(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildItemCard(BuildContext context, ItemState state, int index) {
    final item = state.sepetItems[index];
    final count = state.counterValues[item.title] ?? 1;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 2,
      //color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(8.0.w), 
        child: Row(
          children: [
            SizedBox(
              width: 100.w,
              height: 100.h,
              child: Image.network(item.image.toString()),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "\$${item.price ?? 0}",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          context.read<ItemCubit>().addItem(item);
                        },
                        backgroundColor: Colors.red,
                        mini: true,
                        child: const Icon(
                          Icons.add,
                          color: Colors.white, 
                        ), 
                      ),
                      Text(
                        "$count",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          context.read<ItemCubit>().deleteItem(item);
                        },
                        backgroundColor: Colors.red,
                        mini: true,
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                        ), 
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(15)), // Kenarları yumuşat
      ),
      padding: EdgeInsets.symmetric(
          horizontal: 16.w, vertical: 12.h), // Duyarlı padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Home',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          FloatingActionButton(
            onPressed: () {
              context.pop();
            },
            backgroundColor: Colors.red,
            child: const Icon(Icons.arrow_downward, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class TabRow extends StatelessWidget {
  const TabRow(
      {super.key, required this.text, required this.size, this.onPressed});
  final VoidCallback? onPressed;
  final String text;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: size),
        ),
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.shopping_cart,
            size: size,
            //color: Colors.black,
          ),
        ),
        BlocBuilder<ThemeCubit, ThemaState>(
          builder: (context, state) {
            return Switch(value: state.isDark, onChanged: (value){
              context.read<ThemeCubit>().toggleTheme();
            });
          },
        )
      ],
    );
  }
}

class TabRowSize extends StatelessWidget {
  const TabRowSize({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30.w, right: 40.w, top: 50.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Shopping Card",
            style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: size),
          ),
        ],
      ),
    );
  }
}
