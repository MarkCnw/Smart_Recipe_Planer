class AIAssistedRecipe {
  final String id;
  final String name;
  final String description;
  final List<String> ingredients;
  final List<String> instructions;
  final String nutritionalInfo;
  final String? imageUrl; // Optional image for the recipe card
  final List<String>? originalIdentifiedIngredients; // Ingredients identified by AI, used to generate this recipe
  final List<String>? originalAllergies; // Allergies considered when generating this recipe

  AIAssistedRecipe({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.instructions,
    required this.nutritionalInfo,
    this.imageUrl,
    this.originalIdentifiedIngredients,
    this.originalAllergies,
  });
}
