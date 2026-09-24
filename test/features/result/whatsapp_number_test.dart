import 'package:flutter_test/flutter_test.dart';
import 'package:snapframe/features/result/domain/whatsapp_number.dart';

void main() {
  test('strips formatting down to international digits', () {
    expect(normalizeWhatsAppNumber('+62 812-3456-7890'), '6281234567890');
    expect(normalizeWhatsAppNumber('(1) 415 555 0132'), '14155550132');
  });

  test('rejects a local number missing its country code', () {
    expect(normalizeWhatsAppNumber('081234567890'), isNull);
  });

  test('rejects too short, too long, and non-digit input', () {
    expect(normalizeWhatsAppNumber('1234'), isNull);
    expect(normalizeWhatsAppNumber('1234567890123456'), isNull);
    expect(normalizeWhatsAppNumber('62812abc4567'), isNull);
    expect(normalizeWhatsAppNumber(''), isNull);
  });
}
