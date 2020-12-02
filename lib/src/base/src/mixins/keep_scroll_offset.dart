part of '../../base.dart';

mixin KeepScrollOffsetMixin<T extends StatefulWidget> on State<T> {
  double get lastOffset;
  set lastOffset(double value);

  final ScrollController scrollController = ScrollController();

  @protected
  @mustCallSuper
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      lastOffset = scrollController.offset;
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.jumpTo(lastOffset);
    });
  }
}
