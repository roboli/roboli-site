import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _commentController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const Center(
              child: Text(
                'Contact Me',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 100,),
                constraints: const BoxConstraints(
                  minWidth: 500,
                  maxWidth: 1000,
                ),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      vertical: 32,
                      horizontal: 16,
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        child: TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            label: Text('Name'),
                            border: OutlineInputBorder(),
                          ),
                          textInputAction: TextInputAction.next,
                          validator: (value) => (value?.isEmpty ?? true)
                              ? 'Name is required'
                              : null,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        child: TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              label: Text('Email'),
                              border: OutlineInputBorder(),
                            ),
                            validator: _handleEmailValidation),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        child: SizedBox(
                          height: 100,
                          child: TextFormField(
                            maxLines: null,
                            expands: true,
                            keyboardType: TextInputType.multiline,
                            controller: _commentController,
                            decoration: const InputDecoration(
                              label: Text('Comment'),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) => (value?.isEmpty ?? true)
                                ? 'Comment is required'
                                : null,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            ScaffoldFeatureController? scaffoldController;

                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              final response = await http.post(
                                Uri.parse('https://formspree.io/f/xayrojka'),
                                headers: <String, String>{
                                  'Content-Type':
                                      'application/json; charset=UTF-8',
                                },
                                body: jsonEncode(<String, String>{
                                  'name': _nameController.text,
                                  'email': _emailController.text,
                                  'comment': _commentController.text,
                                }),
                              );

                              await Future.delayed(const Duration(seconds: 1));
                              if (!context.mounted) return;

                              if (response.statusCode == 200) {
                                scaffoldController =
                                    ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Thank you for your message!'),
                                  ),
                                );

                                _formKey.currentState!.reset();
                              } else {
                                scaffoldController =
                                    ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Hmmm, something went wrong...'),
                                  ),
                                );
                              }

                              await scaffoldController.closed;
                              _formKey.currentState!.reset();
                            }
                          },
                          child: const Text('Send'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final RegExp _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9\-\_]+(\.[a-zA-Z]+)*$");

  String? _handleEmailValidation(String? value) {
    final isMissing = value?.isEmpty ?? true;

    if (isMissing || !_emailRegExp.hasMatch(value!)) {
      return 'Please provide a valid email address';
    }

    return null;
  }
}
