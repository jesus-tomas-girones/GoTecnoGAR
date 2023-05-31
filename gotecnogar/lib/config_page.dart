import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gotecnogar/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'web_page.dart';

class ConfigPage extends StatefulWidget {
  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final _formKey = GlobalKey<FormState>();
  final _ipController = TextEditingController(text: '158.42.146.127');
  final _portController = TextEditingController(text: '80');
  final _pathController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadIpAndPort();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensor a monitorizar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Image.asset('assets/logo1.png'),
              TextFormField(
                controller: _ipController,
                decoration:
                    InputDecoration(labelText: 'dir. IP o nombre DNS: '),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor introduce una dirección IP o nombre DNS';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _portController,
                decoration: InputDecoration(labelText: 'puerto: '),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor introduce un puerto';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _pathController,
                decoration: InputDecoration(labelText: 'ruta: '),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await _saveIpAndPort();
                      // Aquí puedes añadir la lógica para conectar con el servidor.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebPage(
                                ip: _ipController.text,
                                port: _portController.text,
                                path: _pathController.text)),
                      );
                    }
                  },
                  child: Text('CONECTAR'),
                ),
              ),
              Image.asset('assets/logo2.png'),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _loadIpAndPort() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _ipController.text = (prefs.getString('ip') ?? '158.42.146.127');
      _portController.text = (prefs.getString('port') ?? '80');
      _pathController.text = (prefs.getString('path') ?? '');
    });
  }

  Future<void> _saveIpAndPort() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('ip', _ipController.text);
    prefs.setString('port', _portController.text);
    prefs.setString('path', _pathController.text);
  }
}
