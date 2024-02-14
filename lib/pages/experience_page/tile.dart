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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      child: SizedBox(
        height: 200,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
              child: logo
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    role,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                  Expanded(
                    child: Text(description),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
