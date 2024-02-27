import 'package:flutter/material.dart';

class LoadingImage extends StatelessWidget {
  const LoadingImage({
    required this.url,
    this.height,
    this.width,
    Key? key,
  }) : super(key: key);

  final String url;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      width: height,
      height: width,
      errorBuilder: (c, err, stack) {
        return const Center(child: Text('error'));
      },
      frameBuilder: (c, image, frame, sync) {
        if (!sync && frame == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return image;
      },
    );
  }
}
