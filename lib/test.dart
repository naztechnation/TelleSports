// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';


// send(){
//   return  Container(
//   decoration: BoxDecoration(
//     color: Color(0xFFFDF9ED),
//   ),
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.start,
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Container(
//         margin: EdgeInsets.fromLTRB(0, 0, 0, 17),
//         decoration: BoxDecoration(
//           color: Color(0xFFFFFFFF),
//           border: Border(
//             bottom: Border(
//               color: Color(0xFFC2C0C3),
//               width: 1,
//             ),
//           ),
//         ),
//         child: Container(
//           padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
//           child: 
//           Container(
//             decoration: BoxDecoration(
//               color: Color(0xFFFFFFFF),
//               border: Border(
//                 bottom: Border(
//                   color: Color(0xFFD6D5D7),
//                   width: 1,
//                 ),
//               ),
//             ),
//             child: Container(
//               width: double.infinity,
//               padding: EdgeInsets.fromLTRB(0, 4, 0, 3),
//               child: 
//               Container(
//                 decoration: BoxDecoration(
//                   color: Color(0xFFFFFFFF),
//                 ),
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: Container(
//                     padding: EdgeInsets.fromLTRB(24.4, 0, 30, 0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               margin: EdgeInsets.fromLTRB(0, 10.4, 16, 11.4),
//                               width: 15.6,
//                               height: 15.2,
//                               child: 
//                               SizedBox(
//                                 width: 15.6,
//                                 height: 15.2,
//                                 child: SvgPicture.network(
//                                   'assets/vectors/vector_762_x2.svg',
//                                 ),
//                               ),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   margin: EdgeInsets.fromLTRB(0, 0, 8, 1),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(18),
//                                       image: DecorationImage(
//                                         fit: BoxFit.cover,
//                                         image: NetworkImage(
//                                           'assets/images/avatar_2.png',
//                                         ),
//                                       ),
//                                     ),
//                                     child: Container(
//                                       width: 36,
//                                       height: 36,
//                                     ),
//                                   ),
//                                 ),
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       child: 
//                                       Text(
//                                         'Pixsellz Team ',
//                                         style: GoogleFonts.getFont(
//                                           'DM Sans',
//                                           fontWeight: FontWeight.w700,
//                                           fontSize: 16,
//                                           color: Color(0xFF1F1C21),
//                                         ),
//                                       ),
//                                     ),
//                                     Align(
//                                       alignment: Alignment.topLeft,
//                                       child: Text(
//                                         '1 member',
//                                         style: GoogleFonts.getFont(
//                                           'DM Sans',
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: 12,
//                                           color: Color(0xFFAEABAF),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         Container(
//                           margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
//                           width: 4,
//                           height: 16,
//                           child: 
//                           SizedBox(
//                             width: 4,
//                             height: 16,
//                             child: SvgPicture.network(
//                               'assets/vectors/vector_785_x2.svg',
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       Container(
//         margin: EdgeInsets.fromLTRB(20, 0, 20, 489),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Color(0xFF183A5C),
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 child: Container(
//                   padding: EdgeInsets.fromLTRB(18.4, 2, 18.4, 2),
//                   child: 
//                   Text(
//                     'Today',
//                     style: GoogleFonts.getFont(
//                       // 'DM Sans',
//                       fontWeight: FontWeight.w500,
//                       fontSize: 10,
//                       color: Color(0xFFFFFFFF),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Color(0xFF183A5C),
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 child: Container(
//                   padding: EdgeInsets.fromLTRB(18.5, 2, 18.5, 2),
//                   child: 
//                   Text(
//                     'You created this community',
//                     style: GoogleFonts.getFont(
//                       'DM Sans',
//                       fontWeight: FontWeight.w500,
//                       fontSize: 10,
//                       color: Color(0xFFFFFFFF),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Color(0xFFECF4FC),
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 child: Container(
//                   padding: EdgeInsets.fromLTRB(11.3, 8, 11.3, 8),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Container(
//                         margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
//                         child: Text(
//                           'Share your community so other users can find you and interact with your content! ',
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.getFont(
//                             'DM Sans',
//                             fontWeight: FontWeight.w500,
//                             fontSize: 10,
//                             color: Color(0xFF1F1C21),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         child: 
//                         Text(
//                           'tsportcommunity.com/hjidihewio46372',
//                           style: GoogleFonts.getFont(
//                             'DM Sans',
//                             fontWeight: FontWeight.w500,
//                             fontSize: 12,
//                             color: Color(0xFF3C91E5),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             ClipRect(
//               child: BackdropFilter(
//                 filter: ImageFilter.blur(
//                   sigmaX: 2,
//                   sigmaY: 2,
//                 ),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Color(0xFF3C91E5),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Container(
//                     padding: EdgeInsets.fromLTRB(0, 12, 0.4, 12),
//                     child: 
//                     Text(
//                       'Share community',
//                       style: GoogleFonts.getFont(
//                         'DM Sans',
//                         fontWeight: FontWeight.w500,
//                         fontSize: 14,
//                         color: Color(0xFFFFFFFF),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       Container(
//         decoration: BoxDecoration(
//           color: Color(0xFFFFFFFF),
//           border: Border(
//             top: BorderSize(
//               color: Color(0xFFC2C0C3),
//               width: 1,
//             ),
//           ),
//         ),
//         child: Container(
//           padding: EdgeInsets.fromLTRB(27, 9, 22.5, 36),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 margin: EdgeInsets.fromLTRB(0, 6, 18, 6),
//                 width: 11,
//                 height: 22,
//                 child: 
//                 SizedBox(
//                   width: 11,
//                   height: 22,
//                   child: SvgPicture.network(
//                     'assets/vectors/vector_1639_x2.svg',
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   margin: EdgeInsets.fromLTRB(0, 0, 14, 0),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Color(0xFFD6D5D7)),
//                     borderRadius: BorderRadius.circular(28),
//                     color: Color(0xFFF3F2F3),
//                   ),
//                   child: Container(
//                     padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
//                     child: 
//                     Text(
//                       'Type a message...',
//                       style: GoogleFonts.getFont(
//                         'DM Sans',
//                         fontWeight: FontWeight.w500,
//                         fontSize: 14,
//                         color: Color(0xFFAEABAF),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.fromLTRB(0, 8.5, 0, 8.5),
//                 width: 19.5,
//                 height: 17,
//                 child: 
//                 SizedBox(
//                   width: 19.5,
//                   height: 17,
//                   child: SvgPicture.network(
//                     'assets/vectors/vector_853_x2.svg',
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ],
//   ),
// );
// }