class RecipeModel {
  String? label;
  String? image;
  String? url;
  String? source;
  List<String>? dietLabels; // Add dietLabels property

  RecipeModel({
    required this.label,
    required this.image,
    required this.url,
    required this.source,
    this.dietLabels, // Initialize dietLabels as an optional parameter
  });

  factory RecipeModel.fromMap(Map<String, dynamic> parsedJson) {
    // Extract dietLabels from parsedJson
    final List<dynamic>? dietLabelsList = parsedJson["dietLabels"];
    final List<String>? dietLabels =
    dietLabelsList?.map((label) => label.toString()).toList();

    return RecipeModel(
      label: parsedJson["label"],
      image: parsedJson["image"],
      url: parsedJson["url"],
      source: parsedJson["source"],
      dietLabels: dietLabels, // Assign dietLabels to the model
    );
  }
}
