// import 'package:dio/dio.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'model/Direction.dart';

// final googleApiKey = "AIzaSyBnFc2k4rFaznVW9zfTJQz2s92PZOcqWTs";

// class DirectionsRepository {
//   static const String _baseUrl =
//       "https://maps.googleapis.com/maps/api/directions/json?";

//   final Dio _dio;

//   DirectionsRepository({Dio? dio}) : _dio = dio != null ? dio : Dio();

//   Future<Directions?> getDirections({
//     required LatLng origin,
//     required LatLng destination,
//   }) async {
//     final response = await _dio.get(
//       _baseUrl,
//       queryParameters: {
//         'origin': '${origin.latitude},${origin.longitude}',
//         'destination': '${destination.latitude},${destination.longitude}',
//         'key': googleApiKey,
//       },
//     );

//     // Check if response is successful
//     if (response.statusCode == 200) {
//       return Directions.fromMap(response.data);
//     }
//     return null;
//   }
// }
