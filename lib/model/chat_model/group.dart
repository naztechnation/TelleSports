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
  final List<MemberData> membersUid;
  final List<String> blockedMembers;
  final List<String> requestsMembers;
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
    required this.membersUid,
    required this.blockedMembers,
    required this.requestsMembers,
    required this.timeSent,
    required this.communityType,
    required this.communityPrice,
    required this.paymentType,
    required this.showMemberCount,
  });

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
      blockedMembers: List<String>.from(map['blockedMembers']),
      requestsMembers: List<String>.from(map['requestsMembers']),
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      communityType: map['communityType'] ?? '',
      communityPrice: map['communityPrice'] ?? '',
      paymentType: map['paymentType'] ?? '',
      showMemberCount: map['showMemberCount'] ?? false,
    );
  }
}



class MemberData {
  final String userId;
  final DateTime dateJoined;

  MemberData({
    required this.userId,
    required this.dateJoined,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'dateJoined': dateJoined.millisecondsSinceEpoch,
    };
  }

  factory MemberData.fromMap(Map<String, dynamic> map) {
    return MemberData(
      userId: map['userId'] ?? '',
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