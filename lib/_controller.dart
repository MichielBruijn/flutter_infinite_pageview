part of 'infinite_pageview.dart';

/// Same as a [ScrollController] except it provides [ScrollPosition] objects with infinite bounds.
class InfiniteScrollController extends ScrollController {
  /// Creates a new [InfiniteScrollController]
  InfiniteScrollController({
    super.initialScrollOffset = 0.0,
    super.keepScrollOffset = true,
    super.debugLabel,
    super.onAttach,
    this.viewportFraction = 1.0,
    this.initialPage,
  });

  final double viewportFraction;
  final int? initialPage;
  var _isInitialPageApplied = false;

  @override
  ScrollPosition createScrollPosition(
    ScrollPhysics physics,
    ScrollContext context,
    ScrollPosition? oldPosition,
  ) {
    return _InfiniteScrollPosition(
      physics: physics,
      context: context,
      initialPixels: initialScrollOffset,
      keepScrollOffset: keepScrollOffset,
      oldPosition: oldPosition,
      debugLabel: debugLabel,
      didChangeViewportDimension: (viewportDimension) {
        if (!_isInitialPageApplied && initialPage != null && initialPage != 0) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            jumpToPage(initialPage!);
          });
          _isInitialPageApplied = true;
        }
      },
    );
  }

  void jumpToPage(int page) {
    assert(position.hasViewportDimension);
    jumpTo(page * position.viewportDimension);
  }
}
