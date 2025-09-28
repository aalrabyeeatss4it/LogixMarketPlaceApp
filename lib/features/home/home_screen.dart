import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logix_market_place/common/nav/drawer_custom.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/bottom_nav_bar_custom.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerCustom(),
      appBar: AppBarCustom(title: "home"),
      bottomNavigationBar: BottomNavBarCustom(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                  child: SizedBox(
                      width: 1.sw,
                      height: 0.25.sh,
                      child: Image.asset("assets/home.png", fit: BoxFit.cover)),
                ),
                Container(
                  width: 1.sw,
                  height: 0.25.sh,
                  color: Colors.black.withOpacity(0.3),
                ),
                Positioned(
                    bottom: -30.h, // push it outside the image
                    left: 20.w,
                    right: 20.w,
                    child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(30.r),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Search...",
                            prefixIcon: const Icon(Icons.search),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.r),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 12.h,
                              horizontal: 16.w,
                            ),
                          ),
                        ))),
              ],
            ),
            SizedBox(height: 50.h),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("أبرز الفئات",
                          style: Theme.of(context).textTheme.titleLarge),
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Text("استعراض الكل"),
                      )
                    ],
                  ),
                  SizedBox(height: 10.h),
                  // Your content here
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                          child: SizedBox(
                        width: 140,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(width:60, height: 60,child: Image.asset("assets/projects.png",fit: BoxFit.fill,)),
                              Text("خدمات إضافية للمشاريع",style: Theme.of(context).textTheme.titleSmall),
                            ],
                          ),
                        ),
                      )),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  // Your content here
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
