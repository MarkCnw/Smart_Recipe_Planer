import 'package:flutter/material.dart';

class WellnessAppScreen extends StatelessWidget {
  const WellnessAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF5F7FA), Color(0xFFE8EAF0), Color(0xFFF0F2F5)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 1),

                // Top decorative elements
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Container(
                //       width: 40,
                //       height: 40,
                //       decoration: const BoxDecoration(
                //         gradient: RadialGradient(colors: [Color(0xFFFF6B35), Color(0xFFFF4500)]),
                //         shape: BoxShape.circle,
                //       ),
                //       // child: const Icon(Icons.wb_sunny, color: Colors.white, size: 20),
                //     ),
                //     const Text(
                //       '',
                //       style: TextStyle(color: Color(0xFF6B7280), fontSize: 16, fontWeight: FontWeight.w500),
                //     ),
                //   ],
                // ),
                const SizedBox(height: 40),

                // Doctor illustration container
                Container(
                  width: 280,
                  height: 320,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 10))],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 20,
                        left: 20,
                        right: 20,
                        bottom: 60,
                        child: Container(
                          decoration: BoxDecoration(color: const Color(0xFFF8F9FA), borderRadius: BorderRadius.circular(15)),
                          child: Image.asset(
                            'assets/logo2.png', // Replace with your image asset path
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // Decorative elements
                      Positioned(
                        top: 15,
                        right: 15,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            gradient: RadialGradient(colors: [Color.fromARGB(255, 255, 195, 104), Color.fromARGB(255, 255, 115, 0)]),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.eco, color: Colors.white, size: 16),
                        ),
                      ),

                      // Stethoscope indicator
                      Positioned(
                        bottom: 80,
                        left: 30,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: const Color.fromARGB(255, 255, 102, 0), borderRadius: BorderRadius.circular(8)),
                          child: const Icon(Icons.favorite, color: Colors.white, size: 16),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 60),

                // Title
                const Text(
                  'Smart Recipe\nPlaner App',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1F2937), height: 1.2),
                ),

                const SizedBox(width: 24),

                // Description
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Smart Recipe Planner is your personal\nAI-powered food assistant. It helps you decide what to eat based on your preferences and dietary needs.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Color(0xFF6B7280), height: 1.6),
                  ),
                ),

                const Spacer(flex: 2),

                // Get Started Button
                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFFFF6B35), Color(0xFFFF4500)]),
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [BoxShadow(color: const Color(0xFFFF6B35).withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 6))],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(28),
                      onTap: () {
                        // Handle button tap
                        print('Get Started tapped');
                      },
                      child: const Center(
                        child: Text(
                          'Get Started',
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
