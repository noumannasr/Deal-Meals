import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_first_project/models/meals.dart';
import 'package:flutter_my_first_project/screens/First_screen.dart';
import 'package:flutter_my_first_project/screens/favorite_screen.dart';
import 'package:flutter_my_first_project/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {

  final List<Meal> favoriteMeals;
  TabsScreen(this.favoriteMeals);
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;

  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': FavoriteScreen(widget.favoriteMeals),
        'title': 'Favorites',
      },
    ];
    super.initState();
  }
  void _selectPage(int index) {
 setState(() {
   _selectedPageIndex = index;
 });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_pages[_selectedPageIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(backgroundColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.white,
      selectedItemColor: Theme.of(context).accentColor,
      currentIndex: _selectedPageIndex,
      onTap: _selectPage,
      items: [
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).primaryColor,
          icon: Icon(Icons.category),
          title: Text('Categories'),
      ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          title: Text('Favorites'),
    ),

    ],
      ),
    );
  }
}

