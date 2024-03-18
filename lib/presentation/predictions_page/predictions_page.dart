import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/core/constants/enums.dart';

import '../../blocs/prediction/prediction.dart';
import '../../model/prediction_data/predicted_match_list.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/prediction_repo/predict_repository_impl.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/loading_page.dart';
import '../../widgets/modals.dart';
import 'widgets/prediction_container.dart';
import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';

class PredictionsPage extends StatelessWidget {
  const PredictionsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PredictionCubit>(
      create: (BuildContext context) => PredictionCubit(
          predictRepository: PredictRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: Predictions(),
    );
  }
}

class Predictions extends StatefulWidget {
  const Predictions({Key? key}) : super(key: key);

  @override
  State<Predictions> createState() => _PredictionsState();
}

class _PredictionsState extends State<Predictions> {
  int _selectedDay = DateTime.now().day;

  final _scrollController = ScrollController();

  int day = 0;
  late PredictionCubit _predictionCubit;

  List<PredictMatchListData> predictedMatch = [];

  getPredictions() async {
    _predictionCubit = context.read<PredictionCubit>();
    day = _selectedDay;

    _predictionCubit.getPrediction(day: day.toString());
  }

  @override
  void initState() {
    getPredictions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    final DateTime now = DateTime.now();
    final int currentDay = now.day;
    final int daysInMonth = DateTime(now.year, now.month + 1, 0).day;

    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: BlocConsumer<PredictionCubit, PredictStates>(
                listener: (context, state) {
              if (state is PredictListLoaded) {
                if (state.predict.success ?? false) {
                predictedMatch.clear();

                  predictedMatch = state.predict.data ?? [];
                  setState(() {});
                } else {}
              }else if(state is  RatingPredictLoaded){
                if (state.predict.success ?? false) {
    _predictionCubit.getPrediction(day: day.toString());

                   Modals.showToast('Rating submitted successfully', messageType: MessageType.success);
                }else{
                  Modals.showToast('Rating not  submitted');
                }
               
              }
            }, builder: (context, state) {
              if (state is PredictApiErr) {
                return EmptyWidget(
                  title: 'Network error',
                  description: state.message,
                  onRefresh: () =>
                      _predictionCubit.getPrediction(day: day.toString()),
                );
              } else if (state is PredictNetworkErr) {
                return EmptyWidget(
                  title: 'Network error',
                  description: state.message,
                  onRefresh: () =>
                      _predictionCubit.getPrediction(day: day.toString()),
                );
              }

              return (state is PredictListLoading || 
              state is RatingPredictLoading)
                  ? const LoadingPage()
                  : Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: SingleChildScrollView(
                        child: Column(children: [
                          SizedBox(height: 24.v),
                          SizedBox(
                            height: 65.adaptSize,
                            child: ListView.builder(
                              itemCount: currentDay,
                              controller: _scrollController,
                              shrinkWrap: true,
                              reverse: false,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                final int adjustedIndex = currentDay - index;
                                final DateTime date = DateTime(
                                    now.year, now.month, adjustedIndex);
                                final bool isCurrentDay =
                                    adjustedIndex == currentDay;

                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedDay = adjustedIndex;

                                      day = _selectedDay;
                                      
                                      _predictionCubit.getPrediction(
                                          day: day.toString());
                                    });
                                  },
                                  child: Container(
                                    height: 65.adaptSize,
                                    width: 53.adaptSize,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: isCurrentDay
                                          ? (_selectedDay == adjustedIndex
                                              ? Colors.green.shade900
                                              : Colors.green.shade900)
                                          : (_selectedDay == adjustedIndex
                                              ? Colors.grey
                                              : Colors.white),
                                      border: Border.all(
                                          color: Colors.green.shade900),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          DateFormat('d').format(date),
                                          style: TextStyle(
                                            fontWeight: isCurrentDay
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                            color: isCurrentDay
                                                ? (_selectedDay == adjustedIndex
                                                    ? Colors.white
                                                    : Colors.white)
                                                : Colors.black,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Text(
                                          DateFormat('E').format(date),
                                          style: TextStyle(
                                            color: isCurrentDay
                                                ? (_selectedDay == adjustedIndex
                                                    ? Colors.white
                                                    : Colors.white)
                                                : Colors.black,
                                            fontWeight: isCurrentDay
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 25.v),
                          Divider(),
                          SizedBox(height: 10.v),
                          if (predictedMatch.isNotEmpty) ...[
                            ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder: (context, index) {
                                  return Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 18.0.v),
                                      child: SizedBox(
                                          width: 64.h,
                                          child: Divider(
                                              height: 1.v,
                                              thickness: 1.v,
                                              color: appTheme.teal200)));
                                },
                                itemCount: predictedMatch.length,
                                itemBuilder: (context, index) {
                                  return PredictionContainer(
                                    predictedInfo: predictedMatch[index], onTap: (value){
                                      _predictionCubit.postPredictionRating(predictionId: predictedMatch[index].id.toString(), predictionRating: value.toString());
                                    },
                                  );
                                }),
                          ] else ...[
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 100.v),
                                Container(
                                    height: 230.v,
                                    width: 230.h,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.h, vertical: 5.v),
                                    child: CustomImageView(
                                        fit: BoxFit.cover,
                                        imagePath: ImageConstant
                                            .imgIllustrationStartup,
                                        width: MediaQuery.sizeOf(context).width,
                                        alignment: Alignment.bottomLeft)),
                                SizedBox(height: 20.v),
                                Text("Opps! No predictions for this Day",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black)),
                              ],
                            )
                          ]
                        ]),
                      ));
            })));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 53.v,
        centerTitle: true,
        title: AppbarSubtitleOne(
            text: "Predictions",
            margin: EdgeInsets.only(top: 0.v, bottom: 9.v)),
        styleType: Style.bgOutline_3);
  }

  Widget _buildPredictionsDay(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 7.h, vertical: 11.v),
        decoration: AppDecoration.outlineGray100
            .copyWith(borderRadius: BorderRadiusStyle.circleBorder24),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          CustomImageView(
              imagePath: ImageConstant.imgArrowLeft,
              height: 24.adaptSize,
              width: 24.adaptSize,
              onTap: () {}),
          Padding(
              padding: EdgeInsets.only(top: 3.v),
              child: Text("Today",
                  style: CustomTextStyles.titleMediumOnPrimaryBold)),
          CustomImageView(
              imagePath: ImageConstant.imgArrowRightOnprimary,
              height: 24.adaptSize,
              width: 24.adaptSize)
        ]));
  }

   
}
