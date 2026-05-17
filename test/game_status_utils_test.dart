import 'package:flutter_test/flutter_test.dart';
import 'package:nba_app/utils/game_status_utils.dart';

void main() {
  test('FINAL/OT is not live', () {
    expect(GameStatusUtils.isLive('Final/OT'), isFalse);
    expect(GameStatusUtils.isFinal('Final/OT'), isTrue);
  });

  test('quarter and halftime are live', () {
    expect(GameStatusUtils.isLive('4th Quarter'), isTrue);
    expect(GameStatusUtils.isLive('Halftime'), isTrue);
  });

  test('scheduled is not live', () {
    expect(GameStatusUtils.isLive('Scheduled'), isFalse);
  });
}
