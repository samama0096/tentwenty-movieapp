import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movietestapp/interface/utils/constants/fixed_constants.dart';
import 'package:movietestapp/interface/utils/constants/paddings.dart';

Widget simpleShimmerLoading(Size s) => Padding(
      padding: AppPaddings.horizontalSymmetricPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          fixedVerticalSpace(10),
          Lottie.asset('lib/assets/lotties/loading-anim.json', height: 50),
          fixedVerticalSpace(10),
          Center(
            child: SizedBox(
                width: s.width * 0.85, child: const LinearProgressIndicator()),
          ),
          fixedVerticalSpace(20),
          Container(
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(largelBorderRadius),
                color: Colors.blueGrey.shade100),
          ),
          fixedVerticalSpace(10),
          Container(
            height: 30,
            width: s.width * 0.85,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(largelBorderRadius),
                color: Colors.blueGrey.shade50),
          ),
          fixedVerticalSpace(20),
          Container(
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(largelBorderRadius),
                color: Colors.blueGrey.shade100),
          ),
          fixedVerticalSpace(10),
          Container(
            height: 30,
            width: s.width * 0.85,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(largelBorderRadius),
                color: Colors.blueGrey.shade50),
          ),
          fixedVerticalSpace(20),
          Container(
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(largelBorderRadius),
                color: Colors.blueGrey.shade100),
          ),
          fixedVerticalSpace(10),
          Container(
            height: 30,
            width: s.width * 0.85,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(largelBorderRadius),
                color: Colors.blueGrey.shade50),
          ),
        ],
      ),
    );
