import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes/services/models/recipes_result.dart';
import 'package:recipes/ui/home/components/containers.dart';

class RecipesList extends StatelessWidget {
  final List<Recipe> recipes;

  RecipesList(this.recipes);

  @override
  Widget build(BuildContext context) {
    if (null == recipes || recipes.isEmpty) return
      Text('');
      else return
      ListView.builder(
        key: Key('your-recipe-list'),
        scrollDirection: Axis.vertical,
        itemCount: recipes.length,
        itemBuilder: (BuildContext ctx, index) {
          return buildRecipeCard(recipes[index], key: Key('recipe_$index'));
        }
    );
  }
}