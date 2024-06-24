import 'package:flutter/material.dart';
import 'package:peerprep2/screens/auth/login_page.dart';
import 'package:peerprep2/utils/list.dart';
import 'package:peerprep2/widgets/auth/auth_textfield.dart';
import 'package:peerprep2/widgets/buttons/signup_button.dart';
import 'package:peerprep2/widgets/loading_wheel.dart';

class RegisterPage1 extends StatefulWidget {
  const RegisterPage1({super.key});

  @override
  State<RegisterPage1> createState() => _RegisterPage1State();
}

class _RegisterPage1State extends State<RegisterPage1> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _ageController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final bool _isLoading = false;

  bool passwordConfirmerd () {
    if(_passwordController.text.trim() == _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // List<String> schoolList = AuthService().getData('schools');
    // List<String> coursesList = AuthService().getData();

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
                    const SizedBox(height: 10),
                    const Text(
                      'Registrati qui',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 50),

                    // Textfield nome utente
                    AuthTexfield(hintText: 'Nome utente', controller: _usernameController),
                    const SizedBox(height: 10),

                    // Textfield età
                    AuthTexfield(hintText: 'Età', controller: _ageController),
                    const SizedBox(height: 10),

                    // Textfield email
                    AuthTexfield(hintText: 'Email', controller: _emailController),
                    const SizedBox(height: 10),
              
                    // Password textfield
                    AuthTexfield(hintText: 'Password', controller: _passwordController),
                    const SizedBox(height: 10),

                    AuthTexfield(hintText: 'Conferma password', controller: _confirmPasswordController),
                    const SizedBox(height: 10),

                    DropdownMenu(
                      initialSelection: ITI.first,
                      onSelected: (String? value) {
                        setState(() {
                          ITI.first = value!;
                        });
                      },
                      dropdownMenuEntries: ITI.map<DropdownMenuEntry<String>>((String value){
                        return DropdownMenuEntry<String>(value: value, label: value);
                      }).toList(),
                    ),
                    const SizedBox(height: 50),
                      
                    // Bottone registrati
                    SignUpButton(
                      emailController: _emailController, 
                      passwordController: _passwordController, 
                      usernameController: _usernameController, 
                      isLoading: _isLoading,
                      school: ITI.first,
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