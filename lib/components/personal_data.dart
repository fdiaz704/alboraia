import 'package:flutter/material.dart';

void main() => runApp(const Personaldata());

/// This is the main application widget.
class Personaldata extends StatelessWidget {
  const Personaldata({Key? key}) : super(key: key);

  static const String _title = 'IPark';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.chevron_left_rounded),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(_title),
          centerTitle: true,
        ),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Email',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Indique un email válido';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Nombre y Apellidos',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Indique Nombre y apellidos';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'DNI/NIE',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Indique DNI o NIE';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Dirección',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Indique Dirección';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Código Postal',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Indique Código Postal';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Ciudad',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Indique Ciudad';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState!.validate()) {
                  // Process data.
                }
              },
              child: const Text('Procesar'),
            ),
          ),
        ],
      ),
    );
  }
}
