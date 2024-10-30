import 'filter_text.dart';

void main() {
  FilterText filterText = FilterText();

  // Example 1: Using default settings
  String result1 = filterText.transform("This is a test with adult and politics.");
  print(result1); // Filters out sensitive words based on defaults

  // Example 2: Using user-provided sensitive words
  String result2 = filterText.transform("This is a test with drugs and spam. 💔",
      filterTypes: [ FilterType.drugs, FilterType.spam, FilterType.longWords],
      userProvidedSensitiveWords: ['test'],
      filterType: FilterType.emojis,
      useUserProvidedOnly: false,
  );
  print(result2); // Filters out "test" only, retains default behavior for drugs and spam

  // Example 3: Transforming case
  String result3 = filterText.transform("This is a test string.",
      transformationType: TransformationType.uppercase);
  print(result3); // Outputs: THIS IS A TEST STRING.
}
