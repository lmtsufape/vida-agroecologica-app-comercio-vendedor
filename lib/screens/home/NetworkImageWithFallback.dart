import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkImageWithFallback extends StatelessWidget {
  final String url;
  final Map<String, String>? headers;
  final String fallbackUrl;

  NetworkImageWithFallback({
    required this.url,
    this.headers,
    required this.fallbackUrl,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _imageExists(url, headers),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == true) {
            return Image.network(url, headers: headers);
          } else {
            return Image.network(fallbackUrl);
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<bool> _imageExists(String url, Map<String, String>? headers) async {
    final response = await http.head(Uri.parse(url), headers: headers);
    return response.statusCode == 200;
  }
}
