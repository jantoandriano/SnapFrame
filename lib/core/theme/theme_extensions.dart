import 'package:flutter/material.dart';
import 'package:snapframe/core/theme/tokens.dart';

extension SnapTokensX on BuildContext {
  SnapTokens get tokens => Theme.of(this).extension<SnapTokens>()!;
}
