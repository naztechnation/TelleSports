import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../model/auth_model/bookies_details.dart';
import '../../utils/app_utils.dart';

class ConvertedCodePage extends StatefulWidget {
  final BookiesDetails? bookie;

  final String destinationCode;

  final List<ListElement>? bookingEventLists;

  List<ListElement>? notConvertedBookies;

  final notConvertedEvents;
  ConvertedCodePage(
      {required this.bookie,
      required this.destinationCode,
      required this.bookingEventLists,
      required this.notConvertedEvents});

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
      appBar: AppBar(
        centerTitle: true,
        title: Text('Converted Code',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Theme.of(context)
                                                      .colorScheme
                                                      .primary)),
        elevation: 0,
      ),
      body: 

             SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 228,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, right: 10, left: 10),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            '${widget.bookingEventLists?.length} events',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .dividerColor)),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                            '${widget.bookie?.data?.data?.conversion?.bookingCode}',
                                            style: const TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black)),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            '${widget.bookie?.data?.data?.conversion?.dump?.home?.odds}',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black)),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            '${widget.bookie?.data?.data?.conversion?.dump?.home?.bookie}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w900,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary)),
                                        const SizedBox(
                                          height: 13,
                                        ),
                                       
                                      ],
                                    ),
                                    CustomImageView(
                imagePath: ImageConstant.imgSwapHoriz,
                height: 30.adaptSize,
                width: 30.adaptSize),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text('${widget.notConvertedEvents} events',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .dividerColor)),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                            '${widget.bookie?.data?.data?.conversion?.destinationCode}',
                                            style: const TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black)),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            '${widget.bookie?.data?.data?.conversion?.dump?.destination?.odds}',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black)),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            '${widget.bookie?.data?.data?.conversion?.dump?.destination?.bookie}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w900,
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
                      ],
                    ),
                    ListView.builder(
                        itemCount: widget.bookingEventLists?.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, right: 10, left: 10),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      (widget.bookingEventLists?[index]
                                                  .exemptReason ==
                                              null)
                                          ? Container()
                                          : Text(
                                              'exemption reason: ${widget.bookingEventLists?[index].exemptReason ?? ''}.',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.w500,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary)),
                                      (widget.bookingEventLists?[index]
                                                  .exemptReason ==
                                              null)
                                          ? Container()
                                          : const SizedBox(height: 16),
                                      (widget.bookingEventLists?[index]
                                                  .exemptReason ==
                                              null)
                                          ? Container()
                                          : const Divider(),
                                      (widget.bookingEventLists?[index]
                                                  .exemptReason ==
                                              null)
                                          ? Container()
                                          : const SizedBox(height: 16),
                                      Row(
                                        children: [
                                          Text('${index + 1}.',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight:
                                                      FontWeight.w500,
                                                  color: Theme.of(context)
                                                      .dividerColor)),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          (widget.bookingEventLists?[index]
                                                      .isConverted ??
                                                  false)
                                              ? Icon(
                                                  Icons.check_circle,
                                                  size: 35,
                                                  color: Colors.green[900],
                                                )
                                              : const CircleAvatar(
                                                  radius: 16,
                                                  backgroundColor:
                                                      Colors.red,
                                                  child: Icon(
                                                    Icons.close_rounded,
                                                    size: 27,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                          const Spacer(),
                                          Text(
                                              AppUtils.formatSimpleDate(
                                                  dateTime:
                                                      widget.bookingEventLists?[
                                                              index]
                                                          .home
                                                          ?.itemDate
                                                          .toString() ?? ''),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.w500,
                                                  color: Theme.of(context)
                                                      .dividerColor)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Divider(),
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
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              Text('Home Team',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color:
                                                          Theme.of(context)
                                                      .colorScheme
                                                      .primary)),
                                            ],
                                          ),
                                          const Spacer(),
                                          Text(
                                              '${widget.bookie?.data?.data?.conversion?.dump?.home?.bookie}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight:
                                                      FontWeight.w900,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              '${widget.bookingEventLists?[index].home?.homeTeam}',
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight:
                                                      FontWeight.w500,
                                                  color: Colors.black)),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            '${widget.bookingEventLists?[index].home?.outcomeName}',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .dividerColor),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                        ],
                                      ),
                                      const Divider(),
                                      Row(
                                        children: [
                                          // const ImageView.asset(
                                          //   AppImages.ball,
                                          //   height: 25,
                                          //   width: 25,
                                          // ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Text('Away Team',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight:
                                                      FontWeight.w700,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary)),
                                          const Spacer(),
                                          Text(
                                              '${widget.bookie?.data?.data?.conversion?.dump?.destination?.bookie}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight:
                                                      FontWeight.w900,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              '${widget.bookingEventLists?[index].home?.awayTeam}',
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight:
                                                      FontWeight.w500,
                                                  color: Colors.black)),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                              '${widget.bookingEventLists?[index].home?.outcomeName} ',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.w500,
                                                  color: Theme.of(context)
                                                      .dividerColor)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      const Divider(),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                          'Odd Value: ${widget.bookingEventLists?[index].home?.oddValue} ',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Theme.of(context)
                                                  .dividerColor)),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                          'Sports: ${widget.bookingEventLists?[index].home?.sportId} ',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Theme.of(context)
                                                  .dividerColor)),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                          'Tournament Name: ${widget.bookingEventLists?[index].home?.tournamentName} ',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Theme.of(context)
                                                  .dividerColor)),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                    ]),
                              ),
                            ),
                          );
                        })),
                  ],
                ),
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

