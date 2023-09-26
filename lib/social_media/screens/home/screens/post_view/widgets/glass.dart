library glassmorphism;

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GlassmorphicFlexContainer extends StatelessWidget {
  @override
  final Key? key;

  final AlignmentGeometry? alignment;

  final EdgeInsetsGeometry? padding;

  final int? flex;

  final EdgeInsetsGeometry? margin;

  final Matrix4? transform;

  final Widget? child;

  final double borderRadius;
  final BoxShape shape;
  final BoxConstraints? constraints;
  final double border;
  final double blur;
  final LinearGradient linearGradient;
  final LinearGradient borderGradient;
  GlassmorphicFlexContainer(
      {this.key,
      this.child,
      this.alignment,
      this.padding,
      this.shape = BoxShape.rectangle,
      this.margin,
      this.transform,
      required this.borderRadius,
      required this.linearGradient,
      required this.border,
      required this.blur,
      required this.borderGradient,
      this.constraints,
      this.flex = 1})
      : assert(margin == null || margin.isNonNegative),
        assert(padding == null || padding.isNonNegative),
        assert(
          flex! >= 1,
          'Flex value can be less than 1 : $flex. Please Provide a flex value > 1',
        ),
        assert(constraints == null || constraints.debugAssertIsValid()),
        super(key: key);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<AlignmentGeometry>('alignment', alignment, showName: false, defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('padding', padding, defaultValue: null));
    properties.add(DiagnosticsProperty<BoxConstraints>('constraints', constraints, defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('margin', margin, defaultValue: null));
    properties.add(ObjectFlagProperty<Matrix4>.has('transform', transform));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex!,
      child: Container(
        key: key,
        alignment: alignment,
        padding: padding,
        constraints: const BoxConstraints.tightForFinite(),
        transform: transform,
        child: Stack(
          children: [
            ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(borderRadius),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur * 2),
                child: Container(
                  alignment: alignment ?? Alignment.topLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    gradient: linearGradient,
                  ),
                ),
              ),
            ),
            GlassmorphicBorder(
              strokeWidth: border,
              radius: borderRadius,
              gradient: borderGradient,
            ),
            ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(borderRadius),
              child: Container(
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GlassmorphicContainer extends StatelessWidget {
  @override
  final Key? key;

  final AlignmentGeometry? alignment;

  final EdgeInsetsGeometry? padding;

  //final double width;
  final double? height;
  final Color? colour;
  final EdgeInsetsGeometry? margin;

  final Matrix4? transform;

  final Widget? child;

  final double borderRadius;
  final BoxShape shape;
  final BoxConstraints? constraints;

  // final double border;
  final double blur;
  //final LinearGradient linearGradient;
  //final LinearGradient borderGradient;
  GlassmorphicContainer({
    this.key,
    this.child,
    this.alignment,
    this.padding,
    this.shape = BoxShape.rectangle,
    BoxConstraints? constraints,
    this.margin,
    this.transform,
    //  required this.width,
    this.height,
    required this.borderRadius,
    // required this.linearGradient,
    //  required this.border,
    required this.blur,
    this.colour,
    //   required this.borderGradient,
  })  : assert(margin == null || margin.isNonNegative),
        assert(padding == null || padding.isNonNegative),
        assert(constraints == null || constraints.debugAssertIsValid()),
        constraints = constraints?.tighten(height: height) ?? BoxConstraints.tightFor(height: height),
        super(key: key);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<AlignmentGeometry>('alignment', alignment, showName: false, defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('padding', padding, defaultValue: null));
    properties.add(DiagnosticsProperty<BoxConstraints>('constraints', constraints, defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('margin', margin, defaultValue: null));
    properties.add(ObjectFlagProperty<Matrix4>.has('transform', transform));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      // width: width,
      margin: margin,
      alignment: alignment,
      constraints: constraints,
      height: height,
      transform: transform,
      child: Stack(
        alignment: alignment ?? Alignment.topLeft,
        children: [
          if (blur != 0 && borderRadius != 0) ...[
            ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius:
                  //  BorderRadius.only(
                  //     topLeft: Radius.circular(borderRadius),
                  //     topRight: Radius.circular(borderRadius)),
                  BorderRadius.circular(borderRadius),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur * 2),
                child: Container(
                  alignment: alignment ?? Alignment.topLeft,
                  decoration: BoxDecoration(
                    color: colour,
                    borderRadius:
                        // BorderRadius.only(
                        //     topLeft: Radius.circular(borderRadius),
                        //     topRight: Radius.circular(borderRadius)),
                        BorderRadius.circular(borderRadius),
                    // gradient: linearGradient,
                  ),
                ),
              ),
            ),
          ],
          // GlassmorphicBorder(
          //   strokeWidth: border,
          //   radius: borderRadius,
          //   width: width,
          //   height: height,
          //   gradient: borderGradient,
          // ),
          ClipRRect(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(borderRadius), topRight: Radius.circular(borderRadius)),
            //   borderRadius: BorderRadius.circular(borderRadius),
            child: Container(
              alignment: alignment,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

class GlassmorphicBorder extends StatelessWidget {
  final _GradientPainter _painter;
  final double _radius;
  final width;
  final height;
  GlassmorphicBorder({
    super.key,
    required double strokeWidth,
    required double radius,
    required Gradient gradient,
    this.height,
    this.width,
  })  : _painter = _GradientPainter(strokeWidth: strokeWidth, radius: radius, gradient: gradient),
        _radius = radius;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _painter,
      size: MediaQuery.of(context).size,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(_radius)),
        ),
        width: width,
        height: height,
      ),
    );
  }
}

class _GradientPainter extends CustomPainter {
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  _GradientPainter({required double strokeWidth, required double radius, required Gradient gradient})
      : strokeWidth = strokeWidth,
        radius = radius,
        gradient = gradient;
  final Paint paintObject = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    RRect innerRect2 =
        RRect.fromRectAndRadius(Rect.fromLTRB(strokeWidth, strokeWidth, size.width - (strokeWidth), size.height - (strokeWidth)), Radius.circular(radius - strokeWidth));

    RRect outerRect = RRect.fromRectAndRadius(Rect.fromLTRB(0, 0, size.width, size.height), Radius.circular(radius));
    paintObject.shader = gradient.createShader(Offset.zero & size);

    Path outerRectPath = Path()..addRRect(outerRect);
    Path innerRectPath2 = Path()..addRRect(innerRect2);
    canvas.drawPath(Path.combine(PathOperation.difference, outerRectPath, innerRectPath2), paintObject);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
