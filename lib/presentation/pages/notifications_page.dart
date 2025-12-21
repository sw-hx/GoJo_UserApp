import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_jo_user_application/presentation/cubits/get_notification_cubit/get_notification_cubit.dart';
import '../../data/models/notification_model.dart';
import '../../domain/repos/notification_repo.dart';
import '../../services/git_it_service.dart';
import '../common_components/bottom_nav_bar.dart';
import '../common_components/custom_returnArrow.dart';
import '../components/components_notif/extandable_notif.dart';
import '../cubits/delete_notification_cubit/delete_notification_cubit.dart';
import 'home_page.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GetNotificationCubit(
            notificationRepo: getIt.get<NotificationRepo>(),
          )..getNotification(),
        ),
        BlocProvider(
          create: (_) => DeleteNotificationCubit(
            notificationRepo: getIt.get<NotificationRepo>(),
          ),
        ),
      ],
      child: BlocListener<DeleteNotificationCubit, DeleteNotificationState>(
        listener: (context, state) {
          if (state is DeleteNotificationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Notification deleted")),
            );
          }

          if (state is DeleteNotificationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );

          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomReturnArrow(targetPage: HomePage()),
                  const SizedBox(height: 20),
                  const Text(
                    "Notifications",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF11324D),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Your journey starts here",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF11324D),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Expanded(
                    child: BlocBuilder<GetNotificationCubit, GetNotificationState>(
                      builder: (context, state) {
                        if (state is GetNotificationLoading) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (state is GetNotificationError) {
                          return Center(child: Text(state.message));
                        }

                        if (state is GetNotificationSuccess) {
                          final List<dynamic> notifications =
                              state.notifications;

                          if (notifications.isEmpty) {
                            return const Center(child: Text("No notifications found"));
                          }

                          return ListView.separated(
                            itemCount: notifications.length,
                            separatorBuilder: (_, __) =>
                            const SizedBox(height: 16),
                            itemBuilder: (context, index) {
                              final n = notifications[index];

                              return Dismissible(
                                key: ValueKey(n.notificationId),
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  alignment: Alignment.centerRight,
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: const Icon(
                                    Icons.delete_forever,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                onDismissed: (_) async {
                                  try {
                                    await context.read<DeleteNotificationCubit>().deleteNotification(n.notificationId,);
                                  } catch (_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("Delete failed")),
                                    );
                                  }
                                },
                                child: ExpandableNotificationCard(notification: n),
                              );
                            },
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: const BottomNavBar(),
        ),
      ),
    );
  }
}
