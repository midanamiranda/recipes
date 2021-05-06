class RecipesResult {
  List<Recipe> _recipes;

  List<Recipe> get recipes => _recipes;

  RecipesResult({
      List<Recipe> recipes}){
    _recipes = recipes;
}

  RecipesResult.fromJson(dynamic json) {
    if (json["recipes"] != null) {
      _recipes = [];
      json["recipes"].forEach((v) {
        _recipes?.add(Recipe.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_recipes != null) {
      map["recipes"] = _recipes?.map((v) => v.toJson())?.toList();
    }
    return map;
  }

}

/// name : "Crock Pot Roast"
/// ingredients : [{"quantity":"1","name":" beef roast","type":"Meat"},{"quantity":"1 package","name":"brown gravy mix","type":"Baking"},{"quantity":"1 package","name":"dried Italian salad dressing mix","type":"Condiments"},{"quantity":"1 package","name":"dry ranch dressing mix","type":"Condiments"},{"quantity":"1/2 cup","name":"water","type":"Drinks"}]
/// steps : ["Place beef roast in crock pot.","Mix the dried mixes together in a bowl and sprinkle over the roast.","Pour the water around the roast.","Cook on low for 7-9 hours."]
/// timers : [0,0,0,420]
/// imageURL : "https://img.sndimg.com/food/image/upload/w_266/v1/img/recipes/27/20/8/picVfzLZo.jpg"
/// originalURL : "http://www.food.com/recipe/to-die-for-crock-pot-roast-27208"

class Recipe {
  String _name;
  List<Ingredient> _ingredients;
  List<String> _steps;
  List<int> _timers;
  String _imageURL;
  String _originalURL;

  String get name => _name;
  List<Ingredient> get ingredients => _ingredients;
  List<String> get steps => _steps;
  List<int> get timers => _timers;
  String get imageURL => _imageURL;
  String get originalURL => _originalURL;

  Recipe({
      String name,
      List<Ingredient> ingredients,
      List<String> steps,
      List<int> timers,
      String imageURL,
      String originalURL}){
    _name = name;
    _ingredients = ingredients;
    _steps = steps;
    _timers = timers;
    _imageURL = imageURL;
    _originalURL = originalURL;
}

  Recipe.fromJson(dynamic json) {
    _name = json["name"];
    if (json["ingredients"] != null) {
      _ingredients = [];
      json["ingredients"].forEach((v) {
        _ingredients?.add(Ingredient.fromJson(v));
      });
    }
    _steps = json["steps"] != null ? json["steps"].cast<String>() : [];
    _timers = json["timers"] != null ? json["timers"].cast<int>() : [];
    _imageURL = json["imageURL"];
    _originalURL = json["originalURL"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    if (_ingredients != null) {
      map["ingredients"] = _ingredients?.map((v) => v.toJson())?.toList();
    }
    map["steps"] = _steps;
    map["timers"] = _timers;
    map["imageURL"] = _imageURL;
    map["originalURL"] = _originalURL;
    return map;
  }

}

/// quantity : "1"
/// name : " beef roast"
/// type : "Meat"

class Ingredient {
  String _quantity;
  String _name;
  String _type;

  String get quantity => _quantity;
  String get name => _name;
  String get type => _type;

  Ingredient({
      String quantity,
      String name,
      String type}){
    _quantity = quantity;
    _name = name;
    _type = type;
}

  Ingredient.fromJson(dynamic json) {
    _quantity = json["quantity"];
    _name = json["name"];
    _type = json["type"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["quantity"] = _quantity;
    map["name"] = _name;
    map["type"] = _type;
    return map;
  }

}