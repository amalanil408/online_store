import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_store/core/widgets/common_widget.dart';

class SubCategoryTileWidget extends StatelessWidget {
  final String image;
  final String title;
  const SubCategoryTileWidget({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.grey.shade200
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(image,fit: BoxFit.cover,),
          ),
        ),
        customSizedBox(heigh: 8),
        SizedBox(
          width: 110,
          child: Text(title,textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.roboto(
            fontSize: 12,
            fontWeight: FontWeight.w600,

          ),
          ),
        )
      ],
    );

  }
}