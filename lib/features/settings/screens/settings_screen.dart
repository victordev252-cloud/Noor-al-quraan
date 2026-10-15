import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Interface Language'),
            subtitle: const Text('English / Somali / Arabic'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.translate),
            title: const Text('Quran Translation'),
            subtitle: const Text('Somali & English'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.audio_file),
            title: const Text('Offline Audio Management'),
            subtitle: const Text('Manage reciter downloads'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About NOOR AL-QURAN'),
            subtitle: const Text('Version 1.0.0+1 • Offline First'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
