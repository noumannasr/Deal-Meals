import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_first_project/models/meals.dart';
import '../dummy_data.dart';
import '../widgets/meal_item.dart';
class CategoryMealsScreen extends StatefulWidget {
  static const routeName= '/category-meals';
  final List<Meal> avaliableMeals;
  CategoryMealsScreen(this.avaliableMeals);
  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  var _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if(!_loadedInitData){
      final routesArgs = ModalRoute.of(context).settings.arguments as Map<String,String>;
      categoryTitle = routesArgs['title'];
      final categoryId = routesArgs['id'];
      displayedMeals = widget.avaliableMeals.where((meals) {
        return meals.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    
    super.didChangeDependencies();
  }
  @override
  void initState() {

    super.initState();
  }

  void _removeMeal(String mealId)
  {
setState(() {
  displayedMeals.removeWhere((meal) => meal.id == mealId );
});
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(title:
      Text(
        categoryTitle,
      ),
      ),
      body: ListView.builder(itemBuilder: (ctx, index) {
        return MealItem(
          id: displayedMeals[index].id,
          title: displayedMeals[index].title,
          imageUrl: displayedMeals[index].imageUrl,
          duration: displayedMeals[index].duration,
          affordability: displayedMeals[index].affordability,
          complexity: displayedMeals[index].complexity,
        );
      },itemCount: displayedMeals.length ,),
    );
  }
}
