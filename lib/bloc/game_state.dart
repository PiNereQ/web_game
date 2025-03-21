part of 'game_bloc.dart';

class GameState extends Equatable {
  final int headX;
  final int headY;
  final String direction;
  final int gridSize;

  const GameState({
    required this.headX,
    required this.headY,
    required this.direction,
    required this.gridSize,
  });

  factory GameState.initial() {
    return const GameState(
      headX: 5,
      headY: 5,
      direction: 'right',
      gridSize: 20,
    );
  }

  GameState copyWith({
    int? headX,
    int? headY,
    String? direction,
    int? gridSize,
  }) {
    return GameState(
      headX: headX ?? this.headX,
      headY: headY ?? this.headY,
      direction: direction ?? this.direction,
      gridSize: gridSize ?? this.gridSize,
    );
  }

  @override
  List<Object> get props => [headX, headY, direction, gridSize];
}