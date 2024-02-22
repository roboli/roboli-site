import 'package:flutter/material.dart';
import 'package:roboli_site/helpers/constants.dart';
import 'package:roboli_site/pages/my_work_page/article_tile.dart';
import 'package:roboli_site/pages/my_work_page/book_tile.dart';
import 'package:roboli_site/pages/my_work_page/project_tile.dart';

class MyWorkPage extends StatelessWidget {
  const MyWorkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(width > screenWBreakpoint ? 50 : 20),
        child: Column(
          children: [
            Center(
              child: Text(
                'My Work',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: width > screenWBreakpoint ? 30 : 25,
                ),
              ),
            ),
            const SizedBox(height: 25,),
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: ListView(
                  children: [
                    Text(
                      'Books',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor
                      ),
                    ),
                    const SizedBox(height: 25,),
                    BookTile(
                      name: 'Junior PHP & JavaScript',
                      uri: Uri.https('a.co', 'd/5IlhmFZ'),
                    ),
                    const SizedBox(height: 50,),
                    Text(
                      'Projects',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor
                      ),
                    ),
                    const SizedBox(height: 25,),
                    ProjectTile(
                      name: 'pdf-2-images',
                      language: 'Clojure',
                      description: pdf2Images,
                      uri: Uri.https('github.com', 'roboli/pdf-2-images'),
                    ),
                    ProjectTile(
                      name: 'balloon',
                      language: 'Clojure',
                      description: balloon,
                      uri: Uri.https('github.com', 'roboli/balloon'),
                    ),
                    ProjectTile(
                      name: 'Clerk',
                      language: 'Clojure',
                      description: clerk,
                      uri: Uri.https('github.com', 'roboli/clerk'),
                    ),
                    const SizedBox(height: 50,),
                    Text(
                      'Articles',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor
                      ),
                    ),
                    const SizedBox(height: 25,),
                    ArticleTile(
                      name: 'Anécdotas sobre Programación (PHP, JS, Emacs, Clojure)',
                      uri: Uri.https('medium.com', '@roboli/anécdotas-sobre-programación-php-js-emacs-clojure-c639d9160749'),
                    ),
                    ArticleTile(
                      name: 'El Programador Políglota',
                      uri: Uri.https('medium.com', '@roboli/el-programador-políglota-1ed5066d449e'),
                    ),
                    ArticleTile(
                      name: 'Desarrollo Iterativo',
                      uri: Uri.https('medium.com', '@roboli/desarrollo-iterativo-4a47442b2586'),
                    ),
                    ArticleTile(
                      name: 'Entendiendo Programación Asíncrona con JavaScript y Node',
                      uri: Uri.https('medium.com', '@roboli/entendiendo-programación-asincronica-con-javascript-y-node-656bdc44b0e5'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
