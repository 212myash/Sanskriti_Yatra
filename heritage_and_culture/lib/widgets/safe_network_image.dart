import 'package:flutter/material.dart';

class SafeNetworkImage extends StatefulWidget {
  final String imagePath;
  final BoxFit fit;
  final double? width;
  final double? height;
  final String fallbackAsset;

  const SafeNetworkImage({
    super.key,
    required this.imagePath,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.fallbackAsset = 'assets/icon/heritage.png',
  });

  @override
  State<SafeNetworkImage> createState() => _SafeNetworkImageState();
}

class _SafeNetworkImageState extends State<SafeNetworkImage> {
  @override
  Widget build(BuildContext context) {
    final path = widget.imagePath.trim();
    final isNetwork = path.startsWith('http://') || path.startsWith('https://');

    if (path.isEmpty) {
      return _asset(widget.fallbackAsset, context);
    }

    if (!isNetwork) {
      return _asset(path, context);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final dpr = MediaQuery.of(context).devicePixelRatio;
        final targetWidth = widget.width ??
            (constraints.hasBoundedWidth ? constraints.maxWidth : 400);
        final targetHeight = widget.height;

        final cacheWidth = _cacheDimension(targetWidth, dpr);
        final cacheHeight =
            targetHeight == null ? null : _cacheDimension(targetHeight, dpr);

        return Image.network(
          path,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
          filterQuality: FilterQuality.low,
          cacheWidth: cacheWidth,
          cacheHeight: cacheHeight,
          loadingBuilder: (context, child, progress) {
            if (progress == null) {
              return child;
            }
            return SizedBox(
              width: widget.width,
              height: widget.height,
              child: const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return _asset(widget.fallbackAsset, context);
          },
        );
      },
    );
  }

  Widget _asset(String path, BuildContext context) {
    final dpr = MediaQuery.of(context).devicePixelRatio;
    final cacheWidth =
        widget.width == null ? null : _cacheDimension(widget.width!, dpr);
    final cacheHeight =
        widget.height == null ? null : _cacheDimension(widget.height!, dpr);

    return Image.asset(
      path,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      filterQuality: FilterQuality.low,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
      errorBuilder: (context, error, stackTrace) {
        return const Center(child: Icon(Icons.broken_image, size: 64));
      },
    );
  }

  int _cacheDimension(double logicalSize, double dpr) {
    final physical = (logicalSize * dpr).round();
    return physical.clamp(96, 2048);
  }
}
