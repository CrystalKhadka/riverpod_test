import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/view_model/counter_view_model.dart';

final appTitleProvider = Provider<String>((ref) => 'Mero App');

final counterProvider = StateProvider((ref) {
  return 0;
});

class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(counterViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ref.read(appTitleProvider),
        ),
      ),
      body: Center(
        child: Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 40,
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              ref.read(counterViewModelProvider.notifier).increment();
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              ref.read(counterViewModelProvider.notifier).decrement();
            },
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
