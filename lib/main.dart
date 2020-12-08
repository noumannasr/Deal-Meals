import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_first_project/dummy_data.dart';
import 'package:flutter_my_first_project/models/meals.dart';
import 'package:flutter_my_first_project/screens/category_meals_screen.dart';
import 'package:flutter_my_first_project/screens/filters_screen.dart';
import 'package:flutter_my_first_project/screens/meals_detail_screen.dart';
import 'package:flutter_my_first_project/screens/tab_screen.dart';
import 'screens/First_screen.dart';
import 'screens/category_meals_screen.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,

  };
List<Meal> _avaliableMeals = DUMMY_MEALS;
List<Meal> _favoriteMeals = [];
  void _setFilters(Map<String, bool> filterData){
    setState(() {
      _filters = filterData;
      _avaliableMeals = DUMMY_MEALS.where((meal)
      {
        if(_filters['gluten'] && !meal.isGlutenFree)
        {
            return false;
        }
        if(_filters['lactose'] && !meal.isLactoseFree)
        {
          return false;
        }
        if(_filters['vegetarian'] && !meal.isVegetarian)
        {
          return false;
        }
        if(_filters['vegan'] && !meal.isVegan)
        {
          return false;
        }
  return true;
      }
      ).
      toList();
    });
  }

  void _toggleFavorite(String mealId){
    final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if(existingIndex >= 0){
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    }
    else{
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }
  bool isMealFavorite(String id){
    return _favoriteMeals.any((meal) => meal.id == id);
  }

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'DeliMeals',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Relway',
          textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              )),
        ),
        initialRoute: '/',
        //home: CategoriesScreen(),
        routes: {
          '/': (ctx)  => TabsScreen(_favoriteMeals),
          CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(_avaliableMeals),
          MealsDetailScreen.routeName: (ctx) => MealsDetailScreen(_toggleFavorite, isMealFavorite),
          FilterScreen.routeName: (ctx) => FilterScreen(_filters ,_setFilters),
        },
        onGenerateRoute: (settings) {
          print(settings.arguments);
          return MaterialPageRoute(builder: (ctx) => CategoriesScreen(), );
        },
        onUnknownRoute: (settings){
          return MaterialPageRoute(builder: (ctx) => CategoriesScreen(), );
        },
      );
  }
}


