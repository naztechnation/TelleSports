import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tellesports/presentation/community_screens/group/screens/create_group_screen.dart';
import 'package:tellesports/res/app_strings.dart';
import 'package:tellesports/utils/navigator/page_navigator.dart';
import '../../../../core/constants/routes_constants.dart';
import '../../../../model/chats/group.dart';
import '../../../../utils/loader.dart';
import '../../chat/controllers/chat_controller.dart';
import '../../chat/widgets/no_chat.dart';

class GroupChatScreen extends ConsumerStatefulWidget {
  const GroupChatScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GroupChatScreenState();
}

class _GroupChatScreenState extends ConsumerState<GroupChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      iconTheme: Theme.of(context).iconTheme.copyWith(
            // color: AppColors.onPrimary,
          ),
      title: Text(
        'Groups',
        style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
              // color: AppColors.onPrimary,
              fontSize: 18.0,
            ),
      ),
      actions: [
        PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: const Text('Create Group'),
              onTap: () => Future(
                () => AppNavigator.pushAndStackPage(context, page: CreateGroupScreen()),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBody() {
    return StreamBuilder<List<Group>>(
      stream: ref.watch(chatControllerProvider).getGroupChatsList(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Loader();
        }
        return snapshot.data!.isEmpty
            ? const NoChat()
            : ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Group group = snapshot.data![index];
                  return _buildChatListItem(context, index, group);
                },
              );
      },
    );
  }

  Widget _buildChatListItem(BuildContext context, int index, Group group) {
    Size size = MediaQuery.of(context).size;

    return ListTile(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.chatScreen,
        arguments: <String, Object>{
          AppStrings.username: group.groupName,
          AppStrings.userId: group.groupId,
          AppStrings.profilePic: group.groupProfilePic,
          AppStrings.isGroupChat: true,
        },
      ),
      title: Text(
        group.groupName,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: size.width * 0.045,
            ),
      ),
      subtitle: Text(
        group.lastMessage,
        maxLines: 1,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: size.width * 0.035,
            ),
      ),
      leading: CircleAvatar(
        radius: 30.0,
        backgroundImage: NetworkImage(
          group.groupProfilePic,
        ),
      ),
      trailing: Text(
        DateFormat.Hm().format(group.time),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: size.width * 0.030,
            ),
      ),
    );
  }
}
