import 'dart:convert';
import 'package:flutter/foundation.dart';

class ApiConfig {
  static const String defaultBaseUrl = 'https://test2342.vercel.app';

  static String get baseUrl {
    const envBaseUrl = String.fromEnvironment('API_BASE_URL');
    if (envBaseUrl.isNotEmpty) {
      return envBaseUrl;
    }

    if (kIsWeb) {
      return Uri.base.origin;
    }

    return defaultBaseUrl;
  }

  static const Duration requestTimeout = Duration(seconds: 20);

  static Uri uri(String path) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return Uri.parse(path);
    }

    final normalizedPath = path.startsWith('/') ? path : '/$path';
    return Uri.parse('$baseUrl$normalizedPath');
  }
}

class ApiResponseParser {
  static dynamic decode(String body) {
    if (body.trim().isEmpty) {
      return null;
    }

    return jsonDecode(body);
  }

  static List<dynamic> collectionItems(dynamic decoded) {
    if (decoded is List) {
      return decoded;
    }

    if (decoded is Map<String, dynamic>) {
      for (final key in <String>[
        'users',
        'data',
        'posts',
        'items',
        'results'
      ]) {
        final value = decoded[key];
        if (value is List) {
          return value;
        }
      }
    }

    return const <dynamic>[];
  }

  static List<Map<String, String>> heritageRecords(dynamic decoded) {
    return collectionItems(decoded)
        .whereType<Map>()
        .map((item) => _textMap(item))
        .toList();
  }

  static List<Map<String, String>> stateSection(
      dynamic decoded, String stateName) {
    final sources = <dynamic>[
      ...collectionItems(decoded),
      if (decoded is Map<String, dynamic>) decoded,
    ];

    for (final source in sources) {
      if (source is Map) {
        final stateData = source[stateName];
        if (stateData is List) {
          return stateData
              .whereType<Map>()
              .map((item) => _textMap(item))
              .toList();
        }
      }
    }

    return collectionItems(decoded)
        .whereType<Map>()
        .where((item) => item['state']?.toString().trim() == stateName)
        .map((item) => _textMap(item))
        .toList();
  }

  static Map<String, String> _textMap(Map item) {
    return <String, String>{
      'image': _stringValue(item, 'image'),
      'name': _stringValue(item, 'name', fallback: 'Unknown Name'),
      'state': _stringValue(item, 'state'),
      'description': _stringValue(
        item,
        'description',
        fallback: 'No description available',
      ),
    };
  }

  static String _stringValue(
    Map item,
    String key, {
    String fallback = '',
  }) {
    final value = item[key];
    if (value == null) {
      return fallback;
    }

    final text = value.toString().trim();
    return text.isEmpty ? fallback : text;
  }
}
