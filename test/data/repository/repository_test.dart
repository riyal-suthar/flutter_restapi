import 'package:flutter_restapi/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:flutter_restapi/data/repository/repository.dart';

import 'repository_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('ApiService', () {
    final client = MockClient();

    test('returns data if the http call completes successfully', () async {
      when(client.get(Uri.parse("https://dummyjson.com/products")))
          .thenAnswer((_) async => http.Response(''' {

      "id": 1,
      "title": "Essence Mascara Lash Princess",
      "description": "The Essence Mascara Lash Princess is a popular mascara known for its volumizing and lengthening effects. Achieve dramatic lashes with this long-lasting and cruelty-free formula.",
      "category": "beauty",
      "price": 9.99,
      "discountPercentage": 7.17,
      "rating": 4.94,
      "stock": 5,
      "brand": "Essence",
      "thumbnail": "...",
      "images": ["...", "...", "..."]
              }''', 200));

      expect(await AppRepository().singleProductDetails(1), isA<Products>());
    });

    test('throws an exception if the http call completes with an error', () {
      when(client.get(Uri.parse('throw error')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(AppRepository().singleProductDetails(1), throwsException);
    });
  });
}
