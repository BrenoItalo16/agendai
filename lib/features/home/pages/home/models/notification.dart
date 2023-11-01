import 'package:equatable/equatable.dart';

class Notification extends Equatable {
  const Notification({
    required this.id,
    required this.isRead,
    required this.title,
    required this.subtitle,
    required this.page,
    required this.createdAt,
  });

  final String id;
  final bool isRead;
  final String title;
  final String subtitle;
  final String page;
  final DateTime createdAt;

  factory Notification.fromJson(Map<String, dynamic> map) {
    return Notification(
      id: map['id'] as String,
      isRead: map['isRead'] as bool,
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
      page: map['page'] as String,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Notification copyWith({
    String? id,
    bool? isRead,
    String? title,
    String? subtitle,
    String? page,
    DateTime? createdAt,
  }) {
    return Notification(
      id: id ?? this.id,
      isRead: isRead ?? this.isRead,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      page: page ?? this.page,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, isRead, title, subtitle, page, createdAt];
}
