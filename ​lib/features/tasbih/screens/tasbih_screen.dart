import 'package:flutter/material.dart';

class TasbihScreen extends StatefulWidget {
  const TasbihScreen({super.key});

  @override
  State<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen> {
  int _count = 0;
  int _target = 33;

  void _increment() {
    setState(() {
      _count++;
    });
  }

  void _reset() {
    setState(() {
      _count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Digital Tasbih')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Target: $_target', style: const TextStyle(fontSize: 18, color: Colors.grey)),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _increment,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    border: Border.all(color: Theme.of(context).primaryColor, width: 4),
                  ),
                  child: Center(
                    child: Text(
                      '$_count',
                      style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _reset,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset'),
                  ),
                  const SizedBox(width: 16),
                  DropdownButton<int>(
                    value: _target,
                    items: const [
                      DropdownMenuItem(value: 33, child: Text('33 times')),
                      DropdownMenuItem(value: 99, child: Text('99 times')),
                      DropdownMenuItem(value: 100, child: Text('100 times')),
                    ],
                    onChanged: (val) => setState(() => _target = val ?? 33),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
