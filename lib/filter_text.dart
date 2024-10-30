library filter_text;

class FilterText {

  // Default lists of sensitive words for different categories
  static const List<String> _adultSensitiveWords = [
    'sex',
    'porn',
    'nude',
    'xxx',
    'adult',
    'prostitute',
    // Add more adult sensitive words
  ];

  static const List<String> _politicalSensitiveWords = [
    'corruption',
    'dictator',
    'impeachment',
    'politics',
    // Add more political sensitive words
  ];

  static const List<String> _profanitySensitiveWords = [
    'damn',
    'hell',
    'crap',
    // Add more profanity sensitive words
  ];

  static const List<String> _hateSpeechSensitiveWords = [
    'bigot',
    'racist',
    // Add more hate speech sensitive words
  ];

  static const List<String> _violenceSensitiveWords = [
    'kill',
    'murder',
    'attack',
    // Add more violent sensitive words
  ];

  static const List<String> _drugsSensitiveWords = [
    'drugs',
    'cocaine',
    'heroin',
    'marijuana',
    'weed',
    // Add more drugs sensitive words
  ];

  static const List<String> _spamSensitiveWords = [
    'free',
    'win',
    'click here',
    'spam',
    // Add more spam sensitive words
  ];

  static const List<String> _personalInfoSensitiveWords = [
    'name', // Placeholder for personal information
    'address',
    'phone',
    'email',
    // Add more personal info sensitive words
  ];

  static const List<String> _racialSlursSensitiveWords = [
    'slur1', // Example placeholder for racial slurs
    'slur2',
    // Add more racial slurs
  ];

  static const List<String> _articleSensitiveWords = [
    'a',
    'an',
    'the',
    // Add more articles if necessary
  ];

  static const List<String> _nounSensitiveWords = [
    'example', // Add example nouns
    // Add more nouns
  ];

  static const List<String> _pronounSensitiveWords = [
    'he',
    'she',
    'they',
    'it',
    // Add more pronouns
  ];

  static const List<String> _longWordSensitiveWords = [
    'extraordinary',
    'unbelievable',
    // Add more long words
  ];

  static const List<String> _shortWordSensitiveWords = [
    'a',
    'I',
    // Add more short words
  ];

  /// Emojis are generally outside the ASCII range (0-127).
  static const int _asciiUpperLimit = 127;

  static const List<String> _unsupportedTextSensitiveWords = [
    'unsupported', // Placeholder for unsupported text
    // Add more unsupported text
  ];

  /// Transforms the input text based on the specified transformation type.
  ///
  /// [input] is the original text to be transformed.
  /// [transformationType] specifies the type of transformation to apply (optional).
  /// [filterTypes] specifies the categories of sensitive words to filter (optional).
  /// [filterType] specifies a single category of sensitive words to filter (optional).
  /// [userProvidedSensitiveWords] specifies a custom list of sensitive words (optional).
  /// [replacement] specifies the string to replace sensitive words with (optional).
  /// [useUserProvidedOnly] specifies whether to use only user-provided sensitive words (optional).
  String filter(
      String input, {
        TransformationType? transformationType,
        List<FilterType>? filterTypes, // Allow multiple filter types
        FilterType? filterType, // Allow single filter type
        List<String>? userProvidedSensitiveWords, // Allow user-defined sensitive words
        String? replacement, // Allow null as a replacement option
        bool? useUserProvidedOnly, // Optional parameter to use user-provided words only
      }) {
    // If filter types are specified, filter the sensitive words
    if (filterTypes != null && filterTypes.isNotEmpty) {
      for (var filterType in filterTypes) {
        input = _filterSensitiveWords(input, filterType, replacement, userProvidedSensitiveWords, useUserProvidedOnly);
      }
    }

    // If a single filter type is specified, filter the sensitive words
    if (filterType != null) {
      input = _filterSensitiveWords(input, filterType, replacement, userProvidedSensitiveWords, useUserProvidedOnly);
    }

    // If no transformation type is specified, return the modified input
    if (transformationType == null) {
      return input;
    }

    switch (transformationType) {
      case TransformationType.uppercase:
        return input.toUpperCase();
      case TransformationType.lowercase:
        return input.toLowerCase();
      case TransformationType.camelCase:
        return _toCamelCase(input);
      case TransformationType.snakeCase:
        return _toSnakeCase(input);
      default:
        return input; // Return original input if no valid transformation is specified
    }
  }

  String _filterSensitiveWords(
      String input,
      FilterType filterType,
      String? replacement,
      List<String>? userProvidedSensitiveWords,
      bool? useUserProvidedOnly,
      ) {
    List<String> sensitiveWords;

    // Determine which sensitive words list to use based on the filter type
    switch (filterType) {
      case FilterType.adult:
        sensitiveWords = _adultSensitiveWords;
        break;
      case FilterType.politics:
        sensitiveWords = _politicalSensitiveWords;
        break;
      case FilterType.profanity:
        sensitiveWords = _profanitySensitiveWords;
        break;
      case FilterType.hateSpeech:
        sensitiveWords = _hateSpeechSensitiveWords;
        break;
      case FilterType.violence:
        sensitiveWords = _violenceSensitiveWords;
        break;
      case FilterType.drugs:
        sensitiveWords = _drugsSensitiveWords;
        break;
      case FilterType.spam:
        sensitiveWords = _spamSensitiveWords;
        break;
      case FilterType.personalInfo:
        sensitiveWords = _personalInfoSensitiveWords;
        break;
      case FilterType.racialSlurs:
        sensitiveWords = _racialSlursSensitiveWords;
        break;
      case FilterType.articles:
        sensitiveWords = _articleSensitiveWords;
        break;
      case FilterType.nouns:
        sensitiveWords = _nounSensitiveWords;
        break;
      case FilterType.pronouns:
        sensitiveWords = _pronounSensitiveWords;
        break;
      case FilterType.longWords:
        sensitiveWords = _longWordSensitiveWords;
        break;
      case FilterType.shortWords:
        sensitiveWords = _shortWordSensitiveWords;
        break;
      case FilterType.emojis:
        return _filterEmojis(input);
      case FilterType.unsupportedText:
        sensitiveWords = _unsupportedTextSensitiveWords;
        break;
      default:
        return input; // Return original input if no valid filter type is specified
    }

    // Include user-provided sensitive words if specified
    if (userProvidedSensitiveWords != null) {
      sensitiveWords = [...sensitiveWords, ...userProvidedSensitiveWords];
    }

    // Replace or remove sensitive words based on the replacement parameter
    for (String word in sensitiveWords) {
      if (useUserProvidedOnly == true && replacement != null && replacement.isNotEmpty) {
        // Replace the word with the specified replacement string
        input = input.replaceAll(RegExp(word, caseSensitive: false), replacement * word.length);
      } else if (replacement == null || replacement.isEmpty) {
        // Remove the word if replacement is null or empty
        input = input.replaceAll(RegExp(word, caseSensitive: false), '');
      } else {
        // Replace the word with the specified replacement string
        input = input.replaceAll(RegExp(word, caseSensitive: false), replacement * word.length);
      }
    }
    return input;
  }

  String _filterEmojis(String input) {
    // Remove characters with ASCII values greater than 127 (which typically includes emojis)
    return input.split('').where((char) => char.codeUnitAt(0) <= _asciiUpperLimit).join();
  }

  String _toCamelCase(String input) {
    return input
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join();
  }

  String _toSnakeCase(String input) {
    return input
        .split(' ')
        .map((word) => word.toLowerCase())
        .join('_');
  }
}

/// Enum to define transformation types
enum TransformationType {
  uppercase,
  lowercase,
  camelCase,
  snakeCase,
}

/// Enum to define filter types
enum FilterType {
  adult,         // Filters all explicit or adult-themed content
  politics,      // Filters political content
  profanity,     // Filters profanity
  hateSpeech,    // Filters hate speech
  violence,      // Filters violent content
  drugs,         // Filters references to drugs
  spam,          // Filters spam content
  personalInfo,  // Filters personal information
  racialSlurs,   // Filters racial slurs
  articles,      // Filters articles
  nouns,         // Filters nouns
  pronouns,      // Filters pronouns
  longWords,     // Filters long words
  shortWords,    // Filters short words
  emojis,        // Filters emojis
  unsupportedText // Filters unsupported text
}
