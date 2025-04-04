import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controladores de texto para los campos de entrada
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  // Variables para manejar el error y el estado de la autenticación
  String? _errorMessage;
  bool _isLoading = false;

  // URL de la API de autenticación
  final String _loginUrl = 'https://carros-electricos.wiremockapi.cloud/auth';

  // Función para manejar el login
  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null; // Limpiar el mensaje de error
    });

    final response = await http.post(
      Uri.parse(_loginUrl),
      body: {
        'username': _usernameController.text,
        'password': _passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];

      // Si el login es exitoso, navegar a la pantalla de los carros
      if (token != null) {
        Navigator.pushReplacementNamed(context, '/carros', arguments: token);
      }
    } else {
      setState(() {

