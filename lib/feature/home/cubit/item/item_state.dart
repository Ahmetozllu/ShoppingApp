// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'item_cubit.dart';

class ItemState extends Equatable {
  final List<GlobalItemModel> item;
  final String errorMessage;
  final String message;
  final ItemStateNow itemState;
  final bool isActive; // isActive boolean olarak değiştirildi
  final List<GlobalItemModel> filteredItems;
  final List<GlobalItemModel> sepetItems;
  final Map<String, int> counterValues;

  const ItemState({
    required this.isActive,
    required this.counterValues,
    required this.sepetItems,
    required this.item,
    required this.errorMessage,
    required this.message,
    required this.itemState,
    required this.filteredItems,
  });

  ItemState copyWith({
    List<GlobalItemModel>? sepetItems,
    List<GlobalItemModel>? item,
    String? errorMessage,
    String? message,
    ItemStateNow? itemState,
    List<GlobalItemModel>? filteredItems,
    bool? isActive, // isActive için parametre eklendi
    Map<String,int>? counterValues, // counterValue için parametre eklendi
  }) {
    return ItemState(
      isActive: isActive ?? this.isActive, // isActive güncellendi
      counterValues: counterValues ?? this.counterValues, // counterValue güncellendi
      sepetItems: sepetItems ?? this.sepetItems,
      item: item ?? this.item,
      errorMessage: errorMessage ?? this.errorMessage,
      message: message ?? this.message,
      itemState: itemState ?? this.itemState,
      filteredItems: filteredItems ?? this.filteredItems,
    );
  }

  factory ItemState.initial() {
    return  const ItemState(
      sepetItems: [],
      item: [],
      errorMessage: "",
      message: "",
      itemState: ItemStateNow.initial,
      filteredItems: [],
      isActive: false,
      counterValues: <String,int>{}, 
    );
  }

  @override
  List<Object?> get props => [
        item,
        errorMessage,
        message,
        itemState,
        counterValues, // props listesine counterValue eklendi
        isActive, // props listesine isActive eklendi
      ];
}

enum ItemStateNow { initial, loading, success, error }



/*import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final LoginStates loginState;
  final String errorMessage;
  final String message;

  const LoginState({ 
    required this.loginState,
    required this.errorMessage,
    required this.message,
  });
  factory LoginState.initial() {
    return const LoginState(
      loginState: LoginStates.initial,
      errorMessage: '',
      message: '',
    );
  }
 

  @override
  List<Object?> get props => [LoginStates, errorMessage, message];

  LoginState copyWith({
    LoginStates? loginState,
    String? errorMessage,
    String? message,
  }) {
    return LoginState(
      loginState: loginState ?? this.loginState,
      errorMessage: errorMessage ?? this.errorMessage,
      message: message ?? this.message,
    );
  }
}

enum LoginStates {
  initial,
  loading,
  completed,
  error,
}
*/