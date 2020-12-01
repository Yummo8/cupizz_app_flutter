part of '../../base.dart';

mixin KeepScrollOffsetMixin<T extends StatefulWidget> on State<T> {
  static double _lastScrollOffset = 0;
  final ScrollController scrollController = ScrollController();

  @protected
  @mustCallSuper
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      _lastScrollOffset = scrollController.offset;
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.jumpTo(_lastScrollOffset);
    });
  }
}
