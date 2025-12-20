part of 'infinite_pageview.dart';

class _InfiniteScrollPosition extends ScrollPositionWithSingleContext {
  _InfiniteScrollPosition({
    required super.physics,
    required super.context,
    super.initialPixels,
    super.keepScrollOffset,
    super.oldPosition,
    super.debugLabel,
    this.negativeScroll = false,
    this.didChangeViewportDimension,
  });

  final bool negativeScroll;
  final void Function(double viewportDimension)? didChangeViewportDimension;

  void _forceNegativePixels(double value) {
    super.forcePixels(-value);
  }

  @override
  void saveScrollOffset() {
    if (!negativeScroll) {
      super.saveScrollOffset();
    }
  }

  @override
  void restoreScrollOffset() {
    if (!negativeScroll) {
      super.restoreScrollOffset();
    }
  }

  @override
  double get minScrollExtent => double.negativeInfinity;

  @override
  double get maxScrollExtent => double.infinity;

  @override
  bool applyViewportDimension(double viewportDimension) {
    final result = super.applyViewportDimension(viewportDimension);
    didChangeViewportDimension?.call(viewportDimension);
    return result;
  }
}
