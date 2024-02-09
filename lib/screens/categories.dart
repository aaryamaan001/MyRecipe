import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/categories_grid_item.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen(
      {super.key,
      //required this.onToggleFavorite,
      required this.availableMeals});
  //final void Function(Meal meal) onToggleFavorite;

  // ye filter meals ke liye variable h
  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this, //60 fps smooth
      duration: const Duration(milliseconds: 300),
      //lowerBound: 0,
      //upperBound: 1,
    );

    _animationController.forward(); //repeat bhi hota
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    //Navigator.push(context, route)
    final filteredMeals = widget
        .availableMeals // pehle dummy meals se data le rhe the bt ab selected meals se hi le rhe h
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          //onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ye functioin builder wala 60 baar chlega fps
    return AnimatedBuilder(
        animation: _animationController,
        child: GridView(
          padding: const EdgeInsets.all(24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: [
            //map bhi use kr skte h
            for (final category in availableCategories)
              CategoryGridItem(
                category: category,
                onSelectCategory: () {
                  _selectCategory(context, category);
                },
              )
          ],
        ),
        builder: (context, child) => SlideTransition(
              position: Tween(
                begin: const Offset(0, 0.3), //30 percent down
                end: const Offset(0, 0), //normal position
              ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)),
              child: child,
            ),
        // Padding(
        //       padding: EdgeInsets.only(
        //         top: 100- _animationController.value * 100,
        //       ),
        //       child: child,
        //     )

        );
  }
}
