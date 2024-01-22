import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peerprep2/screens/auth/login_page.dart';
import 'package:peerprep2/screens/page_core.dart';
import 'package:peerprep2/services/auth_service.dart';
import 'package:peerprep2/services/user_service.dart';
import 'package:peerprep2/utils/constants.dart';
import 'package:peerprep2/utils/utils.dart';
import 'package:peerprep2/widgets/loading_wheel.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key, 
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _ageController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future signUp () async {
    if(passwordConfirmerd()) {
      setState(() {
        _isLoading = false;
      });
      try {
        await AuthService.signUserIn(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ).then((value) {
          UserService.addUserDetails(
            email: _emailController.text.trim(), 
            username: _usernameController.text.trim(), 
            id: FirebaseAuth.instance.currentUser!.uid, 
            photoUrl: Constants.userImageDefault,
          );
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const PageCore(),
          ));
        }
        
        );
      } on FirebaseAuthException catch (e) {
        // ignore: use_build_context_synchronously
        Utils.showErrorMessage(errorMessage: e.message.toString(), context: context);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } 
  }

  bool passwordConfirmerd () {
    if(_passwordController.text.trim() == _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: _isLoading
            ? const LoadingWheel()
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    Text(
                      'Benvenuto',
                      style: GoogleFonts.bebasNeue(
                        fontSize: 52,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Registrati qui',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 50),

                    // Textfield nome utente
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Nome utente',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Textfield età
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: _ageController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Età',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Textfield email
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
              
                    // Password textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Password',
                              ),
                            ),
                          ),
                        ),
                    ),
                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextField(
                              controller: _confirmPasswordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Conferma la password',
                              ),
                            ),
                          ),
                        ),
                    ),
                    const SizedBox(height: 50),
              
                    // Bottone registrati
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: GestureDetector(
                        onTap: signUp,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(12), 
                          ),
                          child: const Center(
                            child: Text(
                              'Registrati',
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