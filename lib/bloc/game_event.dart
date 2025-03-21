part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class StartGame extends GameEvent {}

class MoveSnake extends GameEvent {}

class ChangeDirection extends GameEvent {
  final String newDirection;

  const ChangeDirection(this.newDirection);

  @override
  List<Object> get props => [newDirection];
}