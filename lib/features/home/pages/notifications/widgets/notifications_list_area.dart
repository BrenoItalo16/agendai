import 'package:agendai/core/widgets/app_loading_indicator.dart';
import 'package:agendai/features/home/pages/notifications/notifications_page_cubit.dart';
import 'package:agendai/features/home/pages/notifications/widgets/notifications_list_item.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsListArea extends StatefulWidget {
  const NotificationsListArea({super.key, required this.status});

  final NotificationStatus status;

  @override
  State<NotificationsListArea> createState() => _NotificationsListAreaState();
}

class _NotificationsListAreaState extends State<NotificationsListArea>
    with AutomaticKeepAliveClientMixin {
  late final NotificationsPageCubit cubit =
      NotificationsPageCubit(status: widget.status);

  @override
  void initState() {
    super.initState();
    cubit.loadNotifications();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<NotificationsPageCubit, NotificationsPageState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: AppLoadingIndicator(),
            );
          }
          return ListView.builder(
            padding: MediaQuery.paddingOf(context).add(
              const EdgeInsets.fromLTRB(24, 0, 24, 24),
            ),
            itemBuilder: (_, i) {
              if (i < state.notifications!.length) {
                final notification = state.notifications![i];
                return NotificationsListItem(notification: notification);
              } else {
                cubit.loadNotifications();
                return const Center(
                  child: AppLoadingIndicator(),
                );
              }
            },
            itemCount:
                state.notifications!.length + (state.finishedLoading ? 0 : 1),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
