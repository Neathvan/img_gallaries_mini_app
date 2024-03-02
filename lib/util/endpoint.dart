class Endpoint {
  static  const String _v = 'v2/';

  /// endpoints - IMAGES
  static const imgList = 'list';
  
  static addV2(String endpoint) => _v + endpoint;
}