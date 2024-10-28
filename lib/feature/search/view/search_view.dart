import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/feature/home/cubit/item/item_cubit.dart';
import 'package:shopping_app/feature/home/view/grid_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
   // bunu sor 
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemCubit, ItemState>(
      builder: (context, state) {
        if (state.itemState == ItemStateNow.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.itemState == ItemStateNow.success) {
          return Scaffold(
            //extendBody: true,
            appBar: AppBar(
              //backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(56.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SearchTextField(searchController: _searchController),
                ),
              ),
            ),
            body: state.filteredItems.isEmpty
                ? const Center(child: Text("No results found"))
                : MaskGridView(items: state.filteredItems)         
          );
        } else if (state.itemState == ItemStateNow.error) {
          return Center(child: Text("An error occurred: ${state.errorMessage}"));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController ,
      onChanged: (String query) {
        context.read<ItemCubit>().searchItems(query);
      },
      decoration: InputDecoration(
        hintText: "Search for products...",
        border: OutlineInputBorder(
          borderSide:  BorderSide(color: Colors.red, width: 10.w),
          borderRadius: BorderRadius.circular(20.0),
        ),
              focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(color: Colors.black),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(color: Colors.red), 
      ),
      ),
    );
  }
}
