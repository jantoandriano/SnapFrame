import 'package:flutter_test/flutter_test.dart';
import 'package:snapframe/core/result/app_exception.dart';
import 'package:snapframe/core/result/result.dart';

void main() {
  group('Result', () {
    test('isSuccess and valueOrNull reflect a Success', () {
      const result = Result<int>.success(42);
      expect(result.isSuccess, isTrue);
      expect(result.valueOrNull, 42);
    });

    test('isSuccess and valueOrNull reflect a Failure', () {
      const result = Result<int>.failure(NetworkException());
      expect(result.isSuccess, isFalse);
      expect(result.valueOrNull, isNull);
    });

    test('when dispatches to the matching branch', () {
      const success = Result<int>.success(1);
      const failure = Result<int>.failure(NotFoundException());

      expect(
        success.when(success: (v) => 'ok:$v', failure: (e) => 'err'),
        'ok:1',
      );
      expect(
        failure.when(
          success: (v) => 'ok:$v',
          failure: (e) => 'err:${e.message}',
        ),
        'err:not found',
      );
    });

    test('map transforms a Success value and leaves a Failure untouched', () {
      const success = Result<int>.success(2);
      const failure = Result<int>.failure(ValidationException());

      expect(success.map((v) => v * 10).valueOrNull, 20);
      expect(failure.map((v) => v * 10).valueOrNull, isNull);
      failure
          .map((v) => v * 10)
          .when(
            success: (_) => fail('expected a Failure'),
            failure: (e) => expect(e, isA<ValidationException>()),
          );
    });
  });
}
