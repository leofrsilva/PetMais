import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petmais/app/shared/models/pet/pet_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';

class ImageMeuPet extends StatelessWidget {
  final PetModel petModel;
  final double size;
  final Function onTap;

  ImageMeuPet({
    this.petModel,
    this.size,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: this.onTap,
          child: ClipRRect(
        child: Container(
          width: this.size,
          height: this.size,
          decoration: BoxDecoration(
            color: DefaultColors.others.withOpacity(0.3),
            image: DecorationImage(
              image: NetworkImage(this.petModel.petImages.imgPrincipal),
              fit: BoxFit.cover,
            ),
          ),
          child: this.petModel.estado == 1
              ? Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: CircleAvatar(
                    radius: 12.5,
                    backgroundColor: DefaultColors.secondary,
                    child: Icon(FontAwesomeIcons.paw, color: Colors.white, size: 15),
                  ),
                )
              : Container(
                ),
        ),
      ),
    );
  }
}
