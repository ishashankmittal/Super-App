class RecipeModel{
  String? label;
  String? image;
  String? url;
  String? source;

  RecipeModel({required this.label,required this.image,required this.url,required this.source});

  factory RecipeModel.fromMap(Map<String,dynamic> parsedJson){
    return RecipeModel(label: parsedJson["label"], image: parsedJson["image"], url: parsedJson["url"], source: parsedJson["source"]);
  }
}