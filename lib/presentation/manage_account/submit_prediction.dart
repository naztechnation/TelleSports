import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/model/prediction_data/prediction_data.dart';
import 'package:tellesports/presentation/landing_page/landing_page.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

import '../../../core/constants/enums.dart';
import '../../../utils/validator.dart';
import '../../../widgets/modals.dart';
import '../../blocs/prediction/prediction.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/prediction_repo/predict_repository_impl.dart';
import '../../utils/navigator/page_navigator.dart';


class SubmitPredictionScreen extends StatelessWidget {
  const SubmitPredictionScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PredictionCubit>(
      create: (BuildContext context) => PredictionCubit(
          predictRepository: PredictRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: SubmitPrediction(),
    );
  }
}
class SubmitPrediction extends StatefulWidget {
  SubmitPrediction({Key? key}) : super(key: key);

  @override
  State<SubmitPrediction> createState() => _SubmitPredictionState();
}

class _SubmitPredictionState extends State<SubmitPrediction> {
  TextEditingController homeTeamController = TextEditingController();
  TextEditingController awayTeamController = TextEditingController();
  TextEditingController awayScoreController = TextEditingController();
  TextEditingController homeScoreController = TextEditingController();
  TextEditingController predictedWinnerController = TextEditingController();
  TextEditingController winnerController = TextEditingController();
  TextEditingController winnerOddController = TextEditingController();
  TextEditingController leagueController = TextEditingController();


  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String bankName = '';
  String accountNumber = '';
  String accountName = '';
  String homeLogo = '';
  String awayLogo = '';

  List<Map<String, String>>? filteredTeam;
  late PredictionCubit _predictionCubit;

 getPredictions() async {
    _predictionCubit = context.read<PredictionCubit>();
     

     
  }

  @override
  void initState() {
    getPredictions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: BlocConsumer<PredictionCubit, PredictStates>(
              listener: (context, state) {
                if (state is PredictLoaded) {
                  if (state.predict.success ?? false) {
                    Modals.showToast( 'Prediction submitted successfully',
                        messageType: MessageType.success);
            
                    Future.delayed(
                        Duration(
                          seconds: 1,
                        ), () {
                      AppNavigator.pushAndReplacePage(context,
                          page: LandingPage());
                      ;
                    });
                  } else {
                    Modals.showToast('Failed to submit prediction',
                        messageType: MessageType.error);
                  }
                } else if (state is PredictApiErr) {
                  if (state.message != null) {
                    Modals.showToast(state.message ?? '',
                        messageType: MessageType.error);
                  }
                } else if (state is PredictNetworkErr) {
                  if (state.message != null) {
                    Modals.showToast(state.message ?? '',
                        messageType: MessageType.error);
                  }
                }
              },
              builder: (context, state) => Form(
                  key: _formKey,
                  child: Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(horizontal: 16.h),
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Submit your Predictions",
                                  style: theme.textTheme.headlineLarge),
                              SizedBox(height: 10.v),
                              Text("Please enter your predictions here.",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      fontSize: 14, letterSpacing: 0.2)),
                              SizedBox(height: 29.v),
                              _buildLeagueField(context),
                              SizedBox(height: 11.v),
                              _buildHomeTeamField(context),
                              SizedBox(height: 11.v),
                        
                               _buildHomeScoreField(context),
                              SizedBox(height: 11.v),
                              _buildAwayTeamField(context),
                              SizedBox(height: 11.v),
                             
                              _buildAwayScoreField(context),
                              SizedBox(height: 11.v),
                        
                              _buildPredictedWinnerField(context),
                              SizedBox(height: 11.v),
                              _buildOddsField(context),
                              SizedBox(height: 32.v),
                              CustomElevatedButton(
                                  text: "Submit",
                                  title: 'Submitting data...',
                                  processing: state is PredictLoading,
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 4.h),
                                  onPressed: () {
                                     predictedWinnner.clear();
                                     addPredictedWinnnerList();
                                    onTapSubmitPredictions(context);
                                  }),
                              SizedBox(height: 35.v)
                            ]),
                      ))),
            )));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 389.h,
        leading: AppbarLeadingImage(
            onTap: () {
              Navigator.pop(context);
            },
            imagePath: ImageConstant.imgVector,
            margin: EdgeInsets.fromLTRB(24.h, 20.v, 350.h, 20.v)));
  }

  Widget _buildLeagueField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 0.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("League *", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
            controller: leagueController,
            hintText: "Select League",
            hintStyle: CustomTextStyles.titleSmallGray600,
            textInputType: TextInputType.name,
            readOnly: true,
            suffix: Icon(
              Icons.arrow_drop_down,
              size: 20,
            ),
            validator: (value) {
              return Validator.validate(value, 'League');
            },
            contentPadding: EdgeInsets.only(left: 8.h, top: 14.v, bottom: 14.v),
            onTap: (() {
              Modals.showBottomSheetModal(context,
                  isScrollControlled: true,
                  heightFactor: 1,
                  isDissmissible: true,
                  page: optionWidget(leagues, 'Leagues', leagueController));
            }),
          )
        ]));
  }

  Widget _buildHomeTeamField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 0.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Home Team *", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: homeTeamController,
              hintText: 'Select home way',
              hintStyle: CustomTextStyles.titleSmallGray600,
              textInputType: TextInputType.name,
              readOnly: true,
               suffix: Icon(
              Icons.arrow_drop_down,
              size: 20,
            ),
              validator: (value) {
                return Validator.validate(value, 'Home team');
              },
              contentPadding:
                  EdgeInsets.only(left: 8.h, top: 14.v, bottom: 14.v),
                   onTap: (() {
                    if(filteredTeam != null){
                      Modals.showBottomSheetModal(context,
                  isScrollControlled: true,
                  heightFactor: 1,
                  isDissmissible: true,
                  page: optionWidget2(filteredTeam, 'Leagues', homeTeamController, true));
                    }else{
                      Modals.showToast('Please select a league');
                    }
              
            }),
                  )
        ]));
  }

  Widget _buildAwayTeamField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 0.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Away Team *", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: awayTeamController,
              hintText: 'Select away way',
              readOnly: true,
              hintStyle: CustomTextStyles.titleSmallGray600,
              textInputType: TextInputType.name,
              validator: (value) {
                return Validator.validate(value, 'Away team');
              },
               suffix: Icon(
              Icons.arrow_drop_down,
              size: 20,
            ),
              contentPadding:
                  EdgeInsets.only(left: 8.h, top: 14.v, bottom: 14.v),
                 onTap: (() {
                    if(filteredTeam != null){
                      Modals.showBottomSheetModal(context,
                  isScrollControlled: true,
                  heightFactor: 1,
                  isDissmissible: true,
                  page: optionWidget2(filteredTeam, 'Leagues', awayTeamController, false));
                    }else{
                      Modals.showToast('Please select a league');
                    }
              
            }),  
                  )
        ]));
  }

  Widget _buildPredictedWinnerField(BuildContext context) { 
    return Padding(
        padding: EdgeInsets.only(left: 0.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Predicted  Winner *", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: predictedWinnerController,
              hintText: "Select predicted  winner",
              hintStyle: CustomTextStyles.titleSmallGray600,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.name,
              readOnly: true,
               suffix: Icon(
              Icons.arrow_drop_down,
              size: 20,
            ),
              validator: (value) {
                return Validator.validate(value, 'Select Predicted winner');
              },
              contentPadding:
                  EdgeInsets.only(left: 8.h, top: 14.v, bottom: 14.v),
                  onTap: () {
                    if(awayTeamController.text.isNotEmpty  && homeTeamController.text.isNotEmpty){
                      predictedWinnner.clear();
                      addPredictedWinnnerList();
                       Modals.showBottomSheetModal(context,
                  isScrollControlled: true,
                  heightFactor: 1,
                  isDissmissible: true,
                  page: optionWidget(predictedWinnner, 'Predicted', predictedWinnerController));
                    }else{
                      Modals.showToast('please select both home and away teams');
                    }
                     
                  },
                  
                  )
        ]));
  }

  Widget _buildHomeScoreField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 0.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Home Score (Optional)", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: homeScoreController,
              hintText: 'Enter home score',
              hintStyle: CustomTextStyles.titleSmallGray600,
              textInputType: TextInputType.number,
              // validator: (value) {
              //   return Validator.validate(value, 'Home score');
              // },
              contentPadding:
                  EdgeInsets.only(left: 8.h, top: 14.v, bottom: 14.v))
        ]));
  }

   Widget _buildAwayScoreField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 0.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Away Score (Optional)", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: awayScoreController,
              hintText: 'Enter away score',
              hintStyle: CustomTextStyles.titleSmallGray600,
              textInputType: TextInputType.number,
              // validator: (value) {
              //   return Validator.validate(value, 'Away score');
              // },
              contentPadding:
                  EdgeInsets.only(left: 8.h, top: 14.v, bottom: 14.v))
        ]));
  }
  
  Widget _buildOddsField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 0.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Winner\'s Odd *", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: winnerOddController,
              hintText: 'Enter winners odd',
              hintStyle: CustomTextStyles.titleSmallGray600,
              textInputType: TextInputType.number,
              validator: (value) {
                return Validator.validate(value, 'Winners');
              },
              contentPadding:
                  EdgeInsets.only(left: 8.h, top: 14.v, bottom: 14.v))
        ]));
  }

  onTapSubmitPredictions(BuildContext context) {
    if (_formKey.currentState!.validate()) {

      if(homeTeamController.text == awayTeamController.text){
      
        Modals.showToast('Away Team and Home Team cannot be same');

      }else if (!predictedWinnner.contains(predictedWinnerController.text.trim())){
        Modals.showToast('Predicted winner must be either home or away team');
        
      }else{
        if (_formKey.currentState!.validate()) {
         _predictionCubit.postPrediction(homeTeam: homeTeamController.text, 
        awayTeam: awayTeamController.text, homeScore: homeScoreController.text, predictedWinner: predictedWinnerController.text, 
        awayScore: awayScoreController.text, 
        odds: winnerOddController.text, league: leagueController.text, homeLogo: homeLogo, awayLogo: awayLogo
            );

         
        FocusScope.of(context).unfocus();
      }
      }

     
      
      FocusScope.of(context).unfocus();
    }
    ;
  }

  optionWidget(List<String> options, String title, final controller) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox.shrink(),
              Text(
                title,
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.green[900],
                ),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    size: 25,
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Divider(
          height: 5,
        ),
        
        Expanded(
          child: ListView.builder(
              itemCount: options.length,
              shrinkWrap: true,
              itemBuilder: ((context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context);

                    controller.text = options[index];

                    filteredTeam = filterClubsByLeague(
                        leagueName: options[index],
                        leaguesWithClubs: leaguesWithClubs);
                  },
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text('${index + 1}.',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 16)),
                                    const SizedBox(
                                      width: 13,
                                    ),
                                    Text(options[index],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios, size: 15,)
                            ],
                          ),
                        ),
                        Divider(
                          height: 5,
                        )
                      ],
                    ),
                  ),
                );
              })),
        ),
      ],
    );
  }

  optionWidget2(List<Map<String, String>>? options, String title, final controller, bool isHome) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox.shrink(),
              Text(
                title,
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.green[900],
                ),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    size: 25,
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Divider(
          height: 5,
        ),
        SizedBox(
          height: 15,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: options!.length,
              shrinkWrap: true,
              itemBuilder: ((context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context);

                    controller.text = options[index]['name'] ?? '';

                    if(isHome){
                     setState(() {
                        homeLogo = options[index]['url'] ?? '';
                     });
                    }else{
                      setState(() {
                        awayLogo = options[index]['url'] ?? '';
                     });
                    }

                    
                  },
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text('${index + 1}.',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 16)),
                                    const SizedBox(
                                      width: 13,
                                    ),
                                    Text(options[index]['name'] ?? '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios, size: 15,)
                            ],
                          ),
                        ),
                        Divider(
                          height: 5,
                        )
                      ],
                    ),
                  ),
                );
              })),
        ),
      ],
    );
  }

  List<Map<String, String>>? filterClubsByLeague(
      {required String leagueName,
      required Map<String, List<Map<String, String>>> leaguesWithClubs}) {
    if (leaguesWithClubs.containsKey(leagueName)) {
      return leaguesWithClubs[leagueName];
    } else {
     
      return null;
    }
  }

  List<String> predictedWinnner = [];

  addPredictedWinnnerList(){

  setState(() {
    predictedWinnner.add(homeTeamController.text);
    predictedWinnner.add(awayTeamController.text);
    
  });    
  }


  
}
