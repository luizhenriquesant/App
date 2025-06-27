import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routing/routes.dart';
import '../../core/themes/colors.dart';
import '../../core/themes/dimens.dart';
import '../view_models/home_viewmodel.dart';
import 'home_header.dart';

const String bookingButtonKey = 'booking-button';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   widget.viewModel.deleteBooking.addListener(_onResult);
  // }

  // @override
  // void didUpdateWidget(covariant HomeScreen oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   oldWidget.viewModel.deleteBooking.removeListener(_onResult);
  //   widget.viewModel.deleteBooking.addListener(_onResult);
  // }

  // @override
  // void dispose() {
  //   widget.viewModel.deleteBooking.removeListener(_onResult);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go(Routes.search),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          HomeHeader(viewModel: widget.viewModel),
          Expanded(child: Center(child: Text('Conteúdo da tela'))),
        ],
      ),
    );
  }
}
