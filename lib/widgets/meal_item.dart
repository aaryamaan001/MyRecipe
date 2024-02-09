import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectMeal});

  final Meal meal;

  // meals item me click krne se meals detail screen open ho
  final void Function(Meal meal) onSelectMeal;

  //final void Function(BuildContext context,Meal meal) onSelectMeal;

  // enum h isliye getter use krke krna pad rha h
  String get complexityText {
    //to make the first character capital krne k liye
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  String get affordabilityText {
    //to make the first character capital krne k liye
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip
          .hardEdge, //stack margin aur shape apply krega....to ye apne aap hta dega and implement krega
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelectMeal(meal);
          //onSelectMeal(context, meal); //
        },
        child: Stack(
          children: [
            //sbse peeche wala widget//smooth
            Hero(//wrap widget that is to be animated give it a tag
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(
                    kTransparentImage), //aise hi placeholder screen de diya h,
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover, //image box me fit nhi hoga to kat jaayega
                height: 200,
                width: double.infinity, //horizonral full space cover krega
              ),
            ), //internet se

            // Name of meal and mata info...
            Positioned(
              //kha pe place krenge
              bottom: 0,
              left: 0, //start
              right: 0, //end x pixel before

              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(
                  horizontal: 44,
                  vertical: 6,
                ),
                // title and matadata show krne ke liye
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true, //to wrap to text if needed
                      overflow: TextOverflow.ellipsis,

                      ///very long text h to ... krke khtm krega
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                            icon: Icons.schedule,
                            label: meal.duration.toString()),
                        const SizedBox(
                          width: 12,
                        ),
                        MealItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        MealItemTrait(
                            icon: Icons.attach_money, label: affordabilityText),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
