import 'package:agendai/core/widgets/app_card.dart';
import 'package:agendai/core/widgets/app_chip.dart';
import 'package:agendai/core/widgets/base/app_stateless.dart';
import 'package:agendai/features/home/pages/home/models/notification.dart';
import 'package:agendai/features/home/pages/notifications/notifications_page_cubit.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:agendai/core/theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

class NotificationsListItem extends AppStateless {
  const NotificationsListItem({
    super.key,
    required this.notification,
  });

  final Notification notification;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return AppCard(
      onPressed: () {
        context.push(notification.page);
        if (!notification.isRead) {
          context
              .read<NotificationsPageCubit>()
              .markNotificationRead(notification);
        }
      },
      shadowOffset: const Offset(6, 6),
      child: Row(
        children: [
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: notification.isRead ? theme.lightGrey : theme.primary,
            ),
            child: Icon(
              IconlyLight.notification,
              color: notification.isRead ? theme.grey : theme.white,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        style: notification.isRead
                            ? theme.body16
                            : theme.body16Bold,
                      ),
                    ),
                    AppChip(
                      text: DateFormat('dd/MMM').format(notification.createdAt),
                      minWidth: 64,
                      color: notification.isRead
                          ? null
                          : theme.primary.withOpacity(0.1),
                      textStyle: notification.isRead
                          ? null
                          : theme.label12Bold.copyWith(color: theme.primary),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  notification.subtitle,
                  style: theme.body13,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
