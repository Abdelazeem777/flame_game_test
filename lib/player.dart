import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_game_test/my_game.dart';

class Player extends SpriteComponent
    with HasGameRef<MyGame>, CollisionCallbacks {
  @override
  Future<void>? onLoad() {
    add(RectangleHitbox());
    return super.onLoad();
  }

  void moveLeft() {
    if (x > 25) x -= 30;
  }

  void moveRight() {
    final gameSize = gameRef.size;
    if (x < gameSize.x - 25) x += 30;
  }

  void moveUp() {
    if (y > 25) y -= 30;
  }

  void moveDown() {
    final gameSize = gameRef.size;
    if (y < gameSize.y - 25) y += 30;
  }
}
