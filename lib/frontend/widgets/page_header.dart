

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageHeaderWidget extends StatelessWidget {
  const PageHeaderWidget({
    Key? key,
    required this.title,
    this.subtitle
  }) : super(key: key);

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "page_header",
      child: Material(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: GoogleFonts.montserrat(
              fontSize: 24, fontWeight: FontWeight.w700,
            ), textAlign: TextAlign.center,),

            if (subtitle != null)
              ...[
                const SizedBox(height: 5,),
                Text(subtitle!, textAlign: TextAlign.center, style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w200
                ),),
              ],

          ],
        ),
      ),
    );
  }
}
