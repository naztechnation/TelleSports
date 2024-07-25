import 'dart:developer';


import 'package:app_links/app_links.dart';

/// Provides methods to manage dynamic links.
  class DynamicLinkHandler   {
  DynamicLinkHandler._();

  static final instance = DynamicLinkHandler._();

  final _appLinks = AppLinks();

   
  Future<void> initialize() async {
    
    _appLinks.uriLinkStream.listen(_handleLinkData).onError((error) {
      log('$error', name: 'Dynamic Link Handler');
    });
    _checkInitialLink();
  }

   
  Future<void> _checkInitialLink() async {
    final initialLink = await _appLinks.getInitialLink();
    if (initialLink != null) {
      _handleLinkData(initialLink);
    }
  }

  /// Handles the link navigation Dynamic Links.
  void _handleLinkData(Uri data) {
    final queryParams = data.queryParameters;
    log(data.toString(), name: 'Dynamic Link Service');
    if (queryParams.isNotEmpty) {
      // Perform navigation as needed.
      // Get required data by [queryParams]
    }
  }

  /// Provides the short url for your dynamic link.
  Future<String> createProductLink({
    required int id,
    required String title,
  }) async {
    // Call Rest API if link needs to be generated from backend.
    return 'https://example.com/products?id=$id&title=$title';
  }
}