

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/model/auth_model/notifications.dart';

import '../../../handlers/secure_handler.dart';
import '../../../model/view_models/user_view_model.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../blocs/accounts/account.dart';
import '../../core/app_export.dart';
import '../../model/view_models/account_view_model.dart';
import '../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../widgets/app_bar/appbar_subtitle_one.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/loading_page.dart';
import 'notification_details.dart';


class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountCubit>(
      create: (BuildContext context) => AccountCubit(
          accountRepository: AccountRepositoryImpl(),
          viewModel: Provider.of<AccountViewModel>(context, listen: false)),
      child: const Notifications(),
    );
  }
}
class Notifications extends StatefulWidget {
  const Notifications();

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
bool showother =  false;

  late AccountCubit _userCubit;


  List<NotificationsListData> notifications = [];

  getNotifications() async {
    _userCubit = context.read<AccountCubit>();


    _userCubit.getNotifications();
  }

  @override
  void initState() {
    getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final timeFormat = Provider.of<UserViewModel>(context, listen: false);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocConsumer<AccountCubit, AccountStates>(listener: (context, state) {
        if (state is NotificationsLoaded) {
          if (state.notify.success == 1) {
            notifications = state.notify.data ?? [];
            setState(() {});
          } else {}
        }
      }, builder: (context, state) {
        if (state is NotificationsApiErr) {
          return EmptyWidget(
            title: 'Network error',
            description: state.message,
            onRefresh: () => _userCubit.getNotifications(),
          );
        } else if (state is NotificationsNetworkErr) {
          return EmptyWidget(
            title: 'Network error',
            description: state.message,
            onRefresh: () => _userCubit.getNotifications(),
          );
        } 

        return (state is NotificationsLoading )
            ? const LoadingPage()
            : Column(
          children: [
            SafeArea(
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.03,
              ),
            ),
            
            const SizedBox(
              height: 26,
            ),
             const Padding(
               padding: EdgeInsets.symmetric(horizontal:16.0),
               child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Notifications',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                        ),
                      ),
             ),
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(children: [
                 
                  const SizedBox(
                    height: 26,
                  ),
                if(notifications.isEmpty)...[
                   

                   SizedBox(height: 24.v),
                            Text(
                                "You don’t have any notification at this time!",
                                style: CustomTextStyles.labelLargeBlack900),
                           
                            SizedBox(height: 11.v),
                            Container(
                                height: 198.v,
                                width: 193.h,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 28.h, vertical: 25.v),
                                child: CustomImageView(
                                    fit: BoxFit.cover,
                                    imagePath:
                                        ImageConstant.imgIllustrationStartup,
                                    width: MediaQuery.sizeOf(context).width,
                                    alignment: Alignment.bottomLeft))
                ]else...[
                  ListView.builder(
                      itemCount: notifications.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, index) {
                        return GestureDetector(
                          onTap: (){
                            AppNavigator.pushAndStackPage(context, page:  NotificationsDetails(notifyId: notifications[index].id.toString(),));
                          },
                          child: Container(
                            decoration:   BoxDecoration(
                              color: (index % 2 == 0)? Colors.grey.withOpacity(0.1) : Colors.white,
                              border:   Border(bottom: BorderSide(color: Colors.grey.shade300))),
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            child:   Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  
                                  Text(
                                    notifications[index].message ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400, fontSize: 14),
                                  ),
                                  SizedBox(height: 20.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                      timeFormat.getCurrentTime(int.parse(notifications[index].createdAt ?? ''))  ,
                                      ),
                                     
                                       
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ]  
                 
                ]),
              ),
            )),
          ],
        );
  }),
    );
  }

    PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 93.v,
        centerTitle: true,
        title: AppbarSubtitleOne(
            text: "Notifications", margin: EdgeInsets.only(top: 61.v, bottom: 7.v)),
        styleType: Style.bgOutline_4);
  }
}
