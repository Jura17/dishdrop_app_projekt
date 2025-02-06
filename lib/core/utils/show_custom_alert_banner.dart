import 'package:alert_banner/exports.dart';
import 'package:flutter/material.dart';

void showCustomAlertBanner(context, Color color, String msg) {
  showAlertBanner(
      context,
      () {},
      Container(
        color: color,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            textAlign: TextAlign.center,
            msg,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      alertBannerLocation: AlertBannerLocation.bottom);
}
