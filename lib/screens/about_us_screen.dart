import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.aboutme1),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 0, 217, 255),
                        Color.fromARGB(255, 155, 218, 243),
                        Colors.white10,
                      ],
                    ),
                  ),
                ),
                //developer avatar
                Positioned(
                    bottom: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? -50
                        : -100,
                    right: 0,
                    left: 0,
                    child: CircleAvatar(
                      child: Image.asset(
                        'assets/developer.png',
                        fit: BoxFit.cover,
                      ),
                      radius: 100,
                    )),
              ],
            ),
            const SizedBox(
              height: 70,
            ),
            //title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                AppLocalizations.of(context)!.aboutme2,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
            ),
            //developer details
            Padding(
              padding: const EdgeInsets.all(14),
              child: Text(
                AppLocalizations.of(context)!.aboutme3,
                style: const TextStyle(
                    fontSize: 17,
                    overflow: TextOverflow.visible,
                    fontStyle: FontStyle.italic),
              ),
            ),
            //contact me title
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                AppLocalizations.of(context)!.contactme,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
            ),
            //social media developer accounts
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    primary: Colors.white70,
                  ),
                  onPressed: () {
                    _launchURL('https://facebook.com/monther.almomani/');
                  },
                  child: Image.asset(
                    'assets/logos/facebook_logo.png',
                    width: 75,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      primary: Colors.white70),
                  onPressed: () {
                    _launchURL('https://twitter.com/eng_abo_habib');
                  },
                  child: Image.asset(
                    'assets/logos/twitter_logo.png',
                    width: 75,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      primary: Colors.white70),
                  onPressed: () {
                    _launchURL('https://instagram.com/eng.abo.habib');
                  },
                  child: Image.asset(
                    'assets/logos/instagram_logo.png',
                    width: 75,
                  ),
                ),
              ],
            ),
            //support developer
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.supportme,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        primary: Colors.white70),
                    onPressed: () {
                      _launchURL('https://paypal.me/abohabib98');
                    },
                    child: Image.asset(
                      'assets/logos/paypal_logo.png',
                      width: 75,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
