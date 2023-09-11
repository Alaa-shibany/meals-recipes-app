import 'package:flutter/material.dart';
import '../../models/category.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget(
      {super.key, required this.category, required this.onTap});

  final Category category;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.white,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 150,
        height: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.55),
              category.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          color: category.color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            category.title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ),
      ),
    );
  }
}
