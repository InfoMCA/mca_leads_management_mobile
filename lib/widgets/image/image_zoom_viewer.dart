import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ImageZoomViewer extends StatelessWidget {
  final String url;

  const ImageZoomViewer(
    this.url, {
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CachedNetworkImage(
        imageUrl: url,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.device_unknown),
      ),
      onTap: () {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) => InteractiveViewer(
                  child: GestureDetector(
                    onTap: () => Modular.to.pop(),
                    child: CachedNetworkImage(
                      imageUrl: url,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.device_unknown),
                    ),
                  ),
                ));
      },
    );
  }
}
