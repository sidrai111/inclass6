import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AgeCounter(),
      child: const MyApp(),
    ),
  );
}

class AgeCounter with ChangeNotifier {
  int age = 0;

  void setAge(double newAge) {
    age = newAge.toInt();
    notifyListeners();
  }

  void incrementAge() {
    if (age < 99) {
      age++;
      notifyListeners();
    }
  }

  void decrementAge() {
    if (age > 0) {
      age--;
      notifyListeners();
    }
  }

  Color get backgroundColor {
    if (age <= 12) return Colors.lightBlue;
    if (age <= 19) return Colors.lightGreen;
    if (age <= 30) return Colors.yellow; // Fixed invalid color reference
    if (age <= 50) return Colors.orange;
    return Colors.grey;
  }

  String get milestoneMessage {
    if (age <= 12) return "You're a child!";
    if (age <= 19) return "Teenager time!";
    if (age <= 30) return "You're a young adult!";
    if (age <= 50) return "You're an adult now!";
    return "Golden years!";
  }

  double get progressValue {
    if (age <= 33) return 0.33;
    if (age <= 67) return 0.67;
    return 1.0;
  }

  Color get progressColor {
    if (age <= 33) return Colors.green;
    if (age <= 67) return Colors.yellow;
    return Colors.red;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Age Milestones',
      theme: ThemeData(useMaterial3: true),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var ageCounter = context.watch<AgeCounter>();
    
    return Scaffold(
      backgroundColor: ageCounter.backgroundColor,
      appBar: AppBar(title: const Text('Age Milestones')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Age: ${ageCounter.age}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Text(
              ageCounter.milestoneMessage,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            Slider(
              value: ageCounter.age.toDouble(),
              min: 0,
              max: 99,
              divisions: 99,
              label: ageCounter.age.toString(),
              onChanged: (value) => ageCounter.setAge(value),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: ageCounter.progressValue,
              color: ageCounter.progressColor,
              backgroundColor: Colors.grey.shade300,
              minHeight: 10,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => ageCounter.decrementAge(),
                  child: const Text("Decrease Age"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => ageCounter.incrementAge(),
                  child: const Text("Increase Age"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}