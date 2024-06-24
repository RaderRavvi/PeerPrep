import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peerprep2/screens/auth/login_page.dart';
import 'package:peerprep2/screens/auth/register_page.dart';

class WelcomeSignUp extends StatefulWidget {
  const WelcomeSignUp({super.key});

  @override
  State<WelcomeSignUp> createState() => _WelcomeSignUppState();
}

class _WelcomeSignUppState extends State<WelcomeSignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage('assets/PeerPrep no background logo.png'),
                      width: 200,
                      height: 200,
                    ),
                    
                    const SizedBox(height: 10),
                    Text(
                      'Benvenuto!',
                      style: GoogleFonts.bebasNeue(
                        fontSize: 52,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Text(
                        'PeerPrep ti permetterà di connetterti con i compagni di classe, condividere conoscenze e crescere insieme nello studio.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),

                    // Bottone continua
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            )),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(12), 
                          ),
                          child: const Center(
                            child: Text(
                              'Continua',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
              
                    // Non ti sei registrato? Registrati qui
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Hai già un account?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ));
                          },
                          child: const Text(
                            ' Effettua il login',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}