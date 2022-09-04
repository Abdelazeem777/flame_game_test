import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'my_game.dart';
import 'player.dart';

// class for the moving obstacle
class FlameObstacle extends SpriteComponent
    with HasGameRef<MyGame>, CollisionCallbacks {
  // constructor
  FlameObstacle(
      {required this.onCollisionWithPlayer,
      required this.onRemoveWithoutCollision});

  final VoidCallback onCollisionWithPlayer;
  final VoidCallback onRemoveWithoutCollision;
  bool movingRight = true;

  @override
  Future<void>? onLoad() {
    add(RectangleHitbox());
    return super.onLoad();
  }

  // update function
  @override
  void update(double dt) {
    super.update(dt);
    movingRight ? x += 6 : x -= 6;

    if (x > gameRef.size.x && movingRight)
      movingRight = false;
    else if (x < 0 && !movingRight) movingRight = true;

    y += .8;

    if (y > gameRef.size.y) {
      onRemoveWithoutCollision();
      gameRef.remove(this);
    }
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    print('collision');
    if (other is Player) {
      gameRef.health--;
      onCollisionWithPlayer();
      gameRef.remove(this);
    }

    super.onCollision(points, other);
  }
}
