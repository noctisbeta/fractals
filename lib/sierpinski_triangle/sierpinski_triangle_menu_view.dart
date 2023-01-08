import 'package:flutter/material.dart';
import 'package:fractals/sierpinski_triangle/removing_triangles_view.dart';

class SierpinskiTriangleMenuView extends StatelessWidget {
  const SierpinskiTriangleMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sierpinski Triangle'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            ListTile(
              title: const Text('Removing Triangles'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const RemovingTrianglesView(),
                ),
              ),
            ),
            ListTile(
              title: const Text('Chaos Game'),
              onTap: () {
                Navigator.pushNamed(context, '/chaos_game');
              },
            )
          ],
        ),
      ),
    );
  }
}
