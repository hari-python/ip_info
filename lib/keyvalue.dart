import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ip_info/constants.dart' as val;

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
