import 'package:flutter/material.dart';

void main() {
  runApp(const CadastroApp());
}

class CadastroApp extends StatelessWidget {
  const CadastroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Cadastro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CadastroHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CadastroHomePage extends StatefulWidget {
  const CadastroHomePage({super.key});

  @override
  State<CadastroHomePage> createState() => _CadastroHomePageState();
}

class _CadastroHomePageState extends State<CadastroHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();

  final List _cadastros = [];

  void _salvarCadastro() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _cadastros.add({
          'nome': _nomeController.text,
          'email': _emailController.text,
        });
        _nomeController.clear();
        _emailController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastro realizado com sucesso!')),
      );
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Informações'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nomeController,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Por favor, insira o nome.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Por favor, insira o e-mail.';
                      }
                      if (!value.contains('@')) {
                        return 'Insira um e-mail válido.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _salvarCadastro,
                    icon: const Icon(Icons.save),
                    label: const Text('Salvar Cadastro'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Registros Salvos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _cadastros.isEmpty
                  ? const Center(
                      child: Text(
                        'Nenhum registro encontrado.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _cadastros.length,
                      itemBuilder: (context, index) {
                        final item = _cadastros[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            leading: const CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                            title: Text(item['nome'] ?? ''),
                            subtitle: Text(item['email'] ?? ''),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}