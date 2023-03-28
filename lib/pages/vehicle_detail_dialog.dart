import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tto_apps/constant/text.dart';

class VehicleDetailDialog extends StatelessWidget {
  VehicleDetailDialog({
    super.key,
    this.urlImageIdCard,
    this.urlImageDriver,
    this.vehicleLicense,
  });

  String? urlImageIdCard;
  String? urlImageDriver;
  String? vehicleLicense;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vehicleLicense!,
                    style: helveticaText.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 300,
                    width: 300,
                    child: Image.network(urlImageDriver!, fit: BoxFit.contain),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 300,
                    width: 300,
                    child: Image.network(urlImageIdCard!, fit: BoxFit.contain),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close),
            ),
          )
        ],
      ),
    );
  }
}
