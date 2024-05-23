


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/core/app_export.dart';

 
import '../../blocs/accounts/account.dart';
import '../../model/auth_model/notifications_details.dart';
import '../../model/view_models/account_view_model.dart';
import '../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../utils/app_utils.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart'; 
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/loading_page.dart';
 


 class NotificationsDetails extends StatelessWidget {
  final String notifyId;
  final String title;
  final String message;
  final String date;
  const NotificationsDetails({
    Key? key, required this.notifyId, required this.title, required this.message, required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountCubit>(
      create: (BuildContext context) => AccountCubit(
          accountRepository: AccountRepositoryImpl(),
          viewModel: Provider.of<AccountViewModel>(context, listen: false)),
      child:   Notifications(notifyId, title, message, date),
    );
  }
}
class Notifications extends StatefulWidget {
  final String notifyId;
final String title;
  final String message;
  final String date;
    Notifications(this.notifyId, this.title, this.message, this.date
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


    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: _buildAppBar(context),

      body: BlocConsumer<AccountCubit, AccountStates>(listener: (context, state) {
        if (state is  NotificationsDetailsLoaded) {
          if (state.notify.success ?? false) {
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
            : Column(children: [
               
              SingleChildScrollView(
                            child: Column(

              children: [
                Container(

                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                      // color: Colors.green.withOpacity(0.1),
                      border: Border(
                          bottom: BorderSide(color: Colors.green.shade300))),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child:   Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        SizedBox(height: 12.0),
                        Text(
                          widget.message,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 12,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                        SizedBox(height: 20.0),
                        Padding(
                          padding: EdgeInsets.only(right: 12.0),
                          child: Text(
                                  AppUtils.formatComplexDate(
                                          dateTime: widget.date),
                            
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
                            ),
                          )
            ]);},
      ),
    );
  }

   PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 40.v,
      leadingWidth: 44.h,
      
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowBack,
        margin: EdgeInsets.only(
          left: 20.h,
          top: 10.v,
          bottom: 12.v,
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: "Notification Details",
        margin: EdgeInsets.only(
          top: 10.v,
          bottom: 8.v,
        ),
      ),
      styleType: Style.bgFill,
    );
  }
}

