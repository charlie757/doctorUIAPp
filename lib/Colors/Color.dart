// import 'dart:math';

// import 'package:flutter/material.dart';

// class Pulse extends StatefulWidget {
//   final Widget child;
//   final Color pulseColor;
//   final Curve curve;
//   final Duration duration;
//   final BlendMode blendmode;
//   final bool fadeIn;
//   final bool absorbConsecutivePointers;
//   final bool userLastPulseColorAsBackground;
//   final Function onComplete;
//   final Function onTap;
//   final AnimationController animationController;
//   final List colors;
//   final int index;

//   const Pulse(
//       {Key key,
//       this.child,
//       this.pulseColor,
//       this.curve,
//       this.duration,
//       this.blendmode,
//       this.fadeIn,
//       this.absorbConsecutivePointers,
//       this.userLastPulseColorAsBackground,
//       this.onComplete,
//       this.onTap,
//       this.animationController,
//       this.colors,
//       this.index})
//       : super(key: key);

//   @override
//   _PulseState createState() => _PulseState();
// }

// class _PulseState extends State<Pulse> with SingleTickerProviderStateMixin {
//   //Color _pulseColor;
//   Color _bgColor;

//   Animation _animation;
//   final _offsetNotifier = ValueNotifier(Offset.zero);

//   @override
//   void initState() {
//     super.initState();

//     _setupAnimation();
//   }

//   void _setupAnimation() {
//     if (widget.onComplete != null) {
//       widget.animationController.addStatusListener((status) {
//         if (widget.animationController.isCompleted) {
//           setState(() {
//             _bgColor = widget.pulseColor;
//           });
//           widget.onComplete();
//         } else {
//           setState(() {});
//         }
//       });
//     }
//     _setupTween();
//   }

//   _setupTween() {
//     _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//         parent: widget.animationController, curve: widget.curve ?? Curves.ease))
//       ..addListener(() {
//         setState(() {});
//       });
//   }

//   void dispose() {
//     widget.animationController.dispose();
//     super.dispose();
//   }

//   double _hypotenuse({Offset offset, Size size}) {
//     final _xDistance = offset.dx;

//     final _yDistance = offset.dy;
//     final _distanceFromOffsetToTheRightEdge = size.width - _xDistance;
//     final _distanceFromOffsetToTheTopEdge = size.height - _yDistance;

//     final _a = max(_distanceFromOffsetToTheRightEdge, _xDistance);
//     final _b = max(_distanceFromOffsetToTheTopEdge, _yDistance);

//     return sqrt(pow(_a, 2) + pow(_b, 2));
//   }

//   @override
//   void didupdateWidget(covariant Pulse oldWidget) {
//     super.didChangeDependencies();

//     if (widget.duration != oldWidget.duration) {
//       _setupAnimation();
//     } else if (widget.curve != oldWidget.curve) {
//       _setupTween();
//     }
//   }

//   Widget build(BuildContext context) {
//     return AbsorbPointer(
//       absorbing: widget.absorbConsecutivePointers &&
//           widget.animationController.isAnimating,
//       child: GestureDetector(
//         child: ValueListenableBuilder(
//             valueListenable: _offsetNotifier,
//             builder: (context, offset, child) {
//               return LayoutBuilder(builder: (context, constraints) {
//                 final _size = Size(constraints.maxWidth, constraints.maxHeight);
//                 final _circleRadius =
//                     _hypotenuse(offset: offset, size: _size) * _animation.value;
//                 return Container(
//                   color: widget.userLastPulseColorAsBackground? _bgColor : null,
//                   child: Opacity(opacity: widget.fadeIn ? _animation.value:1,
//                   child: CustomPaint(size: _size,
//                   painter: PulsePaint(
//                     color: widget.colors[widget.index],
//                     offset: offset,
//                     radius: _circleRadius,
//                     blendMode: widget.blendmode
//                   ),
//                   child: widget.child,
//                   ),
//                   ),
//                 );
//               });
//             }),
//       ),
//     );
//   }
// }

// class PulsePaint extends CustomPainter {
//   final BlendMode blendMode;
//   final double radius;
//   final Color color;
//   final Offset offset;

//   PulsePaint({this.radius, this.color, this.offset, this.blendMode});

//   void paint(Canvas canvas, Size size) {
//     final _paint = Paint()..color = color;

//     if (blendMode != null) {
//       _paint.blendMode = blendMode;
//     }
//     canvas.drawCircle(Offset(size.width / 2, size.height / 2), radius, _paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
