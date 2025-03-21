import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameState.initial()) {
    on<StartGame>(_onStartGame);
    on<MoveSnake>(_onMoveSnake);
    on<ChangeDirection>(_onChangeDirection);
  }

  void _onStartGame(StartGame event, Emitter<GameState> emit) {
    Timer.periodic(const Duration(milliseconds: 300), (timer) {
      add(MoveSnake());
    });
  }

  void _onMoveSnake(MoveSnake event, Emitter<GameState> emit) {
    int headX = state.headX;
    int headY = state.headY;
    final direction = state.direction;

    switch (direction) {
      case 'up':
        headY = (headY - 1) % state.gridSize;
        if (headY < 0) headY += state.gridSize;
        break;
      case 'down':
        headY = (headY + 1) % state.gridSize;
        break;
      case 'left':
        headX = (headX - 1) % state.gridSize;
        if (headX < 0) headX += state.gridSize;
        break;
      case 'right':
        headX = (headX + 1) % state.gridSize;
        break;
    }

    emit(state.copyWith(headX: headX, headY: headY));
  }

  void _onChangeDirection(ChangeDirection event, Emitter<GameState> emit) {
    emit(state.copyWith(direction: event.newDirection));
  }
}