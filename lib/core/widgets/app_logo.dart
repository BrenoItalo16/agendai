// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    Key? key,
    this.vertical = false,
    this.horizontal = false,
    this.black = false,
  }) : super(key: key);

  final bool? vertical;
  final bool? horizontal;
  final bool? black;

  @override
  Widget build(BuildContext context) {
    if (black!) {
      if (horizontal!) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/brand/logo.svg'),
            const SizedBox(
              width: 10,
            ),
            SvgPicture.asset('assets/brand/white_agendai.svg'),
          ],
        );
      } else if (vertical!) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/brand/logo.svg'),
            const SizedBox(
              height: 10,
            ),
            SvgPicture.asset('assets/brand/white_agendai.svg'),
          ],
        );
      } else {
        return SvgPicture.asset('assets/brand/logo.svg');
      }
    } else {
      if (horizontal!) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/brand/logo.svg'),
            const SizedBox(
              width: 10,
            ),
            SvgPicture.asset('assets/brand/black_agendai.svg'),
          ],
        );
      } else if (vertical!) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/brand/logo.svg'),
            const SizedBox(
              height: 10,
            ),
            SvgPicture.asset('assets/brand/black_agendai.svg'),
          ],
        );
      } else {
        return SvgPicture.asset('assets/brand/logo.svg');
      }
    }
  }
}
