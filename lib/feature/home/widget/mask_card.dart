import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/feature/home/cubit/item/item_cubit.dart';
import 'package:shopping_app/product/global/global_model/global_item_model.dart';

class MaskCard extends StatelessWidget {
  final GlobalItemModel item;
  final VoidCallback onLongPress;

  const MaskCard({super.key, required this.item, required this.onLongPress});
  

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      child: Card(
        elevation: 6,
        //color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 100.w,
                height: 100.h,
                child: Image.network(item.image.toString()),
              ),
              SizedBox(height: 20.h),
              Text(
                item.title ?? "Failed",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "\$${item.price.toString()}",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton.icon(
                    onPressed: (){
                      context.read<ItemCubit>().addItem(item);
                    },                  
                    icon: const Icon(Icons.shopping_cart), // Sepet ikonu
                    label: const Text("Buy"),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                      textStyle: TextStyle(fontSize: 10.sp),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
