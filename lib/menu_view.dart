import 'package:flutter/material.dart';
import 'package:fractals/sierpinski_carpet/removing_squares/removing_squares_view.dart';
import 'package:fractals/sierpinski_triangle/sierpinski_triangle_menu_view.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fractals'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            ListTile(
              title: const Text('Sierpinski Triangle'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SierpinskiTriangleMenuView(),
                ),
              ),
            ),
            ListTile(
              title: const Text('Sierpinski Carpet'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const RemovingSquaresView(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
