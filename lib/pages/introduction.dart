import 'package:flutter/material.dart';
import 'package:gym_crowd/pages/login.dart';
import 'package:gym_crowd/pages/register.dart';

class IntroductionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagem de fundo
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/GymCrowdLogo.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 280,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _navigateWithAnimation(context, const Register());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6000),
                    minimumSize: const Size(300, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Criar Conta',
                    style: TextStyle(color: Color(0xFFFFFFFF)),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _navigateWithAnimation(context, const Login());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFFFFF),
                    minimumSize: const Size(300, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Color(0xFFFF6000)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateWithAnimation(BuildContext context, Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Começa da direita
          const end = Offset.zero;        // Termina no centro
          const curve = Curves.easeInOut; // Transição suave

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }
}
