import 'package:flutter/material.dart';
import 'package:fractals/sierpinski_carpet/chaos_game/carpet_chaos_game_view.dart';
import 'package:fractals/sierpinski_carpet/removing_squares/removing_squares_view.dart';
import 'package:fractals/sierpinski_triangle/chaos_game/chaos_game_view.dart';
import 'package:fractals/sierpinski_triangle/removing_triangles/removing_triangles_view.dart';

class SierpinskiCarpetMenuView extends StatelessWidget {
  const SierpinskiCarpetMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sierpinski Carpet'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            ListTile(
              title: const Text('Removing Squares'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const RemovingSquaresView(),
                ),
              ),
            ),
            ListTile(
              title: const Text('Chaos Game'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CarpetChaosGameView(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
