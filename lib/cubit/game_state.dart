// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'game_cubit.dart';

enum GameStateEnum { playing, gameOver }

class GameState {
  final GameStateEnum gameState;
  int? health;
  int? score;
  GameState({
    required this.gameState,
    this.health,
    this.score,
  });

  GameState copyWith({
    GameStateEnum? gameState,
    int? health,
    int? score,
  }) {
    return GameState(
      gameState: gameState ?? this.gameState,
      health: health ?? this.health,
      score: score ?? this.score,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'gameState': gameState,
      'health': health,
      'score': score,
    };
  }

  factory GameState.fromMap(Map<String, dynamic> map) {
    return GameState(
      gameState: map['gameState'],
      health: map['health'] != null ? map['health'] as int : null,
      score: map['score'] != null ? map['score'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GameState.fromJson(String source) =>
      GameState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'GameState(gameState: $gameState, health: $health, score: $score)';

  @override
  bool operator ==(covariant GameState other) {
    if (identical(this, other)) return true;

    return other.gameState == gameState &&
        other.health == health &&
        other.score == score;
  }

  @override
  int get hashCode => gameState.hashCode ^ health.hashCode ^ score.hashCode;
}
