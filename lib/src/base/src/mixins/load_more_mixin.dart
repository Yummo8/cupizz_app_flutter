part of '../../base.dart';

mixin LoadmoreMixin<T extends StatefulWidget> on State<T> {
  final ScrollController scrollController = ScrollController();
  static const _LOCK_TIME = 2;
  bool _isLocking = false;

  double get bottomOffset => 20;

  @protected
  @mustCallSuper
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (!_isLocking) {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - bottomOffset) {
          _isLocking = true;
          onLoadMore();

          Future.delayed(Duration(seconds: _LOCK_TIME)).then((_) {
            _isLocking = false;
          });
        }
      }
    });
  }

  @protected
  onLoadMore();
}

mixin LoadmoreActionMixin {
  final ScrollController scrollController = ScrollController();
  static const _LOCK_TIME = 2;
  bool _isLocking = false;

  double get bottomOffset => 20;

  initLoadMore() {
    scrollController.addListener(() {
      if (!_isLocking) {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - bottomOffset) {
          _isLocking = true;
          onLoadMore();

          Future.delayed(Duration(seconds: _LOCK_TIME)).then((_) {
            _isLocking = false;
          });
        }
      }
    });
  }

  @protected
  onLoadMore();
}
