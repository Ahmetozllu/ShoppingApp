import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_app/product/global/global_model/global_item_model.dart';
import 'package:shopping_app/product/global/service/IItemservice.dart';
import 'package:shopping_app/product/global/service/item_service.dart';

part 'item_state.dart';

class ItemCubit extends Cubit<ItemState> {
  
  ItemCubit() : super(ItemState.initial()) {
    init();
  }



  final IItemService _fetch = ItemService.instance;

  init() async {
    await getItem();
  }

  Future<void> getItem() async {
    try {
      emit(state.copyWith(itemState: ItemStateNow.loading, errorMessage: ''));

      final List<GlobalItemModel>? items = await _fetch.getItems();

      if (items != null) {
        emit(state.copyWith(item: items,filteredItems: items, itemState: ItemStateNow.success));

      } else {
        emit(state.copyWith(
            itemState: ItemStateNow.initial,
            errorMessage: 'İstenilen data boş geldi'));
      }
    } catch (e) {
      emit(state.copyWith(
          itemState: ItemStateNow.error, errorMessage: e.toString()));
    }
  }

void addItem(GlobalItemModel item) {
  var currentItems = List<GlobalItemModel>.from(state.sepetItems);
  var currentCounters = Map<String, int>.from(state.counterValues);

  final existingItemIndex = currentItems.indexWhere((existingItem) => existingItem.id == item.id);

  if (existingItemIndex != -1) {
    currentCounters[item.title!] = (currentCounters[item.title!] ?? 0) + 1;
  } else {
    // Eğer öğe sepette yoksa, yeni öğeyi ekle ve counterValue'yu 1 olarak başlat
    currentItems.add(item);
    currentCounters[item.title!] = 1;
  }

  emit(state.copyWith(
    sepetItems: currentItems,
    counterValues: currentCounters,
    itemState: ItemStateNow.success,
  ));
}



void deleteItem(GlobalItemModel item) {
  var currentItems = List<GlobalItemModel>.from(state.sepetItems);
  var currentCounters = Map<String, int>.from(state.counterValues);

  final existingItemIndex = currentItems.indexWhere((existingItem) => existingItem.id == item.id);

  if (existingItemIndex != -1) {
    final currentCount = currentCounters[item.title!] ?? 0;
    
    if (currentCount > 1) {
      currentCounters[item.title!] = currentCount - 1;
    } else {
      currentItems.removeAt(existingItemIndex);
      currentCounters.remove(item.title);
    }
  }

  emit(state.copyWith(
    sepetItems: currentItems,
    counterValues: currentCounters,
    itemState: ItemStateNow.success,
  ));
}

void searchItems(String query) {
  if (query.isNotEmpty) {
    emit(state.copyWith(itemState: ItemStateNow.loading)); 

    final filteredList = state.item.where((item) {
      return item.title!.toLowerCase().contains(query.toLowerCase()) ||
             item.description!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    emit(state.copyWith(
      filteredItems: filteredList,
      itemState: ItemStateNow.success, 
    ));

  } else {
    emit(state.copyWith(itemState: ItemStateNow.loading));

    emit(state.copyWith(
      filteredItems: state.item, 
      itemState: ItemStateNow.success, 
    ));
  }
}

}



