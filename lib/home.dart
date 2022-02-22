import 'dart:developer';
import 'package:ip_info/keyvalue.dart';
import 'package:flutter/material.dart';
import 'constants.dart' as val;
import 'package:lottie/lottie.dart';
import 'internet.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> myInfo = {};

  Future<void> updateMyInfo(BuildContext context) async {
    myInfo = await getInfo();
    if (myInfo.isEmpty) {
      const snackBar = SnackBar(content: Text("Failed to refresh Try Again!"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      const snackBar = SnackBar(content: Text("Refreshed sucessfully"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "IP INFO",
          style: TextStyle(color: val.pimaryTextColor),
        ),
      ),
      body: Column(
        children: [
          IpAndCountry(
            ipAddress: myInfo["query"],
            country: myInfo["country"],
          ),
          myButton(context),
          Expanded(
            child: RefreshIndicator(
                onRefresh: () async {
                  updateMyInfo(context).whenComplete(
                    () {
                      setState(() {});
                    },
                  );
                },
                child: myInfo.isNotEmpty
                    ? ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          log("building with index value $index");
                          return KeyValues(
                            item: myInfo.keys.toList()[index],
                            value: myInfo.values.toList()[index].toString(),
                          );
                        },
                        itemCount: myInfo.length,
                      )
                    : CustomScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        slivers: [
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Lottie.asset(
                                      "assets/lottie/pull-down-scroll-down.zip"),
                                ),
                                const Center(
                                  child: Text("Pull down to refresh"),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
          ),
        ],
      ),
    );
  }

  Padding myButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        onPressed: () {
          updateMyInfo(context).whenComplete(
            () {
              setState(() {});
            },
          );
        },
        child: const Text(
          "Refresh",
          style: TextStyle(
            fontFamily: "Baloo 2",
            fontSize: 18,
          ),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(val.accentColor),
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5))),
      ),
    );
  }
}

class IpAndCountry extends StatefulWidget {
  const IpAndCountry({
    Key? key,
    this.ipAddress,
    this.country,
  }) : super(key: key);

  final String? ipAddress;
  final String? country;

  @override
  State<IpAndCountry> createState() => _IpAndCountryState();
}

class _IpAndCountryState extends State<IpAndCountry> {
  @override
  Widget build(BuildContext context) {
    const myTextStyle = TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      fontFamily: "Baloo 2",
      color: val.pimaryTextColor,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              widget.ipAddress ?? '_._._._',
              style: myTextStyle,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            widget.country ?? "Refresh to show country",
            style: myTextStyle,
          ),
        ),
      ],
    );
  }
}
