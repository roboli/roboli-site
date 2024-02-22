import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:roboli_site/helpers/constants.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  bool _isInAsync = false;

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
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Text(
                'Contact Me',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: width > screenWBreakpoint ? 30 : 25,
                ),
              ),
            ),
            const SizedBox(height: 25,),
            const Text(
              contact,
              style: TextStyle(
                  fontSize: 15,
                ),
            ),
            Expanded(
              child: Container(
                constraints: const BoxConstraints(
                  minWidth: 500,
                  maxWidth: 800,
                ),
                child: Form(
                  child: Builder(
                    builder: (context) {
                      return ListView(
                        padding: const EdgeInsets.symmetric(
                          vertical: 32,
                        ),
                        children: [
                          TextFormField(
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
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                label: Text('Email'),
                                border: OutlineInputBorder(),
                              ),
                              validator: _handleEmailValidation),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
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
                          const SizedBox(
                            height: 16,
                          ),
                          ElevatedButton.icon(
                            onPressed: () async {
                              ScaffoldFeatureController? scaffoldController;
                          
                              if (Form.of(context).validate()) {
                                setState(() {
                                  _isInAsync = true;
                                });
                          
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
                          
                                setState(() {
                                  _isInAsync = false;
                                });
                          
                                if (response.statusCode == 200) {
                                  scaffoldController =
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Thank you for your message!'),
                                      ),
                                    );
                          
                                    // Reset manually, form won't reset
                                    _nameController.text = '';
                                    _emailController.text = '';
                                    _commentController.text = '';
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
                              }
                            },
                            icon: _isInAsync
                                ? Container(
                                    width: 24,
                                    height: 24,
                                    padding: const EdgeInsets.all(2.0),
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 3,
                                    ),
                                  )
                                : const Icon(Icons.send),
                            label: const Text('Send'),
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () => launchUrl(Uri.https('www.linkedin.com', '/in/roboli')),
                                child: const Icon(
                                  FontAwesomeIcons.linkedin,
                                  color: Colors.blue,
                                ),
                              ),
                              InkWell(
                                onTap: () => launchUrl(Uri.https('github.com', '/roboli')),
                                child: const Icon(
                                  FontAwesomeIcons.github,
                                  color: Colors.white,
                                ),
                              ),
                              InkWell(
                                onTap: () => launchUrl(Uri.https('stackoverflow.com', '/users/2202143/roboli')),
                                child: const Icon(
                                  FontAwesomeIcons.stackOverflow,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
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
