import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kawaiibd_flutterfire_task/src/utils/extensions/extensions.dart';

import 'constants.dart';

Widget riverpodError(e, _) => KError(e);

Widget riverpodLoading() => const KLoading();

Widget riverpodErrorSliver(e, _) => SliverToBoxAdapter(child: KError(e));

Widget riverpodLoadingSliver() => const SliverToBoxAdapter(child: KLoading());

class KLoading extends StatelessWidget {
  const KLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints.tightFor(width: 100.0, height: 100.0),
        child: SpinKitThreeBounce(
          color: context.theme.primaryColor,
          size: 30.0,
        ),
      ),
    );
  }
}

class KError extends StatelessWidget {
  const KError(this.e, {super.key});

  final dynamic e;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: mainMin,
        children: [
          const Icon(
            Icons.error,
            size: 20.0,
            color: Colors.red,
          ),
          const SizedBox(height: 5.0),
          Text(
            'Error: $e',
            style: const TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}
