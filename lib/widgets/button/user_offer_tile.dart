import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserOfferTile extends StatelessWidget {
  final double offerValue;
  final String buyerName;
  final String buyerCityState;
  final void Function() onOfferAccepted;

  const UserOfferTile({
    Key? key,
    required this.offerValue,
    required this.buyerName,
    required this.buyerCityState,
    required this.onOfferAccepted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Flexible(
          flex: 1,
          child: Icon(
            Icons.person,
            size: 50,
          ),
        ),
        Flexible(
          flex: 4,
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\$${NumberFormat("#,###").format(offerValue.floor())}",
                  style: const TextStyle(
                      color: Color(0xFF014F8B),
                      fontWeight: FontWeight.w900,
                      fontSize: 18),
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  "$buyerName, $buyerCityState",
                  style: TextStyle(fontSize: 13),
                )
              ],
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: Container(
              height: 40,
              decoration: BoxDecoration(
                  color: const Color(0xFF014F8B),
                  borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                  onPressed: onOfferAccepted,
                  child: const Text(
                    "Accept Offer",
                    style: TextStyle(color: Colors.white),
                  ))),
        )
      ],
    );
  }
}
