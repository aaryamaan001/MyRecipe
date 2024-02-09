import 'package:flutter/material.dart';
// import 'package:meals/data/dummy_data.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favorites_provider.dart';

//import filter provider enum delted
import 'package:meals/providers/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

// stateless --- consumerwidget
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  //state -- consumer state
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  //final List<Meal> _favoriteMeals = [];

  //if meal is part of the favoorite list -->remove it otherwise add it
  // void _toggleMealFavoriteStatus(Meal meal) {
  //   final isExisting = _favoriteMeals.contains(meal);

  //start ko update krne ke liye sb widget me update krna padega

  //set state call nhi krenge to changes reflext nhi honge
  //   if (isExisting) {
  //     setState(() {
  //       _favoriteMeals.remove(meal);
  //     });
  //     _showInfoMessage('Meal is no longer a favorite.');
  //   } else {
  //     setState(() {
  //       _favoriteMeals.add(meal);
  //     });
  //     _showInfoMessage('Marked as a favorite');
  //   }
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  // yha return type future ho gya coz filterScreen se return aa gyaa ASYNC likhna padega
  void _setScreen(String identifier) async {
    //side drawer band nhi ho rha tha not good
    Navigator.of(context).pop();
    //band kr diya
    if (identifier == 'filters') {
      // yha pe humlog screen push kr rhe h to dikkat ye h ki
      //back button dbayenge jb tb poora screen doboara aayega coz push hua tha
      // push ke jagah replace krna h screen

      //wait krega jb tk result nhi aa jaata
      //<> to define generic type map return kr rhaa

      await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(
        builder: (ctx) => FiltersScreen(),
      ));

      //RESULT se sirf categories cahnge krna h favorite waise ka waise hi rakhna h
      // isliye bs categories me use krenge values

      // filter screen yha call ho rha h to data yhi pe return aayega
    }
    //  else {
    //   //we are already in the meals area of the app already
    //   // to bs pop krna h
    //   Navigator.of(context).pop();
    // }
  }

  @override
  Widget build(BuildContext context) {
    //final meals = ref.watch(mealsProvider); //try to use it bugs kam aata h
    //final activeFilters = ref.watch(filtersProvider);
    //ye ab filtered meals ko access krne ka tareeka h
    final availableMeals = ref
        .watch(filteredMealsProvider); //pass this.list to the category screen

    //issue is ki agar ab dobara filter me jaa rhe h to data delete ho ja rha h
    //changes to filter screen me bhi save krna h
    Widget activePage = CategoriesScreen(
      // onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
        //onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
