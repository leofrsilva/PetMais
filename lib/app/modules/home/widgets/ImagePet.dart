import 'package:flutter/material.dart';
import 'package:petmais/app/shared/models/pet/pet_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';

class ImagePet extends StatelessWidget {
  final PetModel petModel;
  final String urlImage;
  final Function onTap;
  final double size;

  ImagePet({
    this.size = 175,
    this.petModel,
    this.urlImage,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onTap,
      child: Container(
        width: this.size,
        height: this.size,
        decoration: BoxDecoration(
          color: DefaultColors.others.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
                    child: Image.network(
            petModel?.petImages?.imgPrincipal ?? this.urlImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
