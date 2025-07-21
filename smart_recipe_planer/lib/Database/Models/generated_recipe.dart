class GeneratedRecipe {
  final String id;
  final String inputId;
  final String recipeName;
  final String aiGeneratedImageUrl;
  final List<String> ingredients;
  final List<String> instructions;
  final DateTime createdDate;

  GeneratedRecipe({
    required this.id,
    required this.inputId,
    required this.recipeName,
    required this.aiGeneratedImageUrl,
    required this.ingredients,
    required this.instructions,
    required this.createdDate,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'inputId': inputId,
      'recipeName': recipeName,
      'aiGeneratedImageUrl': aiGeneratedImageUrl,
      'ingredients': ingredients,
      'instructions': instructions,
      'createdDate': createdDate.toIso8601String(),
    };
  }

  factory GeneratedRecipe.fromFirestore(Map<String, dynamic> data, String docId) {
    return GeneratedRecipe(
      id: docId,
      inputId: data['inputId'] ?? '',
      recipeName: data['recipeName'] ?? '',
      aiGeneratedImageUrl: data['aiGeneratedImageUrl'] ?? '',
      ingredients: List<String>.from(data['ingredients'] ?? []),
      instructions: List<String>.from(data['instructions'] ?? []),
      createdDate: DateTime.parse(data['createdDate']),
    );
  }
}