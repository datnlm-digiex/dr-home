import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'icons.dart';
import 'svg_asset.dart';

// class DiscoverCard extends StatelessWidget {
//   final String? title;
//   final String? subtitle;
//   final Color? gradientStartColor;
//   final Color? gradientEndColor;
//   final double? height;
//   final double? width;
//   final Widget? vectorBottom;
//   final Widget? vectorTop;
//   final Function? onTap;
//   final String? tag;
//   const DiscoverCard(
//       {Key? key,
//       this.title,
//       this.subtitle,
//       this.gradientStartColor,
//       this.gradientEndColor,
//       this.height,
//       this.width,
//       this.vectorBottom,
//       this.vectorTop,
//       this.onTap,
//       this.tag})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: () => onTap!(),
//         borderRadius: BorderRadius.circular(26),
//         child: Ink(
//           height: 240,
//           width: 340,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(26),
//             image: DecorationImage(
//               fit: BoxFit.cover,
//               image: AssetImage("assets/images/background1.png"),
//             ),
//           ),
//           child: Padding(
//             padding: EdgeInsets.only(left: 24, top: 24, bottom: 24),
//             child: Container(
//               height: 176,
//               width: 305,
//               child: Stack(
//                 children: [
//                   vectorBottom ??
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(26),
//                         child: SvgAsset(
//                             height: 176,
//                             width: 305,
//                             assetName: AssetName.vectorBottom),
//                       ),
//                   vectorTop ??
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(26),
//                         child: SvgAsset(
//                             height: 176,
//                             width: 305,
//                             assetName: AssetName.vectorTop),
//                       ),
//                   Padding(
//                     padding: EdgeInsets.only(left: 24, top: 24, bottom: 24),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Hero(
//                               tag: tag ?? '',
//                               child: Material(
//                                 color: Colors.transparent,
//                                 child: Text(
//                                   title!,
//                                   style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             subtitle != null
//                                 ? SizedBox(
//                                   width: 260,
//                                     child: Flexible(
//                                       child: Text(
//                                         subtitle!,
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w300,
//                                             color: Colors.white),
//                                       ),
//                                     ),
//                                   )
//                                 : Container(),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiscoverCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Color? gradientStartColor;
  final Color? gradientEndColor;
  final double? height;
  final double? width;
  final Widget? vectorBottom;
  final Widget? vectorTop;
  final Function? onTap;
  final String? tag;
  const DiscoverCard(
      {Key? key,
      this.title,
      this.subtitle,
      this.gradientStartColor,
      this.gradientEndColor,
      this.height,
      this.width,
      this.vectorBottom,
      this.vectorTop,
      this.onTap,
      this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onTap!(),
        borderRadius: BorderRadius.circular(26),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            gradient: LinearGradient(
              colors: [
                gradientStartColor ?? Color(0xff441DFC),
                gradientEndColor ?? Color(0xff4E81EB),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Container(
            height: 176,
            width: 305,
            child: Stack(
              children: [
                vectorBottom ??
                    ClipRRect(
                      borderRadius: BorderRadius.circular(26),
                      child: SvgAsset(
                          height: 176,
                          width: 305,
                          assetName: AssetName.vectorBottom),
                    ),
                vectorTop ??
                    ClipRRect(
                      borderRadius: BorderRadius.circular(26),
                      child: SvgAsset(
                          height: 176,
                          width: 305,
                          assetName: AssetName.vectorTop),
                    ),
                Padding(
                  padding: EdgeInsets.only(left: 24, top: 24, bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: tag ?? '',
                            child: Material(
                              color: Colors.transparent,
                              child: Text(
                                title!,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          subtitle != null
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 18.0),
                                  child: Text(
                                    subtitle!,
                                    maxLines: 5,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
