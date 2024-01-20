


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/core/app_export.dart';

import '../../../model/view_models/user_view_model.dart';
import '../../../res/app_colors.dart';
import '../../blocs/accounts/account.dart';
import '../../model/auth_model/notifications_details.dart';
import '../../model/view_models/account_view_model.dart';
import '../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../widgets/app_bar/appbar_subtitle_one.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/loading_page.dart';
 


 class NotificationsDetails extends StatelessWidget {
  final String notifyId;
  const NotificationsDetails({
    Key? key, required this.notifyId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountCubit>(
      create: (BuildContext context) => AccountCubit(
          accountRepository: AccountRepositoryImpl(),
          viewModel: Provider.of<AccountViewModel>(context, listen: false)),
      child:   Notifications(notifyId),
    );
  }
}
class Notifications extends StatefulWidget {
  final String notifyId;

    Notifications(this.notifyId
     );

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {


   late AccountCubit _userCubit;


  NotificationsDetailsData? notifications ;

  getNotifications() async {
    _userCubit = context.read<AccountCubit>();


    _userCubit.getNotificationsDetails(notifyId: widget.notifyId);
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
        if (state is  NotificationsDetailsLoaded) {
          if (state.notify.success == 1) {
            notifications = state.notify.data;
            setState(() {});
          } else {}
        }
      }, builder: (context, state) {
        if (state is NotificationsApiErr) {
          return EmptyWidget(
            title: 'Network error',
            description: state.message,
            onRefresh: () => _userCubit.getNotificationsDetails(notifyId: widget.notifyId),
          );
        } else if (state is NotificationsNetworkErr) {
          return EmptyWidget(
            title: 'Network error',
            description: state.message,
            onRefresh: () => _userCubit.getNotificationsDetails(notifyId: widget.notifyId),
          );
        } 

        return (state is NotificationsDetailsLoading )
            ? const LoadingPage()
            : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(children: [
            SafeArea(
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.04,
              ),
            ),
           
            const SizedBox(
              height: 40,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.lightSecondary.withOpacity(0.1),
                        border: Border(
                            bottom: BorderSide(color: Colors.grey.shade300))),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child:   Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          SizedBox(height: 12.0),
                          Text(
                            notifications?.message ?? '',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 12,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                               
                              Padding(
                                padding: EdgeInsets.only(right: 12.0),
                                child: Text(
                                        timeFormat.getCurrentTime(int.parse(notifications?.createdAt ?? ''))  ,
                                  
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ))
          ]),
        );},
      ),
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
