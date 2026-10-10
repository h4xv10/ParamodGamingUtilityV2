import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const ParamodApp());

const neon = Color(0xFFB7FF36);
const panel = Color(0xFF171B22);
const muted = Color(0xFF9BA4B2);

class ParamodApp extends StatelessWidget {
  const ParamodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Paramod Gaming Utility V2',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B0E12),
        colorScheme: ColorScheme.fromSeed(
          seedColor: neon,
          brightness: Brightness.dark,
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int tab = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomePage(),
      const WeaponsPage(),
      const AimPage(),
      const SettingsPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0E12),
        title: const Row(
          children: [
            Icon(Icons.bolt, color: neon, size: 28),
            SizedBox(width: 8),
            Text('PARAMOD', style: TextStyle(
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            )),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: neon.withOpacity(.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: neon.withOpacity(.5)),
                ),
                child: const Text('V2.0', style: TextStyle(
                  color: neon, fontWeight: FontWeight.bold,
                )),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(child: pages[tab]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (value) => setState(() => tab = value),
        backgroundColor: panel,
        indicatorColor: neon.withOpacity(.17),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard, color: neon),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.gps_fixed),
            selectedIcon: Icon(Icons.gps_fixed, color: neon),
            label: 'Weapons',
          ),
          NavigationDestination(
            icon: Icon(Icons.ads_click),
            selectedIcon: Icon(Icons.ads_click, color: neon),
            label: 'Aim Lab',
          ),
          NavigationDestination(
            icon: Icon(Icons.tune),
            selectedIcon: Icon(Icons.tune, color: neon),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              colors: [Color(0xFF26351B), Color(0xFF171B22)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: neon.withOpacity(.35)),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('YOUR GAME. YOUR STRATEGY.',
                style: TextStyle(color: neon, fontSize: 11,
                  letterSpacing: 1.6, fontWeight: FontWeight.bold)),
              SizedBox(height: 14),
              Text('LEVEL UP\nYOUR GAMEPLAY',
                style: TextStyle(fontSize: 29,
                  height: 1.12, fontWeight: FontWeight.w900)),
              SizedBox(height: 12),
              Text('Practice smarter. Play your way.',
                style: TextStyle(color: muted)),
            ],
          ),
        ),
        const SizedBox(height: 26),
        const SectionTitle('TRAINING ZONE'),
        const SizedBox(height: 12),
        FeatureCard(
          icon: Icons.gps_fixed,
          title: 'Weapon Guide',
          subtitle: 'Weapon stats and practical tips',
          onTap: () => _go(context, 1),
        ),
        FeatureCard(
          icon: Icons.ads_click,
          title: 'Aim Practice',
          subtitle: 'Improve reaction with a tap trainer',
          onTap: () => _go(context, 2),
        ),
        FeatureCard(
          icon: Icons.tune,
          title: 'Sensitivity Notes',
          subtitle: 'Keep your personal settings in one place',
          onTap: () => _go(context, 3),
        ),
        const SizedBox(height: 18),
        const Text(
          'Companion app only • No game modification or automation',
          textAlign: TextAlign.center,
          style: TextStyle(color: muted, fontSize: 11),
        ),
      ],
    );
  }

  void _go(BuildContext context, int index) {
    final state = context.findAncestorStateOfType<_MainScreenState>();
    state?.setState(() => state.tab = index);
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: panel,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: Colors.white.withOpacity(.06)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(14),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: neon.withOpacity(.12),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: neon),
        ),
        title: Text(title, style: const TextStyle(
          fontWeight: FontWeight.bold,
        )),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(subtitle, style: const TextStyle(color: muted)),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 15),
        onTap: onTap,
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) => Text(text,
    style: const TextStyle(
      fontSize: 12, color: muted,
      fontWeight: FontWeight.bold, letterSpacing: 2,
    ));
}

class WeaponsPage extends StatelessWidget {
  const WeaponsPage({super.key});

  static const weapons = [
    ('Assault Rifle', 'Balanced range and damage', Icons.gps_fixed),
    ('SMG', 'Fast close-range handling', Icons.bolt),
    ('Sniper Rifle', 'Precision at long range', Icons.center_focus_strong),
    ('Shotgun', 'High impact at close range', Icons.flash_on),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('WEAPON GUIDE', style: TextStyle(
          fontSize: 25, fontWeight: FontWeight.w900,
        )),
        const SizedBox(height: 8),
        const Text('General weapon classes and practice advice.',
          style: TextStyle(color: muted)),
        const SizedBox(height: 20),
        ...weapons.map((weapon) => Card(
          color: panel,
          child: ListTile(
            leading: Icon(weapon.$3, color: neon, size: 30),
            title: Text(weapon.$1,
              style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(weapon.$2),
          ),
        )),
        const SizedBox(height: 12),
        const Text(
          'Tip: practise recoil control, tracking and positioning in the game’s permitted training modes.',
          style: TextStyle(color: muted, height: 1.5),
        ),
      ],
    );
  }
}

class AimPage extends StatefulWidget {
  const AimPage({super.key});

  @override
  State<AimPage> createState() => _AimPageState();
}

class _AimPageState extends State<AimPage> {
  int score = 0;
  int round = 0;
  final random = Random();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('AIM LAB', style: TextStyle(
            fontSize: 27, fontWeight: FontWeight.w900,
          )),
          const SizedBox(height: 8),
          const Text('Tap the target to practise reaction and accuracy.',
            style: TextStyle(color: muted)),
          const SizedBox(height: 18),
          Row(
            children: [
              _stat('SCORE', '$score'),
              const SizedBox(width: 12),
              _stat('HITS', '$round'),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: panel,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: neon.withOpacity(.25)),
              ),
              child: Center(
                child: GestureDetector(
                  onTap: () => setState(() {
                    score += 10;
                    round++;
                  }),
                  child: Container(
                    width: 104,
                    height: 104,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: neon.withOpacity(.12),
                      border: Border.all(color: neon, width: 3),
                    ),
                    child: const Icon(Icons.gps_fixed,
                      size: 58, color: neon),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: neon,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.all(15),
              ),
              onPressed: () => setState(() {
                score = 0;
                round = 0;
              }),
              icon: const Icon(Icons.refresh),
              label: const Text('RESET PRACTICE'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(String label, String value) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: panel, borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(label, style: const TextStyle(
            color: muted, fontSize: 11, letterSpacing: 1.5,
          )),
          const SizedBox(height: 5),
          Text(value, style: const TextStyle(
            color: neon, fontSize: 24, fontWeight: FontWeight.w900,
          )),
        ],
      ),
    ),
  );
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final sensitivity = TextEditingController();
  bool haptics = true;

  @override
  void dispose() {
    sensitivity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('SETTINGS', style: TextStyle(
          fontSize: 27, fontWeight: FontWeight.w900,
        )),
        const SizedBox(height: 8),
        const Text('Personal notes for your gaming setup.',
          style: TextStyle(color: muted)),
        const SizedBox(height: 24),
        const SectionTitle('SENSITIVITY NOTES'),
        const SizedBox(height: 10),
        TextField(
          controller: sensitivity,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Write your sensitivity values here...',
            filled: true,
            fillColor: panel,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        const SizedBox(height: 12),
        FilledButton(
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Notes are available in this session only.'),
            ),
          ),
          child: const Text('DONE'),
        ),
        const SizedBox(height: 18),
        SwitchListTile(
          value: haptics,
          activeColor: neon,
          title: const Text('Practice feedback preference'),
          subtitle: const Text('Demo setting for future customisation'),
          onChanged: (value) => setState(() => haptics = value),
        ),
        const SizedBox(height: 12),
        const Text(
          'This first version does not save notes after closing the app.',
          style: TextStyle(color: muted, fontSize: 12),
        ),
      ],
    );
  }
}
