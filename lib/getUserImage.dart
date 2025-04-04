import 'dart:convert';
import 'dart:typed_data';
import 'package:odoo_rpc/odoo_rpc.dart';

class GetImage {
  /// Fetches the image for a given user ID from Odoo and returns it as Uint8List.
  /// Returns null if no image is found or an error occurs.
  Future<Uint8List?> fetchImage(int userId, OdooClient client) async {
    try {
      final response = await client.callKw({
        'model': 'res.users',
        'method': 'search_read',
        'args': [
          [
            ['id', '=', userId],
          ]
        ],
        'kwargs': {
          'fields': ['image_1920'],
        },
      });

      print('User image response for ID $userId: $response');

      // Check if response is valid
      if (response == null || response.isEmpty || response is! List) {
        print('No data received or invalid format for user ID $userId');
        return null;
      }

      // Process the response
      final List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(response);
      var imageData = data[0]['image_1920'];

      if (imageData != null && imageData is String) {
        try {
          Uint8List imageBytes = base64Decode(imageData);
          print('Image decoded for user ID $userId, length: ${imageBytes.length}');
          return imageBytes;
        } catch (e) {
          print('Error decoding image data for user ID $userId: $e');
          return null;
        }
      } else {
        print('No image data found for user ID $userId');
        return null;
      }
    } catch (e) {
      print('Error fetching image for user ID $userId: $e');
      return null;
    }
  }
}