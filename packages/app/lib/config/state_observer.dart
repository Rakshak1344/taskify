import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:core/utils/logger.dart';

class StateObserver extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    log(
      '[Provider Updated] ${provider.name ?? provider.runtimeType}: $newValue',
    );
  }

  @override
  void didAddProvider(
    ProviderBase provider,
    Object? value,
    ProviderContainer container,
  ) {
    log('[Provider Added] ${provider.name ?? provider.runtimeType}: $value');
  }

  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer container) {
    log('[Provider Disposed] ${provider.name ?? provider.runtimeType}');
  }

  @override
  void providerDidFail(
    ProviderBase provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    log('[Provider Error] ${provider.name ?? provider.runtimeType}: $error');
  }
}
