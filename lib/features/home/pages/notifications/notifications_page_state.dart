part of 'notifications_page_cubit.dart';

class NotificationsPageState extends Equatable {
  const NotificationsPageState(
      {this.isLoading = false,
      this.page = 0,
      this.finishedLoading = false,
      List<Notification>? notifications})
      : _notifications = notifications;

  final bool isLoading;
  final int page;
  final bool finishedLoading;

  final List<Notification>? _notifications;

  UnmodifiableListView<Notification>? get notifications =>
      _notifications != null ? UnmodifiableListView(_notifications!) : null;

  @override
  List<Object?> get props => [isLoading, _notifications, page, finishedLoading];

  NotificationsPageState copyWith(
      {bool? isLoading,
      List<Notification>? notifications,
      int? page,
      bool? finishedLoading}) {
    return NotificationsPageState(
      isLoading: isLoading ?? this.isLoading,
      notifications: notifications ?? _notifications,
      page: page ?? this.page,
      finishedLoading: finishedLoading ?? this.finishedLoading,
    );
  }

  NotificationsPageState replaceNotification(
      Notification oldNotification, Notification newNotification) {
    final notifications = List<Notification>.from(_notifications!);
    final index = notifications.indexOf(oldNotification);
    notifications.removeAt(index);
    notifications.insert(index, newNotification);

    return copyWith(
      notifications: notifications,
    );
  }
}
