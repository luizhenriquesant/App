// file: lib/presentation/screens/home/widgets/home_app_bar.dart

import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // 1. Ícone à esquerda (leading)
      leading: const Icon(Icons.menu_book, size: 28),

      // 2. Título do aplicativo
      title: const Text(
        'Recipe AI',
        style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
      ),
      // 3. Ações à direita
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          tooltip: 'Pesquisar receitas',
          onPressed: () {
            // TODO: Implementar a lógica de busca no futuro.
            // Ex: context.go(Routes.search);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Funcionalidade de busca a ser implementada!'),
              ),
            );
          },
        ),
        const SizedBox(width: 8),
      ],
      elevation: 4.0,
      shadowColor: Colors.black.withOpacity(0.2),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
