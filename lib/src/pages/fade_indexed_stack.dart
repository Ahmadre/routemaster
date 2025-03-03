import 'package:flutter/material.dart';

/// A widget that fades between children based on an index.
class FadeIndexedStack extends StatefulWidget {
  /// The index of the child to show.
  final int index;

  /// The children to show.
  final List<Widget> children;

  /// The duration of the fade animation.
  final Duration duration;

  /// How to align the children.
  final AlignmentGeometry alignment;

  /// The text direction to use for the children.
  final TextDirection? textDirection;

  /// How to clip the children.
  final Clip clipBehavior;

  /// How to size the children.
  final StackFit sizing;

  /// A widget that fades between children based on an index.
  const FadeIndexedStack({
    super.key,
    required this.index,
    required this.children,
    this.duration = const Duration(
      milliseconds: 250,
    ),
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.clipBehavior = Clip.hardEdge,
    this.sizing = StackFit.loose,
  });

  @override
  FadeIndexedStackState createState() => FadeIndexedStackState();
}

/// The state for a [FadeIndexedStack].
class FadeIndexedStackState extends State<FadeIndexedStack> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, duration: widget.duration);

  @override
  void didUpdateWidget(FadeIndexedStack oldWidget) {
    if (widget.index != oldWidget.index) {
      _controller.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: IndexedStack(
        index: widget.index,
        alignment: widget.alignment,
        textDirection: widget.textDirection,
        sizing: widget.sizing,
        children: widget.children,
      ),
    );
  }
}
