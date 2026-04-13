import 'dart:convert';
import 'package:flutter/foundation.dart';

class ApiConfig {
  static const String defaultBaseUrl = 'https://sanskriti-yatra.vercel.app';

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

  static String messageFromBody(
    String body, {
    String fallback = 'Error',
  }) {
    try {
      final decoded = decode(body);
      if (decoded is Map<String, dynamic>) {
        final message = decoded['message']?.toString().trim();
        if (message != null && message.isNotEmpty) {
          return message;
        }

        final error = decoded['error']?.toString().trim();
        if (error != null && error.isNotEmpty) {
          return error;
        }
      }
    } catch (_) {}

    return fallback;
  }

  static Map<String, String> _textMap(Map item) {
    return <String, String>{
      'image': _imageValue(item),
      'name': _stringValue(item, 'name', fallback: 'Unknown Name'),
      'state': _stringValue(item, 'state'),
      'category': _stringValue(item, 'category', fallback: 'Culture'),
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

  static String _imageValue(Map item) {
    for (final key in <String>[
      'image',
      'imageUrl',
      'image_url',
      'photo',
      'thumbnail',
      'thumb',
      'url',
    ]) {
      final value = item[key];
      final text = value?.toString().trim() ?? '';
      if (text.isNotEmpty) {
        return text;
      }
    }

    final images = item['images'];
    if (images is List && images.isNotEmpty) {
      final first = images.first;
      if (first is String && first.trim().isNotEmpty) {
        return first.trim();
      }
      if (first is Map) {
        for (final key in <String>[
          'url',
          'image',
          'src',
          'large2x',
          'large',
          'medium'
        ]) {
          final value = first[key];
          if (value is String && value.trim().isNotEmpty) {
            return value.trim();
          }
          if (value is Map) {
            for (final nestedKey in <String>[
              'original',
              'large2x',
              'large',
              'medium'
            ]) {
              final nested = value[nestedKey];
              if (nested is String && nested.trim().isNotEmpty) {
                return nested.trim();
              }
            }
          }
        }
      }
    }

    final src = item['src'];
    if (src is Map) {
      for (final key in <String>['original', 'large2x', 'large', 'medium']) {
        final value = src[key];
        if (value is String && value.trim().isNotEmpty) {
          return value.trim();
        }
      }
    }

    return '';
  }
}
