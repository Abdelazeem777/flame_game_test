import 'package:bloc/bloc.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_game_test/cubit/game_cubit.dart';
import 'package:flame_game_test/my_game.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: BlocProvider(
          create: (context) => GameCubit(),
          child: Builder(
            builder: (context) {
              final cubit = context.read<GameCubit>();
              return Stack(
                children: [
                  BlocBuilder<GameCubit, GameState>(
                    buildWhen: (previous, current) =>
                        previous.health != current.health,
                    builder: (context, state) => Positioned(
                      top: 8,
                      left: 8,
                      child: Text(
                        'health: ${state.health}',
                        style: const TextStyle(fontSize: 24.0),
                      ),
                    ),
                  ),
                  BlocBuilder<GameCubit, GameState>(
                    buildWhen: (previous, current) =>
                        previous.score != current.score,
                    builder: (context, state) => Positioned(
                      top: 8,
                      right: 8,
                      child: Text(
                        'score: ${state.score}',
                        style: const TextStyle(fontSize: 24.0),
                      ),
                    ),
                  ),
                  BlocBuilder<GameCubit, GameState>(
                    buildWhen: (previous, current) =>
                        previous.gameState != current.gameState,
                    builder: (context, state) {
                      if (state.gameState == GameStateEnum.gameOver)
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Game Over',
                                style: TextStyle(fontSize: 32.0),
                              ),
                              Text(
                                'your score: ${state.score}',
                                style: const TextStyle(fontSize: 18.0),
                              ),
                              TextButton(
                                onPressed: cubit.reset,
                                child: const Text(
                                  'Restart',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ],
                          ),
                        );

                      if (state.gameState == GameStateEnum.playing)
                        return GameWidget(
                            game: MyGame(
                          initHealth: state.health ?? 10,
                          initScore: state.score ?? 0,
                          decreaseHealthCallback: cubit.decreaseHealth,
                          increaseScoreCallback: cubit.increaseScore,
                        ));

                      return const SizedBox();
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    ),
  );
}
