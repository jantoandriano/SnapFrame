/// Normalizes user input to the digits-only international format WhatsApp
/// addresses chats by (e.g. `+62 812-3456-7890` → `6281234567890`).
///
/// Returns `null` when the input can't be a full international number:
/// a leading `0` means the country code is missing, and E.164 caps numbers
/// at 15 digits.
String? normalizeWhatsAppNumber(String input) {
  final digits = input.replaceAll(RegExp(r'[\s\-().+]'), '');
  if (!RegExp(r'^[1-9]\d{7,14}$').hasMatch(digits)) return null;
  return digits;
}
