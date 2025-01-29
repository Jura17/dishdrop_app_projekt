/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/appetizers_category_img.jpg
  AssetGenImage get appetizersCategoryImg =>
      const AssetGenImage('assets/images/appetizers_category_img.jpg');

  /// File path: assets/images/drinks_category_img.jpg
  AssetGenImage get drinksCategoryImg =>
      const AssetGenImage('assets/images/drinks_category_img.jpg');

  /// File path: assets/images/main_courses_category_img.jpeg
  AssetGenImage get mainCoursesCategoryImg =>
      const AssetGenImage('assets/images/main_courses_category_img.jpeg');

  /// File path: assets/images/pasta.jpg
  AssetGenImage get pasta => const AssetGenImage('assets/images/pasta.jpg');

  /// File path: assets/images/pistacciopastapesto.jpg
  AssetGenImage get pistacciopastapesto =>
      const AssetGenImage('assets/images/pistacciopastapesto.jpg');

  /// File path: assets/images/pizza.jpg
  AssetGenImage get pizza => const AssetGenImage('assets/images/pizza.jpg');

  /// File path: assets/images/salat_category_img.jpg
  AssetGenImage get salatCategoryImg =>
      const AssetGenImage('assets/images/salat_category_img.jpg');

  /// File path: assets/images/salmon.jpg
  AssetGenImage get salmon => const AssetGenImage('assets/images/salmon.jpg');

  /// File path: assets/images/shiitake.jpg
  AssetGenImage get shiitake =>
      const AssetGenImage('assets/images/shiitake.jpg');

  /// File path: assets/images/side_dishes_category_img.jpg
  AssetGenImage get sideDishesCategoryImg =>
      const AssetGenImage('assets/images/side_dishes_category_img.jpg');

  /// File path: assets/images/sweet_stuff_category_img.jpg
  AssetGenImage get sweetStuffCategoryImg =>
      const AssetGenImage('assets/images/sweet_stuff_category_img.jpg');

  /// File path: assets/images/tantanmen_ramen.jpg
  AssetGenImage get tantanmenRamen =>
      const AssetGenImage('assets/images/tantanmen_ramen.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [
        appetizersCategoryImg,
        drinksCategoryImg,
        mainCoursesCategoryImg,
        pasta,
        pistacciopastapesto,
        pizza,
        salatCategoryImg,
        salmon,
        shiitake,
        sideDishesCategoryImg,
        sweetStuffCategoryImg,
        tantanmenRamen
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
