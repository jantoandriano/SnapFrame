import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:snapframe/features/result/data/compositor_repository_impl.dart';
import 'package:snapframe/features/result/data/save_share_repository_impl.dart';
import 'package:snapframe/features/result/domain/compositor_repository.dart';
import 'package:snapframe/features/result/domain/save_share_repository.dart';

part 'result_providers.g.dart';

@riverpod
CompositorRepository compositorRepository(Ref ref) =>
    CompositorRepositoryImpl();

@riverpod
SaveShareRepository saveShareRepository(Ref ref) => SaveShareRepositoryImpl();
