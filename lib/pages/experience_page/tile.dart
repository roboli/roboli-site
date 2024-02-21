import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final String role;
  final String client;
  final String dateRange;
  final String location;
  final String description;
  final Widget logo;

  const Tile(
      {super.key,
      required this.role,
      required this.client,
      required this.dateRange,
      required this.location,
      required this.description,
      required this.logo
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        logo,
        const SizedBox(width: 20,),
        Flexible(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                role,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                client,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 15),
              ),
              Text(
                dateRange,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Text(
                location,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(description,),
            ],
          ),
        ),
      ],
    );
  }
}
