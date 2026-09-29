import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:snapframe/features/auth/data/auth_providers.dart';
import 'package:snapframe/features/profile/data/fake_subscription_repository.dart';
import 'package:snapframe/features/profile/domain/subscription_repository.dart';

part 'profile_providers.g.dart';

@Riverpod(keepAlive: true)
SubscriptionRepository subscriptionRepository(Ref ref) =>
    FakeSubscriptionRepository(ref.watch(fakeAuthRepositoryProvider));
