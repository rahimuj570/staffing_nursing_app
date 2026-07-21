import 'package:flutter/material.dart';

class NoInternetView extends StatelessWidget {
  final VoidCallback onRetry;

  const NoInternetView({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.wifi_off, size: 90, color: Colors.grey),
                const SizedBox(height: 24),
                const Text(
                  "No Internet Connection",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Please check your internet connection and try again.",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    print('onRetry');
                    onRetry();
                  },
                  child: const Text("Retry"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
