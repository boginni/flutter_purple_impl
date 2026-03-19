import 'dart:io';

import 'package:flutter_purple_domains/flutter_purple_domains.dart';

typedef LookupFunction = Future<List<int>> Function();

class CheckInternetUseCaseImpl extends CheckInternetUseCase {
  const CheckInternetUseCaseImpl({required this.lookupFunction});

  final LookupFunction lookupFunction;

  @override
  Future<bool> call() async {
    try {
      final result = await lookupFunction();
      return result.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
