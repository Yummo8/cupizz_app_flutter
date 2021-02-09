import 'package:cupizz_app/src/base/base.dart';
import 'package:flutter/foundation.dart';

class PrimaryScaffold extends StatelessWidget {
  final Widget body;
  final bool isLoading;
  final ScrollController scrollController;
  final Widget footer;
  final Widget bottomNavigationBar;
  final PreferredSizeWidget appBar;
  final Widget drawer;
  final Widget floatingActionButton;
  final Function onBack;

  PrimaryScaffold({
    Key key,
    this.body,
    this.isLoading = false,
    this.scrollController,
    this.footer,
    this.bottomNavigationBar,
    this.appBar,
    this.drawer,
    this.onBack,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      appBar: appBar,
      backgroundColor: context.colorScheme.background,
      drawer: drawer,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
    return RouterPage(
      onWillPop: onBack ??
          () async {
            Get.back(canPop: true);
            return true;
          },
      child: Stack(
        children: [
          if (context.height > context.width && kIsWeb)
            Center(
              child: SizedBox(
                width: context.height * 9 / 19.5,
                child: scaffold,
              ),
            )
          else
            scaffold,
          if (isLoading)
            Positioned.fill(
              child: Container(
                color: context.colorScheme.background.withOpacity(0.5),
                child: LoadingIndicator(),
              ),
            )
        ],
      ),
    );
  }
}
