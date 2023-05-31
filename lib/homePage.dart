import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'viewClock.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formatTime = DateFormat('HH:mm').format(now);
    var formatDate = DateFormat('EEE, d MMM').format(now);
    var timezoneStr = now.timeZoneOffset.toString().split(':').first;
    var offsetSign = '';
    if (!timezoneStr.startsWith('-')) offsetSign = '+';
    print(timezoneStr);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Color(0xFF2D2F41),
          body: Row(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  textButton('Clock', 'assetss/images/clock.png'),
                  textButton('Alarm', 'assetss/images/alarm.png'),
                  textButton('Timer', 'assetss/images/timer_icon.png'),
                  textButton('Stopwatch', 'assetss/images/stopwatch.png'),
                ],
              ),
              VerticalDivider(
                color: Colors.white54,
                width: 1,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 60),
                  alignment: Alignment.center,
                  color: Color(0xFF2D2F41),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Text(
                          'Clock',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              formatTime,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 64),
                            ),
                            Text(
                              formatDate,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                          flex: 3,
                          //fit: FlexFit.tight,
                          child: Align(
                              alignment: Alignment.center,
                              child: ClockView(
                                size: MediaQuery.of(context).size.height / 4,
                              ))),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Timezone',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.language,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'UTC' + offsetSign + timezoneStr,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Padding textButton(String title, String image) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: TextButton(
        onPressed: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              image,
              height: 40,
              scale: 1,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              title,
              style: GoogleFonts.robotoSerif(
                color: Colors.white,
                fontSize: 15,
              ),
            )
          ],
        ),
      ),
    );
  }
}
