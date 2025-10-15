import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_jo_user_application/widgets/custom_commentField.dart';
import 'package:go_jo_user_application/widgets/custom_divider.dart';
import 'package:go_jo_user_application/widgets/custom_subTitleText.dart';

//codded by zain

class PlaceInfoScreen extends StatefulWidget {
  const PlaceInfoScreen({super.key});

  @override
  State<PlaceInfoScreen> createState() => _PlaceInfoScreenState();
}

class _PlaceInfoScreenState extends State<PlaceInfoScreen> {
  bool isExpended=false;
  bool showAllComments = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){},
            icon: Transform.rotate(
              angle: math.pi,
              child: Icon(
                Icons.double_arrow_rounded,
                size: 50.sp,
                color: Color(0xff0B3647),

              ),
            )
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
                    children: [
                      ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Image.network(
                        "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/1bd1dc34-d999-4be9-b141-906607eb2124/d7dwoy2-ec57ffe3-0a33-43ea-8720-916052f047cb.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwic3ViIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsImF1ZCI6WyJ1cm46c2VydmljZTpmaWxlLmRvd25sb2FkIl0sIm9iaiI6W1t7InBhdGgiOiIvZi8xYmQxZGMzNC1kOTk5LTRiZTktYjE0MS05MDY2MDdlYjIxMjQvZDdkd295Mi1lYzU3ZmZlMy0wYTMzLTQzZWEtODcyMC05MTYwNTJmMDQ3Y2IuanBnIn1dXX0.btXAGJIq2-qvrsZI25FvHtK3xeC_yYJz3SfJshuzB_Q",
                        height: 120.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      ),
                      Text(
                          "Petra",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 45.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      Positioned(
                        top: 5.h,
                        right: 5.w,
                        child: IconButton(
                          onPressed: (){

                          },
                            icon: Icon(Icons.favorite_border,
                            color: Colors.white,
                              size: 30.sp,
                            ),
                        ),
                      ),
                    ],
                  ),
            SizedBox(
              height: 10.h,
            ),
            Text.rich(
              maxLines: isExpended ? null : 3,
              overflow: isExpended? null : TextOverflow.ellipsis,
              TextSpan(
                children: [
                  TextSpan(
                    text: "Petra ",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.sp,
                    ),
                  ),
                  TextSpan(
                    text: 'The area around Petra has been inhabited from as early as 7000 BC, and was settled by the Nabataeans hhhhhhhhhhhhhhhhhhh hhhhhhhhh  hjkhj hjhkjl kjkj jk jkjkj jkj kjk jkj kj k jkj k jkj k jk jk jk jk jk jk jk jkj kj k jk jk',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  isExpended=!isExpended;

                });
              },
              child: Text(
                isExpended? 'Read Less':'Read More',
                textAlign: TextAlign.center,
                style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
              ),
              ),
            ),
            customDivider(),
            customTitleText(title: 'Details'),
            SizedBox(
              height: 10.h,
            ),
            Wrap(
              spacing: 30.w,
              runSpacing: 20.h,
              children: [
                Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xff23627E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Season',
                        style:  TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                          fontSize: 17.sp
                        ),
                      ),
                       SizedBox(width: 6.w),
                      Icon(Icons.sunny, color: Colors.yellow),
                    ],
                  ),
                   SizedBox(height: 6),
                  Text(
                    'preferred in spring',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13.sp, color: Colors.white70),
                  ),
                ],
              ),
            ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xff23627E),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '7 wonders',
                            style:  TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                                fontSize: 17.sp
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Icon(Icons.star, color: Colors.yellow),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        '7 wonders of the world',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13.sp, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xff23627E),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '45454 visitors ',
                            style:  TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                                fontSize: 17.sp
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Icon(Icons.people),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'Tourists in 2021',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13.sp, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            customDivider(),
            customTitleText(title: 'Photos'),
            SizedBox(height: 10.h,),
            SizedBox(
              height: 200.h,
              child: ListView.builder(
                scrollDirection:Axis.horizontal ,
                  itemCount: 5,
                  itemBuilder: (context,index){
                  return Container(
                    margin: EdgeInsets.only(right: 20.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.network('https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/1bd1dc34-d999-4be9-b141-906607eb2124/d7dwoy2-ec57ffe3-0a33-43ea-8720-916052f047cb.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwic3ViIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsImF1ZCI6WyJ1cm46c2VydmljZTpmaWxlLmRvd25sb2FkIl0sIm9iaiI6W1t7InBhdGgiOiIvZi8xYmQxZGMzNC1kOTk5LTRiZTktYjE0MS05MDY2MDdlYjIxMjQvZDdkd295Mi1lYzU3ZmZlMy0wYTMzLTQzZWEtODcyMC05MTYwNTJmMDQ3Y2IuanBnIn1dXX0.btXAGJIq2-qvrsZI25FvHtK3xeC_yYJz3SfJshuzB_Q',
                      width: 160.w,fit: BoxFit.cover,height: 200.h,
                      ),
                    ),
                  );


                  }
              ),
            ),//list of photos
            customDivider(),
            customTitleText(title: 'Rating'),
            Row(
              children: [
                RatingBarIndicator(
                  rating: 4.8, // هون قيمة التقييم
                  itemCount: 5,
                  itemSize: 45.sp,
                  unratedColor: Colors.grey.shade300,
                  itemBuilder: (context, _) =>
                      Icon(Icons.star, color: Colors.amber),
                ),
                 SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "4.8",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 20.sp),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h,),
            customTitleText(title: 'Comments'),
            SizedBox(height: 10.h),
            SizedBox(
              height: 130.h,
              child: ListView.builder(
                itemCount: showAllComments ? 5 : 2,
                  itemBuilder:(context,index){

                    return customCommentField( name: 'Zain', comment: 'wow great place');

                  }
                  ),
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  showAllComments=!showAllComments;
                });
              },
              child: Text(
                showAllComments? 'Less Comments':'More Comments',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),
              ),
            ),
            customDivider(),
            Row(
              children: [
                customTitleText(title: 'Rate'),
                SizedBox(width: 20.w,),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) =>
                  const Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (rating) {
                    //debugPrint("New Rating: $rating");
                  },
                  ),
              ],
            )











          ],
        ),
      ),

    );
  }
}
