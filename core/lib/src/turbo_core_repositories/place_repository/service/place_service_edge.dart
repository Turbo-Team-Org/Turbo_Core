import 'package:core/src/turbo_core_repositories/analytics_repository/interface/analytics_interface.dart';
import 'package:core/src/turbo_core_repositories/place_repository/interface/place_authorization_interface.dart';
import 'package:core/src/turbo_core_repositories/place_repository/interface/place_interface.dart';
import 'package:core/src/turbo_core_repositories/place_repository/models/place/place.dart';
import 'package:core/src/turbo_core_repositories/place_repository/models/place_owner_analytics.dart';
import 'package:core/src/turbo_core_repositories/review_repository/models/review.dart';
import 'package:dio/dio.dart';

/// Place service que consume Edge Functions (gateway) para operar con RLS estricta en Supabase
class PlaceServiceEdge implements PlaceInterface {
  const PlaceServiceEdge({
    required this.baseUrl,
    required this.httpClient,
    required this.analyticsService,
    required this.authorization,
  });

  final String baseUrl; // https://<project>.functions.supabase.co
  final Dio httpClient;
  final AnalyticsInterface analyticsService;
  final PlaceAuthorizationInterface authorization;

  String _url(String path) => '$baseUrl$path';

  @override
  Future<List<Place>> getPlaces() async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/public_get_places'),
    );
    final List<dynamic> data = res.data ?? <dynamic>[];
    return data.map((e) => _placeFromEdge(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<Place> getPlaceById(String id) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/public_get_place_by_id'),
          queryParameters: {'id': id},
        );
    final Map<String, dynamic> data = res.data ?? <String, dynamic>{};
    return _placeFromEdge(data);
  }

  @override
  Future<Place> getPlaceByName(String name) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/public_get_place_by_name'),
          queryParameters: {'name': name},
        );
    final Map<String, dynamic> data = res.data ?? <String, dynamic>{};
    return _placeFromEdge(data);
  }

  @override
  Future<List<Place>> getPlacesByCategory(String categoryId) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/public_get_places_by_category'),
      queryParameters: {'categoryId': categoryId},
    );
    final List<dynamic> data = res.data ?? <dynamic>[];
    return data.map((e) => _placeFromEdge(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<void> addPlace(Place place) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .post<Map<String, dynamic>>(
          _url('/admin_add_place'),
          data: _placeToEdgePayload(place),
        );
    final Map<String, dynamic> data = res.data ?? <String, dynamic>{};
    final String createdId = (data['id'] as String?) ?? place.id;
    try {
      await analyticsService.initializeAnalyticsStructure(createdId);
    } catch (_) {}
  }

  @override
  Future<void> addPlaceWithOwner(Place place, String ownerId) async {
    final payload = _placeToEdgePayload(place)..['ownerId'] = ownerId;
    final Response<Map<String, dynamic>> res = await httpClient
        .post<Map<String, dynamic>>(
          _url('/admin_add_place_with_owner'),
          data: payload,
        );
    final Map<String, dynamic> data = res.data ?? <String, dynamic>{};
    final String createdId = (data['id'] as String?) ?? place.id;
    try {
      await analyticsService.initializeAnalyticsStructure(createdId);
    } catch (_) {}
  }

  @override
  Future<void> updatePlace(Place place) async {
    await httpClient.post<void>(
      _url('/admin_update_place'),
      data: _placeToEdgePayload(place),
    );
  }

  @override
  Future<void> deletePlace(String id) async {
    if (!authorization.canManagePlace(id)) {
      throw Exception('No tienes permisos para eliminar este lugar');
    }
    await httpClient.post<void>(_url('/admin_delete_place'), data: {'id': id});
  }

  @override
  Future<List<Place>> getPlacesByOwnerId(String ownerId) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/admin_get_places_by_owner'),
      queryParameters: {'ownerId': ownerId},
    );
    final List<dynamic> data = res.data ?? <dynamic>[];
    return data.map((e) => _placeFromEdge(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<Place>> getPlacesByOwnerIds(List<String> ownerIds) async {
    final Response<List<dynamic>> res = await httpClient.post<List<dynamic>>(
      _url('/admin_get_places_by_owners'),
      data: {'ownerIds': ownerIds},
    );
    final List<dynamic> data = res.data ?? <dynamic>[];
    return data.map((e) => _placeFromEdge(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<Place> updatePlaceOwnership(
    String placeId,
    List<String> ownerIds,
  ) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .post<Map<String, dynamic>>(
          _url('/admin_update_place_ownership'),
          data: {'placeId': placeId, 'ownerIds': ownerIds},
        );
    final Map<String, dynamic> data = res.data ?? <String, dynamic>{};
    return _placeFromEdge(data);
  }

  @override
  Future<PlaceOwnerAnalytics> getPlaceAnalyticsByOwnerId(String ownerId) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/admin_get_place_analytics'),
          queryParameters: {'ownerId': ownerId},
        );
    final Map<String, dynamic> data = res.data ?? <String, dynamic>{};
    return PlaceOwnerAnalytics.fromData(ownerId, data);
  }

  Place _placeFromEdge(Map<String, dynamic> data) {
    String asString(dynamic value) => value?.toString() ?? '';
    double asDouble(dynamic value) =>
        value == null
            ? 0.0
            : (value is double
                ? value
                : double.tryParse(value.toString()) ?? 0.0);
    int asInt(dynamic value) =>
        value == null
            ? 0
            : (value is int ? value : int.tryParse(value.toString()) ?? 0);
    bool asBool(dynamic value) => value is bool ? value : value == true;
    List<String> asStringList(dynamic value) =>
        value is List ? List<String>.from(value) : [];
    Map<String, dynamic> asMap(dynamic value) =>
        value is Map<String, dynamic> ? value : {};

    return Place(
      id: asString(data['id'] ?? data['docId']),
      name: asString(data['name']),
      description: asString(data['description']),
      address: asString(data['address']),
      averagePrice: asDouble(data['average_price'] ?? data['averagePrice']),
      imageUrls: asStringList(data['image_urls'] ?? data['imageUrls']),
      rating: asDouble(data['rating']),
      reviews:
          (data['reviews'] is List)
              ? (data['reviews'] as List)
                  .map((e) => _reviewFromEdge(e as Map<String, dynamic>))
                  .toList()
              : <Review>[],
      tags: asStringList(data['tags']),
      isOpen: asBool(data['is_open'] ?? data['isOpen']),
      mainImage: asString(data['main_image'] ?? data['mainImage']),
      favoriteCount: asInt(data['favorite_count'] ?? data['favoriteCount']),
      menuUrl: asString(data['menu_url'] ?? data['menuUrl']),
      latitude: asDouble(data['latitude']),
      longitude: asDouble(data['longitude']),
      categoryId: asString(data['category_id'] ?? data['categoryId']),
      categoryName: asString(data['category_name'] ?? data['categoryName']),
      categoryIcon: asString(data['category_icon'] ?? data['categoryIcon']),
      openingHours:
          (asMap(
            data['opening_hours'] ?? data['openingHours'],
          )).cast<String, Map<String, String>>(),
      phone: asString(data['phone']),
      website: asString(data['website']),
      priceLevel: asInt(data['price_level'] ?? data['priceLevel']),
      metadata: asMap(data['metadata']),
      ownerIds: asStringList(data['owner_ids'] ?? data['ownerIds']),
      createdBy: asString(data['created_by'] ?? data['createdBy']),
      createdAt:
          data['created_at'] != null
              ? DateTime.tryParse(asString(data['created_at']))
              : (data['createdAt'] != null
                  ? DateTime.tryParse(asString(data['createdAt']))
                  : null),
      lastUpdated:
          data['updated_at'] != null
              ? DateTime.tryParse(asString(data['updated_at']))
              : (data['lastUpdated'] != null
                  ? DateTime.tryParse(asString(data['lastUpdated']))
                  : null),
    );
  }

  Map<String, dynamic> _placeToEdgePayload(Place place) {
    return {
      'id': place.id,
      'name': place.name,
      'description': place.description,
      'address': place.address,
      'average_price': place.averagePrice,
      'image_urls': place.imageUrls,
      'rating': place.rating,
      'tags': place.tags,
      'is_open': place.isOpen,
      'main_image': place.mainImage,
      'favorite_count': place.favoriteCount,
      'menu_url': place.menuUrl,
      'latitude': place.latitude,
      'longitude': place.longitude,
      'category_id': place.categoryId,
      'category_name': place.categoryName,
      'category_icon': place.categoryIcon,
      'opening_hours': place.openingHours,
      'phone': place.phone,
      'website': place.website,
      'price_level': place.priceLevel,
      'metadata': place.metadata,
      'owner_ids': place.ownerIds,
      'created_by': place.createdBy,
      'created_at': place.createdAt?.toIso8601String(),
      'updated_at': place.lastUpdated?.toIso8601String(),
    };
  }

  Review _reviewFromEdge(Map<String, dynamic> data) {
    return Review(
      id: (data['id'] as String?) ?? '',
      userId: (data['user_id'] as String?) ?? (data['userId'] as String? ?? ''),
      userName:
          (data['user_name'] as String?) ?? (data['userName'] as String? ?? ''),
      userAvatar:
          (data['user_photo_url'] as String?) ??
          (data['userAvatar'] as String? ?? ''),
      comment: (data['comment'] as String?) ?? '',
      rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
      date:
          data['created_at'] != null
              ? DateTime.tryParse(data['created_at'].toString()) ??
                  DateTime.now()
              : (data['date'] != null
                  ? DateTime.tryParse(data['date'].toString()) ?? DateTime.now()
                  : DateTime.now()),
    );
  }

  @override
  Future<List<Place>> intelligentSearch(
    String query, {
    String? categoryId,
    double? minRating,
    double? maxPrice,
    double? minPrice,
    bool? isOpen,
    int limit = 50,
  }) {
    // TODO: implement intelligentSearch
    throw UnimplementedError();
  }

  @override
  Future<List<Place>> searchPlacesByLocation({
    required double latitude,
    required double longitude,
    double radiusKm = 10.0,
    String? categoryId,
    double? minRating,
    double? maxPrice,
    double? minPrice,
    bool? isOpen,
    int limit = 50,
  }) {
    // TODO: implement searchPlacesByLocation
    throw UnimplementedError();
  }

  @override
  Future<List<Place>> searchPlacesByText(
    String query, {
    String? categoryId,
    double? minRating,
    double? maxPrice,
    double? minPrice,
    bool? isOpen,
    int limit = 50,
  }) {
    // TODO: implement searchPlacesByText
    throw UnimplementedError();
  }

  @override
  Future<List<Place>> searchPlacesByVoice(
    String voiceQuery, {
    String? categoryId,
    double? minRating,
    double? maxPrice,
    double? minPrice,
    bool? isOpen,
    int limit = 50,
  }) {
    // TODO: implement searchPlacesByVoice
    throw UnimplementedError();
  }
}
