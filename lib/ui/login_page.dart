import 'package:flutter/material.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:provider/provider.dart';
import 'package:test/Classes/Exception/storageException.dart';
import 'package:test/Classes/account.dart';
import 'package:test/Classes/accountManager.dart';
import 'package:test/Classes/authentification.dart';
import 'package:test/Classes/cle.dart';
import 'package:test/ui/demo/demo_yubikey_page.dart';
import 'package:test/Classes/conflict_manager.dart';
import 'package:test/Classes/password.dart';
import 'package:test/ui/nav_bar.dart';
import '../Classes/config.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const String login = "Pierre";
    const String password = 'password123';
    final String salt = BCrypt.gensalt();
    final String hash = BCrypt.hashpw(
      password,
      salt,
    );
    final crypt = encrypt(hash);

    var size = MediaQuery.of(context).size;
    double w = size.width; //* MediaQuery.of(context).devicePixelRatio;
    double h = size.height;

    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              // Title
              const Text(
                'Welcome Back !',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(height: 50),

              // Email Input
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              //Password Input
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Sign In Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple[300],
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    onTap: () async {
                                            if (await Authentification.authentification(
                          (emailController.text).trim(),
                          (passwordController.text).trim())) {
                        context.read<Account>().setId = (emailController.text);
                        await context.read<Config>().setAppDirPath();
                        context.read<Account>().fillVault(
                            context.read<Config>().appDirPath.path, context);
                            if(AccountManager.getAuthMethod(context.read<Account>()) == 'twoFA_with_yubikey'){
                              Navigator.push(context, 
                              MaterialPageRoute(
                                builder: (context) => const YubikeyDemoPage(),
                            ),);
                            } else {
                               Navigator.push(
                                context,
                                MaterialPageRoute<dynamic>(
                                    builder: (context) => const NavBar()));
                            }
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text('Erreur'),
                                  content: const Text(
                                      "Le mot de passe ou le nom de l'utilisateur est incorrect !!"),
                                  actions: [
                                    TextButton(
                                      child: const Text('Ok'),
                                      onPressed: () => Navigator.pop(context),
                                    )
                                  ],
                                ));
                      }
                    },
                    child: const Center(
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
                        
              // Register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Not a member? ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute<dynamic>(
                              builder: (context) => const RegisterPage()));
                    },
                    child: const Text(
                      'Register now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ));
  }
}
