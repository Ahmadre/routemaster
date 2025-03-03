import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:routemaster/src/pages/fade_indexed_stack.dart';

/// Convenience widget for displaying a stack of pages.
class StackContents extends StatefulWidget {
  /// Creates a [StackContents] widget.
  const StackContents({super.key});

  @override
  State<StackContents> createState() => _StackContentsState();
}

class _StackContentsState extends State<StackContents> {
  @override
  Widget build(BuildContext context) {
    return HeroControllerScope(
      controller: MaterialApp.createMaterialHeroController(),
      child: WidgetPageStackNavigator(
        stack: StackPage.of(context).stack,
        builder: (BuildContext context, List<WidgetRoute<dynamic>> widgetRoutes) {
          return Scaffold(
            backgroundColor: Colors.black,
            extendBody: true,
            body: OrientationBuilder(
              builder: (context, orientation) {
                return LayoutBuilder(
                  builder: (context, rowDimens) {
                    if (orientation == Orientation.landscape) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: widgetRoutes.map((WidgetRoute route) {
                          final i = widgetRoutes.indexOf(route);
                          if (i == 0) {
                            return AnimatedContainer(
                                width: widgetRoutes.length > 1
                                    ? (rowDimens.maxWidth / widgetRoutes.length).toDouble()
                                    : rowDimens.maxWidth,
                                duration: const Duration(milliseconds: 250),
                                child: SafeArea(child: route.child));
                          }
                          return Flexible(
                            child: AnimatedContainer(
                              height: rowDimens.maxHeight,
                              width: widgetRoutes.length > 1
                                  ? (rowDimens.maxWidth / widgetRoutes.length).toDouble()
                                  : rowDimens.maxWidth,
                              duration: const Duration(milliseconds: 250),
                              child: AnimatedOpacity(
                                opacity: widgetRoutes.length > 1 ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 300),
                                child: SafeArea(child: route.child),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }
                    return FadeIndexedStack(
                      index: widgetRoutes.length - 1,
                      sizing: StackFit.expand,
                      children: widgetRoutes
                          .map(
                            (WidgetRoute route) => route.child,
                          )
                          .toList(),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
