import 'package:flutter/material.dart';
import '../models/food_item.dart';

class MealItem extends StatelessWidget {
  final FoodItem meal;

  const MealItem({
    super.key,
    required this.meal,
  });

  String get complexityText {
    switch (meal.complexity) {
      case Complexity.simple:
        return 'Simple';
      case Complexity.challenging:
        return 'Challenging';
      case Complexity.hard:
        return 'Hard';
    }
  }

  String get affordabilityText {
    switch (meal.affordability) {
      case Affordability.affordable:
        return 'Affordable';
      case Affordability.pricey:
        return 'Pricey';
      case Affordability.luxurious:
        return 'Expensive';
    }
  }

  void selectMeal(BuildContext context) {
    Navigator.of(context).pushNamed(
      '/meal-detail',
      arguments: meal.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  child: Image.network(
                    meal.imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 250,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported, size: 50),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          meal.title,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.schedule,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '${meal.duration} min',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Row(
                              children: [
                                const Icon(Icons.work, color: Colors.white),
                                const SizedBox(width: 6),
                                Text(
                                  complexityText,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.attach_money,
                                    color: Colors.white),
                                Text(
                                  affordabilityText,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
