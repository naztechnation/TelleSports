
 
class Group {
  final String senderId;
  final String fcmToken;
  final String name;
  final String pinnedMessage;
  final String groupId;
  final String lastMessage;
  final bool isGroupLocked;
  final String groupLink;
  final String groupPic;
  final String groupDescription;
  List<MemberData> membersUid;
  List<String> blockedMembers;
  List<String> requestsMembers;
  final DateTime timeSent;
  final String communityType;
  final String communityPrice;
  final String paymentType;
  final bool showMemberCount;

  Group({
    required this.senderId,
    required this.fcmToken,
    required this.name,
    required this.pinnedMessage,
    required this.groupId,
    required this.lastMessage,
    required this.isGroupLocked,
    required this.groupLink,
    required this.groupPic,
    required this.groupDescription,
    required List<MemberData> membersUid,
    required List<String> blockedMembers,
    required List<String> requestsMembers,
    required this.timeSent,
    required this.communityType,
    required this.communityPrice,
    required this.paymentType,
    required this.showMemberCount,
  })  : membersUid = _removeDuplicateMembers(membersUid),
        blockedMembers = _removeDuplicateIds(blockedMembers),
        requestsMembers = _removeDuplicateIds(requestsMembers);

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'fcmToken': fcmToken,
      'name': name,
      'pinnedMessage': pinnedMessage,
      'groupId': groupId,
      'lastMessage': lastMessage,
      'isGroupLocked': isGroupLocked,
      'groupLink': groupLink,
      'groupPic': groupPic,
      'groupDesc': groupDescription,
      'membersUid': membersUid.map((user) => user.toMap()).toList(),
      'blockedMembers': blockedMembers,
      'requestsMembers': requestsMembers,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'communityType': communityType,
      'communityPrice': communityPrice,
      'paymentType': paymentType,
      'showMemberCount': showMemberCount,
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    try {
      return Group(
        senderId: map['senderId'] ?? '',
        fcmToken: map['fcmToken'] ?? '',
        name: map['name'] ?? '',
        pinnedMessage: map['pinnedMessage'] ?? '',
        groupId: map['groupId'] ?? '',
        lastMessage: map['lastMessage'] ?? '',
        isGroupLocked: map['isGroupLocked'] ?? false,
        groupLink: map['groupLink'] ?? '',
        groupPic: map['groupPic'] ?? '',
        groupDescription: map['groupDesc'] ?? '',
        membersUid: List<MemberData>.from(
          map['membersUid']?.map((item) => MemberData.fromMap(item)) ?? [],
        ),
        blockedMembers: List<String>.from(map['blockedMembers'] ?? []),
        requestsMembers: List<String>.from(map['requestsMembers'] ?? []),
        timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
        communityType: map['communityType'] ?? '',
        communityPrice: map['communityPrice'] ?? '',
        paymentType: map['paymentType'] ?? '',
        showMemberCount: map['showMemberCount'] ?? false,
      );
    } catch (e) {
      print('Error processing group map: $map, error: $e');
      rethrow;
    }
  }


  static List<MemberData> _removeDuplicateMembers(List<MemberData> members) {
    final memberIds = <String>{};
    return members.where((member) => memberIds.add(member.userId)).toList();
  }

  static List<String> _removeDuplicateIds(List<String> ids) {
    return ids.toSet().toList();
  }
}




class MemberData {
  final String userId;
  final String username;
  final bool recieveNotification;
  final DateTime dateJoined;

  MemberData({
    required this.userId,
    required this.username,
    required this.recieveNotification,
    required this.dateJoined,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'recieveNotification': recieveNotification,
      'dateJoined': dateJoined.millisecondsSinceEpoch,
    };
  }

  factory MemberData.fromMap(Map<String, dynamic> map) {
    return MemberData(
      userId: map['userId'] ?? '',
      username: map['username'] ?? '',
      recieveNotification: map['recieveNotification'] ?? '',
      dateJoined: DateTime.fromMillisecondsSinceEpoch(map['dateJoined']),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MemberData && other.userId == userId;
  }

  @override
  int get hashCode => userId.hashCode;
}