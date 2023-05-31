import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Image.asset('assets/logo1.png'),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Usuario'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor introduce un usuario';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor introduce una contraseña';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_usernameController.text == 'gotecnogar' &&  //******** QUITAR
                          _passwordController.text == 'gotecnogar') {
                        _saveUser();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ConfigPage()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('Usuario o contraseña incorrectos')),
                        );
                      }
                    }
                  },
                  child: Text('Iniciar Sesión'),
                ),
              ),
              Image.asset('assets/logo2.png'),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _usernameController.text = (prefs.getString('user') ?? '');
      _passwordController.text = (prefs.getString('password') ?? '');
    });
  }

  Future<void> _saveUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', _usernameController.text);
    prefs.setString('password', _passwordController.text);
  }
}
