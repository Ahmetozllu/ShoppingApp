import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/feature/favorite/view/favorite_view.dart';
import 'package:shopping_app/feature/home/model/bottom_item.dart';
import 'package:shopping_app/feature/home/view/home_view.dart';
import 'package:shopping_app/feature/search/view/search_view.dart';

class BottomWidget extends StatefulWidget {
  const BottomWidget({super.key});

  @override
  State<BottomWidget> createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {
  int _currentIndex = 0;
  late final PageController _pageController;

  // Sayfa listesi
  final List<Widget> _pages = [
    const HomeView(),
    const SearchView(),
    const FavoriteView(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void bottomChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBody: true,
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        physics: const BouncingScrollPhysics(),
        pageSnapping: true,
        itemCount: _pages.length,
        itemBuilder: (context, index) => _pages[index],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: bottomChanged,
        //backgroundColor: Colors.grey.shade200,
        iconSize: 30.w,
        items: BottomItem.buildBottomList(bottomTitles),
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}




//enum BottomPage { home, search, favorites }

/*extension BottomPageExtension on BottomPage {
  void navigate(BuildContext context) {
    switch (this) {
      case BottomPage.home:
        context.push('/store'); // Store sayfasına yönlendirin
        break;
      case BottomPage.search:
        context.push('/search'); // Search sayfasına yönlendirin
        break;
      case BottomPage.favorites:
        context.push('/favorites'); // Favorites sayfasına yönlendirin
        break;
    }
  }
}*/

























































/*import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shopping_app/feature/home/model/bottom_item.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.grey.shade200,
      iconSize: 30.w,
      items: BottomItem.buildBottomList(bottomTitles),
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
    );
  }
}

enum BottomPage { home, search, favorites }

extension BottomPageExtension on BottomPage {
  void navigate(BuildContext context) {
    switch (this) {
      case BottomPage.home:
        context.push('/store'); // Store sayfasına yönlendirin
        break;
      case BottomPage.search:
        context.push('/search'); // Search sayfasına yönlendirin
        break;
      case BottomPage.favorites:
        context.push('/favorites'); // Favorites sayfasına yönlendirin
        break;
    }
  }
}
*/