import 'package:flutter/material.dart';
import 'package:meals_recipes/models/meal.dart';
import 'package:meals_recipes/widgets/meals_screen_widgets/meal_widget_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealWidget extends StatelessWidget {
  const MealWidget({super.key, required this.meal, required this.onSelect});

  final Meal meal;

  String get complexityName {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityName {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  final void Function(Meal meal) onSelect;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () => onSelect(meal),
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                color: Colors.black54,
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
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
                      children: [
                        MealWidgetTrait(
                          label: '${meal.duration} min',
                          icon: Icons.schedule,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        MealWidgetTrait(
                          label: complexityName,
                          icon: Icons.work,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        MealWidgetTrait(
                          label: affordabilityName,
                          icon: Icons.attach_money_sharp,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
