import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/game_bloc.dart';

void main() {
  runApp(const WebGame());
}

class WebGame extends StatelessWidget {
  const WebGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Snake Game',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: BlocProvider(
        create: (_) => GameBloc()..add(StartGame()),
        child: const WebGameScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WebGameScreen extends StatelessWidget {
  const WebGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: BlocBuilder<GameBloc, GameState>(
              builder: (context, state) {
                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: state.gridSize,
                  ),
                  itemCount: state.gridSize * state.gridSize,
                  itemBuilder: (context, index) {
                    int x = index % state.gridSize;
                    int y = index ~/ state.gridSize;
                    bool isHead = (state.headX == x && state.headY == y);

                    return Container(
                      margin: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: isHead ? Colors.green : Colors.grey[900],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          // Movement Buttons
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              children: [
                IconButton(
                  iconSize: 50,
                  color: Colors.white,
                  icon: const Icon(Icons.arrow_drop_up),
                  onPressed: () => context.read<GameBloc>().add(const ChangeDirection('up')),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: 50,
                      color: Colors.white,
                      icon: const Icon(Icons.arrow_left),
                      onPressed: () => context.read<GameBloc>().add(const ChangeDirection('left')),
                    ),
                    const SizedBox(width: 60),
                    IconButton(
                      iconSize: 50,
                      color: Colors.white,
                      icon: const Icon(Icons.arrow_right),
                      onPressed: () => context.read<GameBloc>().add(const ChangeDirection('right')),
                    ),
                  ],
                ),
                IconButton(
                  iconSize: 50,
                  color: Colors.white,
                  icon: const Icon(Icons.arrow_drop_down),
                  onPressed: () => context.read<GameBloc>().add(const ChangeDirection('down')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}