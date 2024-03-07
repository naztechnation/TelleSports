 
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import 'package:intl/intl.dart';
import 'package:tellesports/utils/navigator/page_navigator.dart';

import '../../../../common/utils/colors.dart';
import '../../../../handlers/secure_handler.dart';
import '../../../../utils/loader.dart';
import '../../../../widgets/modals.dart';
import '../../group/screens/create_group_screen.dart';
import '../../provider/auth_provider.dart' as pro;
import '../screens/mobile_chat_screen.dart';

class ContactsList extends ConsumerWidget {
  ContactsList({Key? key}) : super(key: key);

  String userId = '';
  getUserId() async {
    userId = await StorageHandler.getUserId() ?? '';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    getUserId();
    final checkUserExist =
        provider.Provider.of<pro.AuthProviders>(context, listen: true);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<List<dynamic>>(
                  stream: checkUserExist.getAllChatGroups(userId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Loader();
                    } else if (snapshot.data!.isEmpty) {
                      return SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.7,
                          child: const Align(
                              child: Text(
                            'No Groups Available',
                            style: TextStyle(color: Colors.green),
                          )));
                    }
      
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var groupData = snapshot.data![index];
      
                        return Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                if (groupData.membersUid.contains(
                                    userId)) {
                                  if (context.mounted) {
                                    checkUserExist.addGroupInfo(
                                        groupNumber: groupData.membersUid.length
                                            .toString(),
                                        groupAdminId: groupData.membersUid[0],
                                        groupId: groupData.groupId,
                                        groupLink: groupData.groupLink,
                                        isGroupLocked: groupData.isGroupLocked,
                                        groupDesription: groupData.groupDescription,
                                        pinnedMessage: groupData.pinnedMessage);

                                        AppNavigator.pushAndStackPage(context, page: MobileChatScreen(groupData.groupDescription,name: groupData.name, uid: groupData.groupId, isGroupChat: true, profilePic: groupData.groupPic,));
                                    
                                  }
                                } else if (!checkUserExist.isUserExisting) {
                                  Modals.showToast(
                                    'you are not a member of this group',
                                  );
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: ListTile(
                                  title: Text(
                                    groupData.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 6.0),
                                    child: Text(
                                      groupData.lastMessage,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 15, color: Colors.black),
                                    ),
                                  ),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      groupData.groupPic,
                                    ),
                                    radius: 30,
                                  ),
                                  trailing: Text(
                                    DateFormat('hh:mm a')
                                        .format(groupData.timeSent.toLocal()),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Divider(color: dividerColor, indent: 15),
                          ],
                        );
                      },
                    );
                  }),
            ],
          ),
         
        ),
        
      ),
       floatingActionButton: FloatingActionButton.extended(
          label: const Text('Create Group', style: TextStyle(color: Colors.white),),
          onPressed: () async {
            AppNavigator.pushAndStackPage(context, page: CreateGroupScreen());
            // if (tabBarController.index == 0) {
              // Navigator.pushNamed(
              //           context, CreateGroupScreen.routeName);
              // // Navigator.pushNamed(context, SelectContactsScreen.routeName);
            // } else {
             //File? pickedImage = await pickImageFromGallery(context);
              // if (pickedImage != null) {
              // if(context.mounted) {
              //   //  Navigator.pushNamed(
              //   //   context,
              //   //   ConfirmStatusScreen.routeName,
              //   //   arguments: pickedImage,
              //   // );
              // }
              // }
            // }
          },
          backgroundColor: tabColor,
          icon: const Icon(
            Icons.people_alt_sharp,
            color: Colors.white,
          ),
        ),
    );
  }
}
