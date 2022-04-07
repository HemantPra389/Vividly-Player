import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:path/path.dart';

import '../constants.dart';

PreferredSize AppBarNeuMusic(BuildContext context) {
  return PreferredSize(
    child: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                margin: EdgeInsets.only(left: 10, right: 25),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: kPrimaryBlack,
                    ))),
            Row(
              children: [
                NeumorphicButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.favorite,
                    color: kPrimaryPink,
                    size: 15,
                  ),
                  style: const NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.circle(),
                      depth: -5,
                      color: kPrimaryWhite),
                ),
                NeumorphicButton(
                  onPressed: () {},
                  child: const Icon(
                    Icons.share,
                    color: kPrimaryGrey,
                    size: 15,
                  ),
                  style: const NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.circle(),
                      shape: NeumorphicShape.flat,
                      color: kPrimaryWhite),
                ),
                NeumorphicButton(
                  onPressed: () {},
                  child: const Icon(
                    Icons.more_vert,
                    color: kPrimaryGrey,
                    size: 15,
                  ),
                  style: const NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.circle(),
                      shape: NeumorphicShape.flat,
                      color: kPrimaryWhite),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    preferredSize: Size.fromHeight(70),
  );
}
