import 'dart:convert';

import 'package:bloc/bloc.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit()
      : super(GameState(
          gameState: GameStateEnum.playing,
          health: 10,
          score: 0,
        ));

  void decreaseHealth() {
    if (state.health == 1)
      emit(state.copyWith(gameState: GameStateEnum.gameOver));
    else
      emit(state.copyWith(health: state.health! - 1));
  }

  void increaseScore() {
    emit(state.copyWith(score: state.score! + 1));
  }

  void reset() {
    emit(GameState(
      gameState: GameStateEnum.playing,
      health: 10,
      score: 0,
    ));
  }
}
