import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late final RewardedAd rewardedAd;
  final String rewardedUintId = "ca-app-pub-3940256099942544/5224354917";
  @override
  void initState() {
    super.initState();
    // Load ads.
    _loadRewardedAd();
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: rewardedUintId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          print("$ad loaded");
          rewardedAd = ad;

          // set on full screen content call back
          _setFullScreenContentCallback();
        },
        onAdFailedToLoad: (LoadAdError error) {
          print("Failed to load Ad: $error");
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          height: 30,
        ),
        Container(
          width: 350,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.blue.shade900,
            border: Border.all(width: 1.0, color: Colors.white),
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 10, color: Colors.black, offset: Offset(1, 3))
            ],
          ),
          child: const Text(
            "User could claim game reward by pressing this button. In exchange, the app could achieve Admod earning used for donation to charity organizations",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 32,
        ),
        InkWell(
          onTap: _showRewardedAd,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            height: 100,
            decoration: BoxDecoration(
              color: Colors.blue[400],
              border: Border.all(width: 3.0, color: Colors.blueAccent),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 10, color: Colors.black, offset: Offset(1, 3))
              ],
            ),
            child: const Text(
              "Show ad",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 35),
            ),
          ),
        ),
      ]),
    );
  }

  void _setFullScreenContentCallback() {
    rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
      //when ad  shows fullscreen
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print("$ad onAdShowedFullScreenContent"),
      //when ad dismissed by user
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print("$ad onAdDismissedFullScreenContent");

        //dispose the dismissed ad
        ad.dispose();
      },
      //when ad fails to show
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print("$ad  onAdFailedToShowFullScreenContent: $error ");
        //dispose the failed ad
        ad.dispose();
      },

      //when impression is detected
      onAdImpression: (RewardedAd ad) => print("$ad Impression occured"),
    );
  }

  //show ad method
  void _showRewardedAd() {
    rewardedAd.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
      num amount = rewardItem.amount;
      print("You earned: $amount");
    });
  }
}
