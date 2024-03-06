class Group {
  final String senderId;
  final String name;
  final String pinnedMessage;
  final String groupId;
  final String lastMessage;
  final bool isGroupLocked;
  final String groupLink;
  final String groupPic;
  final List<String> membersUid;
  final DateTime timeSent;
  Group( {
    required this.isGroupLocked,required this.groupLink,
    required this.senderId,
    required this.name,
    required this.pinnedMessage, 
    required this.groupId,
    required this.lastMessage,
    required this.groupPic,
    required this.membersUid,
    required this.timeSent,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'name': name,
      'pinnedMessage': pinnedMessage,
      'groupId': groupId,
      'lastMessage': lastMessage,
      'groupPic': groupPic,
      'membersUid': membersUid,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'groupLink': groupLink,
      'isGroupLocked': isGroupLocked,
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      senderId: map['senderId'] ?? '',
      pinnedMessage: map['pinnedMessage'] ?? '',
      name: map['name'] ?? '',
      groupId: map['groupId'] ?? '',
      lastMessage: map['lastMessage'] ?? '',
      groupPic: map['groupPic'] ?? '',
      membersUid: List<String>.from(map['membersUid']),
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      groupLink: map['groupLink'] ?? '',
      isGroupLocked: map['isGroupLocked'] ?? false
    );
  }
}
