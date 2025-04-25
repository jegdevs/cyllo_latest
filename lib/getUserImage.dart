import 'dart:convert';
import 'dart:typed_data';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
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

      // print('User image response for ID $userId: $response');

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
          // print('Image decoded for user ID $userId, length: ${imageBytes.length}');
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





class OdooAvatar extends StatelessWidget {
  final dynamic client;
  final String model;
  final int recordId;
  final double size;
  final BoxShape shape;
  final double borderRadius;

  const OdooAvatar({
    Key? key,
    required this.client,
    required this.model,
    required this.recordId,
    this.size = 24.0,
    this.shape = BoxShape.circle,
    this.borderRadius = 4.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Null safety checks
    if (client == null ||
        client.baseURL == null ||
        client.sessionId == null ||
        client.sessionId.id == null) {
      debugPrint("❗ OdooAvatar: Missing required client/session info.");
      return _buildPlaceholder();
    }

    final imageUrl =
        "${client.baseURL}/web/image/$model/$recordId/avatar_1920";

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: shape,
        borderRadius:
        shape == BoxShape.rectangle ? BorderRadius.circular(borderRadius) : null,
      ),
      clipBehavior: Clip.antiAlias,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        httpHeaders: {
          "Cookie": "session_id=${client.sessionId.id}"
        },
        fit: BoxFit.cover,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            color: Colors.white,
          ),
        ),
        errorWidget: (context, url, error) => const Icon(
          Icons.person,
          size: 20,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: shape,
        borderRadius: shape == BoxShape.rectangle
            ? BorderRadius.circular(borderRadius)
            : null,
      ),
      alignment: Alignment.center,
      child: SizedBox(
        width: size * 0.5,
        height: size * 0.5,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[500]!),
        ),
      ),
    );
  }

}
