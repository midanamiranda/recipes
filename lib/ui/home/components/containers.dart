import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:recipes/core/colors.dart';
import 'package:recipes/core/fonts.dart';
import 'package:recipes/services/models/recipes_result.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:recipes/core/extensions.dart';

Widget buildRecipeCard(Recipe recipe) {
  return Card(
    elevation: 1,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl: recipe.imageURL,
                      placeholder: (context, url) =>
                          Image.asset('assets/images/circles-menu-1.gif'),
                      errorWidget: (context, url, error) => new Icon(Icons.error),
                      fit: BoxFit.fill,
                      width: 400,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Ingredients",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: fontHeadLine,
                          fontSize: 18),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: buildIngredientsDetailsList(recipe.ingredients),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Steps",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: fontHeadLine,
                          fontSize: 18),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: buildStepsList(recipe.steps),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                if (null != recipe.originalURL && recipe.originalURL.isNotEmpty) Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.globe,
                          size: 14,
                          color: primaryIconColor,
                        ),
                        SizedBox(width: 2,),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Continue reading",
                                style: new TextStyle(color: primaryIconColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    final url = recipe.originalURL;
                                    await launch(
                                      url,
                                      forceSafariVC: true,
                                      forceWebView: true,
                                      enableJavaScript: true,
                                    );
                                  },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Colors.black54, Colors.transparent],
                ),
              ),
            ),
            Text(
              recipe.name,
              style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: fontHeadLine,
                  fontSize: 24),
            )
          ],
        ),
      ),
    ),
  );
}

Widget buildIngredientDetails(Ingredient ingredient) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "- ${ingredient.name.trim()}",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: fontHeadLine,
            fontSize: 12),
        textAlign: TextAlign.start,
      ),
      Row(
        children: [
          SizedBox(
            width: 8,
          ),
          Text(
            ingredient.type,
            style: TextStyle(
                fontFamily: fontHeadLine,
                fontSize: 10),
            textAlign: TextAlign.start,
          ),
          Text(
            " | ${ingredient.quantity}",
            style: TextStyle(
                fontFamily: fontHeadLine,
                fontSize: 10),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    ],
  );
}

List<Widget> buildIngredientsDetailsList(List<Ingredient> ingredientsList) {
  List<Widget> ingredientsWidgets = <Widget>[];

  ingredientsList.sortedBy((it) => it.type).forEach((ingredient) {
    ingredientsWidgets.add(buildIngredientDetails(ingredient));
  });

  return ingredientsWidgets;
}

List<Widget> buildStepsList(List<String> stepsList) {
  List<Widget> stepsWidgets = <Widget>[];

  stepsList.forEach((step) {
    stepsWidgets.add(
        Text(
          step,
          style: TextStyle(
              fontFamily: fontHeadLine,
              fontSize: 12),
          textAlign: TextAlign.start,
        )
    );
  });

  return stepsWidgets;
}