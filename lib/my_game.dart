import 'dart:async';

import 'package:flame/components.dart' hide Timer;
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_game_test/flame_obastacle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'player.dart';

class MyGame extends FlameGame with KeyboardEvents, HasCollisionDetection {
  MyGame({
    int initHealth = 10,
    int initScore = 0,
    required this.decreaseHealthCallback,
    required this.increaseScoreCallback,
  })  : health = initHealth,
        score = initScore;
  final VoidCallback decreaseHealthCallback;
  final VoidCallback increaseScoreCallback;
  int health;
  int score;
  int numOfCreatedObstacles = 1;
  @override
  Color backgroundColor() => const Color(0x00000000);
  late final Player player;
  late final Sprite flameSprite;
  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;

    if ((keysPressed.contains(LogicalKeyboardKey.arrowLeft)) && isKeyDown) {
      moveLeft();
      return KeyEventResult.handled;
    }
    if ((keysPressed.contains(LogicalKeyboardKey.arrowRight)) && isKeyDown) {
      moveRight();
      return KeyEventResult.handled;
    }
    if ((keysPressed.contains(LogicalKeyboardKey.arrowUp)) && isKeyDown) {
      moveUp();
      return KeyEventResult.handled;
    }
    if ((keysPressed.contains(LogicalKeyboardKey.arrowDown)) && isKeyDown) {
      moveDown();
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await FlameAudio.audioCache.load('background_music.mp3');
    FlameAudio.play('background_music.mp3');

    final playerSprite = await loadSprite('player.png');
    flameSprite = await loadSprite('flame.png');

    add(
      player = Player()
        ..sprite = playerSprite
        ..position = Vector2(size.x / 2, size.y * 0.8)
        ..width = 100
        ..height = 100
        ..anchor = Anchor.center,
    );

    _addObstacleEverySecond();
  }

  FlameObstacle _createNewObstacle(xPosition) {
    return FlameObstacle(
      onCollisionWithPlayer: decreaseHealthCallback,
      onRemoveWithoutCollision: increaseScoreCallback,
    )
      ..position = Vector2(xPosition, 0.0)
      ..sprite = flameSprite
      ..width = 35
      ..height = 35
      ..anchor = Anchor.center;
  }

  void _addObstacleEverySecond() {
    add(_createNewObstacle(0.0));
    Timer.periodic(const Duration(seconds: 10), (_) {
      for (var i = 0; i < numOfCreatedObstacles; i++) {
        add(_createNewObstacle(size.x / numOfCreatedObstacles * i));
      }
      numOfCreatedObstacles++;
    });
  }

  void moveLeft() {
    player.moveLeft();
  }

  void moveRight() {
    player.moveRight();
  }

  void moveUp() {
    player.moveUp();
  }

  void moveDown() {
    player.moveDown();
  }

  @override
  void update(double dt) {
    if (health == 0) {}
    super.update(dt);
  }

  @override
  void onRemove() {
    FlameAudio.audioCache.clearAll();
    super.onRemove();
  }
}
