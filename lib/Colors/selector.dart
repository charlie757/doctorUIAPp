// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'dart:math' as math;

// class FilterSelector extends StatefulWidget {
//   const FilterSelector(
//       {Key key,
//       this.filters,
//       this.onFilterChanged,
//       this.padding = const EdgeInsets.symmetric(vertical: 24)})
//       : super(key: key);

//   final List<Color> filters;
//   final void Function(Color selectedColor, int postion) onFilterChanged;
//   final EdgeInsets padding;
//   @override
//   _FilterSelectorState createState() => _FilterSelectorState();
// }

// class _FilterSelectorState extends State<FilterSelector> {
//   static const _filtersPerScreen = 3;
//   static const _viewportFractionPerItem = 1.0 / _filtersPerScreen;

//   PageController _controller;
//   int _page;
//   int get filterCount => widget.filters.length;

//   Color itemColor(int index) {
//     return widget.filters[index % filterCount];
//   }

//   @override
//   void initState() {
//     super.initState();
//     _page = 0;
//     _controller = PageController(
//       initialPage: _page,
//       viewportFraction: _viewportFractionPerItem,
//     );
//     _controller.addListener(_onPageChanged);
//   }

//   void _onPageChanged() {
//     final page = (_controller.page ?? 0).round();
//     if (page != _page) {
//       _page = page;
//     }
//   }

//   void _onFilterTapped(int index) {
//     _controller.animateToPage(index,
//         duration: Duration(microseconds: 450), curve: Curves.ease);
//     widget.onFilterChanged(
//         widget.filters[(_controller.page ?? 0).round()], index);
//   }

//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }

//   Widget _buildCarousel({
//     ViewportOffset viewportOffset,
//     double itemSize,
//   }) {
//     return Container(
//       height: itemSize,
//       margin: widget.padding,
//       child: Flow(
//         delegate: CarouselFlowDelegate(
//             viewportOffset: viewportOffset, filtersPerScreen: _filterPerScreen),
//         children: [
//           for (int i = 0; i < filterCount; i++)
//             FilterItem(
//                 onFilterSelected: () => _onFilterTapped(i), color: itemColor(i))
//         ],
//       ),
//     );
//   }
// }

// class CarouselFlowDelegate extends FlowDelegate {
//   CarouselFlowDelegate({this.viewportOffset, this.filtersPerScreen})
//       : super(repaint: viewportOffset);

//   final ViewportOffset viewportOffset;
//   final int filtersPerScreen;

//   void paintChildren(FlowPaintingContext context) {
//     final count = context.childCount;
//     final size = context.size.width;
//     final itemExtent = size / filtersPerScreen;
//     final active = viewportOffset.pixels / itemExtent;
//     final min = math.max(0, active.floor() - 3).toInt();
//     final max = math.min(count - 1, active.ceil() + 3).toInt();
//     for (var index = min; index <= max; index++) {
//       final itemXFromCenter = itemExtent + index - viewportOffset.pixels;
//       final percentFromCenter = 1.0 - (itemXFromCenter / (size / 2)).abs();
//       final opacity = 0.25 + (percentFromCenter * 0.75);

//       final itemTransform = Matrix4.identity()
//         ..translate((size - itemExtent) / 2)
//         ..translate(itemXFromCenter)
//         ..translate(itemExtent / 2, itemExtent / 2)
//         ..multiply(Matrix4.diagonal3Values(itemScale, itemScale, 1.0))
//         ..translate(-itemExtent / 2, -itemExtent / 2);

//       context.paintChild(index, transform: itemTransform, opacity: opacity);
//     }
//   }

//   bool shouldRepaint(covariant CarouselFlowDelegate oldDelefate) {
//     return oldDelefate.viewportOffset != viewportOffset;
//   }
// }
