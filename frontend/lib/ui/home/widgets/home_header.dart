import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// import '../../core/themes/dimens.dart';
import '../view_models/home_viewmodel.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      // decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
      child: Row(
        children: [
          const Icon(
            Icons.star, // ícone aleatório
            color: Colors.white,
            size: 28,
          ),
          const SizedBox(width: 12),
          Text(
            'Meu App',
            style: GoogleFonts.rubik(
              textStyle: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
        ],
      ),
    );
  }
}
