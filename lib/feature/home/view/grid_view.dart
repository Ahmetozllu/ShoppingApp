import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shopping_app/feature/home/widget/mask_card.dart';
import 'package:shopping_app/product/global/global_model/global_item_model.dart';

class MaskGridView extends StatelessWidget {
  final List<GlobalItemModel> items;
  const MaskGridView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
       padding: EdgeInsets.all(20.w), 
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.70,
        crossAxisCount: 2,
        crossAxisSpacing: 20.w,
        mainAxisSpacing: 30.h,
      ),
      itemCount: items.length, 
     itemBuilder: (context, index) {
       return MaskCard(
          item: items[index],
          onLongPress: () => showItemDetails(context, items[index]),
        );
      },
    );
  }

  void  showItemDetails(BuildContext context, GlobalItemModel item) {
     showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  title: Text(item.title ?? "No Title"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min, // AlertDialog boyutunu içeriğe göre ayarlar.
                    children: [
                      SizedBox(
                        width: 100.w,
                        height: 100.h,
                        child: Image.network(item.image.toString()),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        item.description ?? "No Description",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text('Close'),
                    ),
                  ],
                );
              },
            );
  }
}



