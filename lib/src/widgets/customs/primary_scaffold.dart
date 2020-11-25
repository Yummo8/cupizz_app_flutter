part of '../index.dart';

class PrimaryScaffold extends StatelessWidget {
  final Widget body;
  final bool isLoading;
  final ScrollController scrollController;
  final Widget footer;
  final Widget bottomNavigationBar;
  final PreferredSizeWidget appBar;
  final Widget drawer;

  PrimaryScaffold({
    Key key,
    this.body,
    this.isLoading = false,
    this.scrollController,
    this.footer,
    this.bottomNavigationBar,
    this.appBar,
    this.drawer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RouterPage(
      child: Scaffold(
        appBar: appBar,
        backgroundColor: context.colorScheme.background,
        drawer: drawer,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
