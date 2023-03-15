import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/errors/processing_error.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final imageUrl;
  bool isFavorite;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite = false});

  void toggleFavoriteStatus() async {
    final url = Uri.https(
        'fldemo-shop-default-rtdb.europe-west1.firebasedatabase.app',
        '/products/$id.json');
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      final response =
          await http.patch(url, body: json.encode({'isFavorite': isFavorite}));
      print('Response statusCode: ${response.statusCode}');
      if (response.statusCode >= 400) {
        throw (ProcessingError('The http call failed'));
      }
    } catch (error) {
      print("Error: $error");
      isFavorite = oldStatus;
      notifyListeners();
    }
  }
}
