import 'package:flutter/material.dart';
import 'constants.dart' as val;
import 'package:flutter/services.dart';
import 'internet.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> myInfo = {"country": "null", "query": 589};

  void updateMyInfo() async {
    myInfo = await getInfo();
  }

  @override
  Widget build(BuildContext context) {
    updateMyInfo();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Welcome",
          style: TextStyle(color: val.pimaryTextColor),
        ),
      ),
      body: Column(
        children: [
          IpAndCountry(
            ipAddress: myInfo["query"].toString(),
            country: myInfo["country"],
          ),
          ElevatedButton(
            onPressed: () {
              updateMyInfo();
              setState(() {});
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(myInfo.length, (index) {
                  return KeyValues(
                    item: myInfo.keys.toList()[index],
                    value: myInfo.values.toList()[index].toString(),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class KeyValues extends StatelessWidget {
  const KeyValues({
    Key? key,
    required this.item,
    required this.value,
  }) : super(key: key);

  final String item, value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          Clipboard.setData(ClipboardData(text: item + " : " + value));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Baloo 2",
                    ),
                  ),
                  const Icon(Icons.copy_all_rounded)
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      value,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Baloo 2",
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(val.accentColor),
        ),
      ),
    );
  }

  Text textInsideButton({required String text}) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: "Baloo 2",
      ),
    );
  }
}

class IpAndCountry extends StatefulWidget {
  const IpAndCountry({
    Key? key,
    required this.ipAddress,
    required this.country,
  }) : super(key: key);

  final String ipAddress;
  final String country;

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
              widget.ipAddress,
              style: myTextStyle,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            widget.country,
            style: myTextStyle,
          ),
        ),
      ],
    );
  }
}
