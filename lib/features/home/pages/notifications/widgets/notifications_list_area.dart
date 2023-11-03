import 'package:agendai/core/widgets/app_empty_state_indicator.dart';
import 'package:agendai/core/widgets/app_loading_indicator.dart';
import 'package:agendai/features/home/pages/notifications/notifications_page_cubit.dart';
import 'package:agendai/features/home/pages/notifications/widgets/notifications_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsListArea extends StatefulWidget {
  const NotificationsListArea({Key? key, required this.status})
      : super(key: key);

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

          if (state.notifications == null) return Container();

          if (state.notifications!.isEmpty) {
            return const AppEmptyStateIndicator(
              icon: Icons.notifications_off_outlined,
              message: 'Você não possui notificações ainda!',
            );
          }

          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ListView.builder(
              padding: MediaQuery.paddingOf(context).add(
                const EdgeInsets.fromLTRB(24, 0, 24, 24),
              ),
              itemBuilder: (_, i) {
                if (i < state.notifications!.length) {
                  final notification = state.notifications![i];
                  return NotificationListItem(notification: notification);
                } else {
                  cubit.loadNotifications();
                  return const Center(
                    child: AppLoadingIndicator(),
                  );
                }
              },
              itemCount:
                  state.notifications!.length + (state.finishedLoading ? 0 : 1),
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}



// class NotificationsListArea extends StatefulWidget {
//   const NotificationsListArea({Key? key, required this.status})
//       : super(key: key);

//   final NotificationStatus status;

//   @override
//   State<NotificationsListArea> createState() => _NotificationsListAreaState();
// }

// class _NotificationsListAreaState extends State<NotificationsListArea>
//     with AutomaticKeepAliveClientMixin {
//   late final NotificationsPageCubit cubit =
//       NotificationsPageCubit(status: widget.status);

//   @override
//   void initState() {
//     super.initState();

//     cubit.loadNotifications();
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);

//     return BlocProvider.value(
//       value: cubit,
//       child: BlocBuilder<NotificationsPageCubit, NotificationsPageState>(
//         builder: (context, state) {
//           if (state.isLoading) {
//             return const Center(
//               child: AppLoadingIndicator(),
//             );
//           }

//           if (state.notifications == null) return Container();

//           if (state.notifications!.isEmpty) {
//             return const AppEmptyStateIndicator(
//               icon: Icons.notifications_off_outlined,
//               message: 'Você não possui notificações ainda!',
//             );
//           }

//           return Padding(
//             padding: const EdgeInsets.only(top: 8),
//             child: ListView.builder(
//               padding: MediaQuery.paddingOf(context).add(
//                 const EdgeInsets.fromLTRB(24, 0, 24, 24),
//               ),
//               itemBuilder: (_, i) {
//                 if (i < state.notifications!.length) {
//                   final notification = state.notifications![i];
//                   return NotificationListItem(notification: notification);
//                 } else {
//                   cubit.loadNotifications();
//                   return const Center(
//                     child: AppLoadingIndicator(),
//                   );
//                 }
//               },
//               itemCount:
//                   state.notifications!.length + (state.finishedLoading ? 0 : 1),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   @override
//   bool get wantKeepAlive => true;
// }
