import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_jo_user_application/widgets/custom_TitleText.dart';
import 'package:go_jo_user_application/widgets/custom_eventsCard.dart';
import 'package:go_jo_user_application/widgets/custom_returnArrow.dart';

import '../widgets/custom_mainBar.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customReturnArrow(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customTitleText(title: 'Events', size: 35),
            customTitleText(title: 'Your journey starts here', size: 18),
            Expanded(
                child: ListView.builder(
                  itemCount: 3,
                    itemBuilder: (context,index){
                      return customEventsCard();
                    }
                )
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 2,),


    );
  }
}
