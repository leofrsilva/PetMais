import 'package:flutter/material.dart';
import 'package:petmais/app/shared/utils/colors.dart';
// import 'colors.dart';

final kHintTextStyle = TextStyle(
  color: Colors.black26,
  fontFamily: 'Changa',
);

final kLabelStyle = TextStyle(
  color: DefaultColors.secondary,
  fontFamily: 'Changa',
  fontSize: 15,
);

final kLabelSmoothStyle = TextStyle(
  color: DefaultColors.secondarySmooth,
  fontFamily: 'Changa',
  fontSize: 15,
);

final kLabelTitleStyle = TextStyle(
  color: DefaultColors.secondary,
  fontFamily: 'OpenSans', //GoogleFonts.montserrat().fontFamily,
  fontWeight: FontWeight.w500,
  fontSize: 18,
);

final kLabelTitleSmoothStyle = TextStyle(
  color: DefaultColors.secondarySmooth,
  fontFamily: 'OpenSans', //GoogleFonts.montserrat().fontFamily,
  fontWeight: FontWeight.w500,
  fontSize: 20,
);

final kLabelTitleAppBarStyle = TextStyle(
  color: Colors.white,
  fontSize: 24,
  fontFamily: "Roboto",
  letterSpacing: 0,
  wordSpacing: 0,
  // fontFamily: 'OpenSans', //GoogleFonts.montserrat().fontFamily,
  // fontWeight: FontWeight.w500,
);

final kLabelTitleAuxStyle = TextStyle(
  color: Colors.white,
  fontSize: 24,
  fontFamily: 'OpenSans', //GoogleFonts.montserrat().fontFamily,
  fontWeight: FontWeight.w500,
  letterSpacing: 0,
  wordSpacing: 0,
);

final TextStyle kLabelSubTitleStyle = TextStyle(
  color: Colors.white.withOpacity(0.75),
  fontSize: 14,
  fontFamily: "Changa",
);

final kLabelTabStyle = TextStyle(
  color: DefaultColors.secondarySmooth,
  fontSize: 18,
  fontFamily: "RussoOne",
);

final kDescriptionStyle = TextStyle(
  color: DefaultColors.background,
  fontSize: 13,
  fontFamily: "Changa",
);

final kDescriptionBigStyle = TextStyle(
  color: DefaultColors.background,
  fontSize: 16,
  fontFamily: "Changa",
);

// -
final TextStyle kItemSelected = TextStyle(
  color: DefaultColors.primary,
  fontSize: 18,
  fontFamily: "Changa",
);

final TextStyle kItemNoSelected = TextStyle(
  color: DefaultColors.backgroundSmooth,
  fontSize: 16,
  fontFamily: "Changa",
);

final TextStyle kFlatButtonStyle = TextStyle(
  color: DefaultColors.primary,
  fontSize: 14,
  fontFamily: "RussoOne",
);

final TextStyle kButtonStyle = TextStyle(
  color: DefaultColors.surface,
  fontSize: 20,
  fontFamily: "RussoOne",
);

BoxDecoration get kDecorationContainerGradient {
  return BoxDecoration(    
    borderRadius: BorderRadius.circular(30),
    gradient: LinearGradient(
      colors: [
          DefaultColors.secondary,
          DefaultColors.primaryIntense,
        ],
        begin: AlignmentDirectional.topStart,
        end: AlignmentDirectional.bottomEnd,
        stops: [
          0.3,
          0.9,
        ],
    )
  );
}

// BoxDecoration get kDecorationContainerGradientAlt {
//   return BoxDecoration(
//     borderRadius: BorderRadius.circular(30),
//     gradient: LinearGradient(
//         colors: [
//           DefaultColors.secondary,
//           DefaultColors.background,
//         ],
//         begin: AlignmentDirectional.topStart,
//         end: AlignmentDirectional.bottomEnd,
//         stops: [
//           0.3,
//           0.9,
//         ]),
//   );
// }

BoxDecoration get kDecorationContainer {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    color: DefaultColors.secondary,
  );
}

BoxDecoration get kDecorationContainerAux {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    color: DefaultColors.tertiary,
  );
}

BoxDecoration get kDecorationContainerBorder {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    border: Border.all(
      color: DefaultColors.secondary,
      width: 3,
    ),
  );
}
