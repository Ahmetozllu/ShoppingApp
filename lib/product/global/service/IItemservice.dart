import 'package:shopping_app/product/global/global_model/global_item_model.dart';

abstract class IItemService {
  Future<List<GlobalItemModel>?> getItems();
}
