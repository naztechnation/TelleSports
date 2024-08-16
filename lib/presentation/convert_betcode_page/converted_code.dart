import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../model/auth_model/bookies_details.dart';


class ConvertedCodePage extends StatefulWidget {
  final BookiesDetails? bookie;

  final String destinationCode;

  final List<EventDetails>? bookingEventLists;

  final List<EventDetails>? notConvertedBookies;

  final notConvertedEvents;
  ConvertedCodePage(
      {required this.bookie,
      required this.destinationCode,
      required this.bookingEventLists,
      required this.notConvertedEvents, this.notConvertedBookies});

  @override
  State<ConvertedCodePage> createState() => _ConvertedCodePageState();
}

class _ConvertedCodePageState extends State<ConvertedCodePage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          
          title: Text('Converted Code',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.primary)),
          elevation: 1,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 180,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, right: 10, left: 10),
                  child: Container(
                    decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFE2E4E9)),
                            borderRadius: BorderRadius.circular(16),
                            color: const Color(0xFFF6F8FA),
                            boxShadow: const [
                              BoxShadow(
              color: Color(0x3DE4E5E7),
              offset: Offset(0, 1),
              blurRadius: 1,
                              ),
                            ],
                          ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                               '${ widget.bookie?.data?.bookingDetails?.eventCount.toString() ?? '' } events',
                                  
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .dividerColor)),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                  '${widget.bookie?.data?.bookingCode}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black)),
                              const SizedBox(
                                height: 10,
                              ),
                              // Text(
                              //     '{widget.bookie?.data?.data?.conversion?.dump?.home?.odds}',
                              //     style: const TextStyle(
                              //         fontSize: 18,
                              //         fontWeight: FontWeight.w500,
                              //         color: Colors.black)),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              Text(
                                  '${widget.bookie?.data?.bookingDetails?.name}'.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary)),
                             
                            ],
                          ),
                          CustomImageView(
                              imagePath: ImageConstant.imgSwapHoriz,
                              height: 30.adaptSize,
                              width: 30.adaptSize),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('${widget.bookie?.data?.failedGames?.failedCount} events',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .dividerColor)),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                  '${widget.bookie?.data?.destinationCode}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black)),
                             
                              // Text(
                              //     '{widget.bookie?.data?.data?.conversion?.dump?.destination?.odds}',
                              //     style: const TextStyle(
                              //         fontSize: 18,
                              //         fontWeight: FontWeight.w500,
                              //         color: Colors.black)),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                  '${widget.bookie?.data?.destinationDetails?.name}'.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary)),
                              const SizedBox(
                                height: 13,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left:10.0),
                child: Text(
                                          'Converted Bookies',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w900,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary)),
              ),
                                                const SizedBox(
                height: 2,
              ),
              ListView.builder(
                  itemCount: widget.bookingEventLists?.length,
                  shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, right: 10, left: 10),
                      child: Container(
                        decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE2E4E9)),
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xFFF6F8FA),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x3DE4E5E7),
                  offset: Offset(0, 1),
                  blurRadius: 1,
                ),
              ],
                            ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // (widget.bookingEventLists?[index]
                                //             .exemptReason ==
                                //         null)
                                //     ? Container()
                                //     : 
                                    // Text(
                                    //     'exemption reason: ${widget.bookingEventLists?[index].exemptReason ?? ''}.',
                                    //     style: TextStyle(
                                    //         fontSize: 14,
                                    //         fontWeight: FontWeight.w500,
                                    //         color: Theme.of(context)
                                    //             .colorScheme
                                    //             .primary)),
                                // (widget.bookingEventLists?[index]
                                //             .exemptReason ==
                                //         null)
                                //     ? Container()
                                //     : const SizedBox(height: 16),
                                // (widget.bookingEventLists?[index]
                                //             .exemptReason ==
                                //         null)
                                //     ? Container()
                                //     : const Divider(),
                                // (widget.bookingEventLists?[index]
                                //             .exemptReason ==
                                //         null)
                                //     ? Container()
                                //     : const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Text('${index + 1}.',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .dividerColor)),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                     Text(
                                        '${widget.bookie?.data?.destinationDetails?.name}'.toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w900,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary)),
                                    // (widget.bookingEventLists?[index]
                                    //             .isConverted ??
                                    //         false)
                                     //   ? 
                                      const Spacer(),
                                        Icon(
                                            Icons.check_circle,
                                            size: 28,
                                            color: Colors.green[900],
                                          ),
                                    //     : const CircleAvatar(
                                    //         radius: 16,
                                    //         backgroundColor: Colors.red,
                                    //         child: Icon(
                                    //           Icons.close_rounded,
                                    //           size: 27,
                                    //           color: Colors.white,
                                    //         ),
                                    //       ),
                                   
                                    // Text(
                                    //     AppUtils.formatSimpleDate(
                                    //         dateTime: widget
                                    //                 .bookingEventLists?[index]
                                    //                 .home
                                    //                 ?.itemUtcDate
                                    //                 .toString() ??
                                    //             ''),
                                    //     style: TextStyle(
                                    //         fontSize: 14,
                                    //         fontWeight: FontWeight.w500,
                                    //         color: Theme.of(context)
                                    //             .dividerColor)),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Divider(),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        // const ImageView.asset(
                                        //   AppImages.ball,
                                        //   height: 25,
                                        //   width: 25,
                                        // ),
                                       
                                        Text('Teams',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black)),
                                      ],
                                    ),
                                   
                                   
                                  ],
                                ),
                                 const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                        '${widget.bookingEventLists?[index].eventName}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary)),
                               
                                // Column(
                                //   crossAxisAlignment:
                                //       CrossAxisAlignment.start,
                                //   children: [
                                //     Text(
                                //         '{widget.bookingEventLists?[index].home?.homeTeam}',
                                //         style: const TextStyle(
                                //             fontSize: 18,
                                //             fontWeight: FontWeight.w500,
                                //             color: Colors.black)),
                                //     const SizedBox(
                                //       height: 8,
                                //     ),
                                //     Text(
                                //       '{widget.bookingEventLists?[index].home?.outcomeName}',
                                //       style: TextStyle(
                                //           fontSize: 14,
                                //           fontWeight: FontWeight.w500,
                                //           color:
                                //               Theme.of(context).dividerColor),
                                //     ),
                                //     const SizedBox(
                                //       height: 12,
                                //     ),
                                //   ],
                                // ),
                                
                                // Row(
                                //   children: [
                                //     // const ImageView.asset(
                                //     //   AppImages.ball,
                                //     //   height: 25,
                                //     //   width: 25,
                                //     // ),
                                //     const SizedBox(
                                //       width: 6,
                                //     ),
                                //     Text('Away Team',
                                //         style: TextStyle(
                                //             fontSize: 16,
                                //             fontWeight: FontWeight.w700,
                                //             color: Theme.of(context)
                                //                 .colorScheme
                                //                 .primary)),
                                //     const Spacer(),
                                //     Text(
                                //         '{widget.bookie?.data?.data?.conversion?.dump?.destination?.bookie}',
                                //         style: TextStyle(
                                //             fontSize: 16,
                                //             fontWeight: FontWeight.w900,
                                //             color: Theme.of(context)
                                //                 .colorScheme
                                //                 .primary)),
                                //   ],
                                // ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                     
                                    Text(
                                        'Odd Value: ${widget.bookingEventLists?[index].marketName} ',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context)
                                                .dividerColor)),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                // const Divider(),
                                // const SizedBox(
                                //   height: 8,
                                // ),
                                // Text(
                                //     'Odd Value: {widget.bookingEventLists?[index].home?.oddValue} ',
                                //     style: TextStyle(
                                //         fontSize: 16,
                                //         fontWeight: FontWeight.w500,
                                //         color:
                                //             Theme.of(context).dividerColor)),
                                // const SizedBox(
                                //   height: 8,
                                // ),
                                // Text(
                                //     'Sports: {widget.bookingEventLists?[index].home?.sportId} ',
                                //     style: TextStyle(
                                //         fontSize: 16,
                                //         fontWeight: FontWeight.w500,
                                //         color:
                                //             Theme.of(context).dividerColor)),
                                // const SizedBox(
                                //   height: 8,
                                // ),
                                // Text(
                                //     'Tournament Name: {widget.bookingEventLists?[index].home?.tournamentName} ',
                                //     style: TextStyle(
                                //         fontSize: 16,
                                //         fontWeight: FontWeight.w500,
                                //         color:
                                //             Theme.of(context).dividerColor)),
                                // const SizedBox(
                                //   height: 8,
                                // ),
                              ]),
                        ),
                      ),
                    );
                  })),
             
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left:10.0),
                child: Text(
                                          'Failed Bookies',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.red)),
              ),
                                                const SizedBox(
                height: 2,
              ),
              ListView.builder(
                  itemCount: widget.notConvertedBookies?.length,
                  shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, right: 10, left: 10),
                      child: Container(
                        decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE2E4E9)),
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xFFF6F8FA),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x3DE4E5E7),
                  offset: Offset(0, 1),
                  blurRadius: 1,
                ),
              ],
                            ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // (widget.bookingEventLists?[index]
                                //             .exemptReason ==
                                //         null)
                                //     ? Container()
                                //     : 
                                    // Text(
                                    //     'exemption reason: ${widget.bookingEventLists?[index].exemptReason ?? ''}.',
                                    //     style: TextStyle(
                                    //         fontSize: 14,
                                    //         fontWeight: FontWeight.w500,
                                    //         color: Theme.of(context)
                                    //             .colorScheme
                                    //             .primary)),
                                // (widget.bookingEventLists?[index]
                                //             .exemptReason ==
                                //         null)
                                //     ? Container()
                                //     : const SizedBox(height: 16),
                                // (widget.bookingEventLists?[index]
                                //             .exemptReason ==
                                //         null)
                                //     ? Container()
                                //     : const Divider(),
                                // (widget.bookingEventLists?[index]
                                //             .exemptReason ==
                                //         null)
                                //     ? Container()
                                //     : const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Text('${index + 1}.',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .dividerColor)),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                     Text(
                                        '${widget.bookie?.data?.destinationDetails?.name}'.toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w900,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary)),
                                    // (widget.bookingEventLists?[index]
                                    //             .isConverted ??
                                    //         false)
                                     //   ? 
                                      const Spacer(),
                                        // Icon(
                                        //     Icons.check_circle,
                                        //     size: 35,
                                        //     color: Colors.green[900],
                                        //   ),
                                    //     :
                                    const CircleAvatar(
                                            radius: 12,
                                            backgroundColor: Colors.red,
                                            child: Icon(
                                              Icons.close_rounded,
                                              size: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                   
                                    // Text(
                                    //     AppUtils.formatSimpleDate(
                                    //         dateTime: widget
                                    //                 .bookingEventLists?[index]
                                    //                 .home
                                    //                 ?.itemUtcDate
                                    //                 .toString() ??
                                    //             ''),
                                    //     style: TextStyle(
                                    //         fontSize: 14,
                                    //         fontWeight: FontWeight.w500,
                                    //         color: Theme.of(context)
                                    //             .dividerColor)),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Divider(),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        // const ImageView.asset(
                                        //   AppImages.ball,
                                        //   height: 25,
                                        //   width: 25,
                                        // ),
                                       
                                        Text('Teams',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black)),
                                      ],
                                    ),
                                   
                                   
                                  ],
                                ),
                                 const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                        '${widget.notConvertedBookies?[index].eventName}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary)),
                               
                                // Column(
                                //   crossAxisAlignment:
                                //       CrossAxisAlignment.start,
                                //   children: [
                                //     Text(
                                //         '{widget.bookingEventLists?[index].home?.homeTeam}',
                                //         style: const TextStyle(
                                //             fontSize: 18,
                                //             fontWeight: FontWeight.w500,
                                //             color: Colors.black)),
                                //     const SizedBox(
                                //       height: 8,
                                //     ),
                                //     Text(
                                //       '{widget.bookingEventLists?[index].home?.outcomeName}',
                                //       style: TextStyle(
                                //           fontSize: 14,
                                //           fontWeight: FontWeight.w500,
                                //           color:
                                //               Theme.of(context).dividerColor),
                                //     ),
                                //     const SizedBox(
                                //       height: 12,
                                //     ),
                                //   ],
                                // ),
                                
                                // Row(
                                //   children: [
                                //     // const ImageView.asset(
                                //     //   AppImages.ball,
                                //     //   height: 25,
                                //     //   width: 25,
                                //     // ),
                                //     const SizedBox(
                                //       width: 6,
                                //     ),
                                //     Text('Away Team',
                                //         style: TextStyle(
                                //             fontSize: 16,
                                //             fontWeight: FontWeight.w700,
                                //             color: Theme.of(context)
                                //                 .colorScheme
                                //                 .primary)),
                                //     const Spacer(),
                                //     Text(
                                //         '{widget.bookie?.data?.data?.conversion?.dump?.destination?.bookie}',
                                //         style: TextStyle(
                                //             fontSize: 16,
                                //             fontWeight: FontWeight.w900,
                                //             color: Theme.of(context)
                                //                 .colorScheme
                                //                 .primary)),
                                //   ],
                                // ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                     
                                    Text(
                                        'Odd Value: ${widget.notConvertedBookies?[index].marketName} ',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context)
                                                .dividerColor)),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                // const Divider(),
                                // const SizedBox(
                                //   height: 8,
                                // ),
                                // Text(
                                //     'Odd Value: {widget.bookingEventLists?[index].home?.oddValue} ',
                                //     style: TextStyle(
                                //         fontSize: 16,
                                //         fontWeight: FontWeight.w500,
                                //         color:
                                //             Theme.of(context).dividerColor)),
                                // const SizedBox(
                                //   height: 8,
                                // ),
                                // Text(
                                //     'Sports: {widget.bookingEventLists?[index].home?.sportId} ',
                                //     style: TextStyle(
                                //         fontSize: 16,
                                //         fontWeight: FontWeight.w500,
                                //         color:
                                //             Theme.of(context).dividerColor)),
                                // const SizedBox(
                                //   height: 8,
                                // ),
                                // Text(
                                //     'Tournament Name: {widget.bookingEventLists?[index].home?.tournamentName} ',
                                //     style: TextStyle(
                                //         fontSize: 16,
                                //         fontWeight: FontWeight.w500,
                                //         color:
                                //             Theme.of(context).dividerColor)),
                                // const SizedBox(
                                //   height: 8,
                                // ),
                              ]),
                        ),
                      ),
                    );
                  })),
            ],
          ),
        ));
  }
}

//   loadErrorPage() {
//     return Padding(
//       padding: const EdgeInsets.all(14.0),
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             SelectableText(
//               """
//                       Conversion Error
          
// This may have occurred due to one of the following reasons bellow.
          
// 1. We convert only football/soccer games. Please ensure your code only has football games.
          
// 2. At least one or more active games must be included in your ticket in order for the conversion to pull through.
          
// 3. Make sure you have units, if you do not, check any of our available subscription packages.
          
// 4. Make sure you have a good network connection.
          
// 5.Check our FAQ section for more details. 
          
// 6. Contact us via (Live chat on the web, or email betslipswitch@gmail.com.
//           """,
//               style: TextStyle(
//                   color: Theme.of(context).colorScheme.secondary, fontSize: 18),
//             ),
//             ButtonView(
//               color: AppColors.red,
//               expanded: false,
//               onPressed: (() {
//                 AppNavigator.pushAndReplacePage(context,
//                     page: Dashboard(
//                       email: email,
//                       password: password,
//                       startSeason: '',
//                       endSeason: '',
//                       leagueId: '',
//                       teamId: teamId,
//                     ));
//               }),
//               child: const Text(
//                 'Close',
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

