import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

//static data nhi h
class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  //intital data
  //super k andar list meal hoga
  FavoriteMealsNotifier()
      : super([]); // you must never edit that value always create new one

  //edit the data
  bool toggleMealFavoriteStatus(Meal meal) {
    //.add wagera nhi kr skte edit nhi hota
    // we need to replace it
    //state holds the data
    final mealIsFavorite = state.contains(meal);
    if (mealIsFavorite) {
      //to list se remove krna padega ...bt nhi kr skte
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } //agar dono id same nhi h to rakhenge warna hta denge
    else {
      // ... spread operator list
      state = [...state, meal]; //new meal //update ho gya bina address hua h
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier(); //isko nhi ptaa kaun sa data se deal kr rha
});
