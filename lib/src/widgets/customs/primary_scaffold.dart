part of 'custom_widgets.dart';

class PrimaryScaffold extends StatefulWidget {
  final Widget body;
  final bool isLoading;
  final ScrollController scrollController;
  final Widget footer;

  PrimaryScaffold(
      {Key key,
      this.body,
      this.isLoading = false,
      this.scrollController,
      this.footer})
      : super(key: key);

  @override
  _PrimaryScaffoldState createState() => _PrimaryScaffoldState();
}

class _PrimaryScaffoldState extends State<PrimaryScaffold> {
  ScrollController scrollController;

  bool canPop = false;
  bool isScrolling = false;
  bool showGoToTop = false;

  @override
  void initState() {
    super.initState();

    scrollController = widget.scrollController ?? ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        canPop = Navigator.of(context).canPop();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return momentum.RouterPage(
      child: Scaffold(
        backgroundColor: context.colorScheme.background,
        body: _buildBody(context),
      ),
    );
  }

  _buildBody(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scroll) {
        if (scrollController.offset > 200 && !showGoToTop) {
          setState(() {
            showGoToTop = true;
          });
        } else if (scrollController.offset < 200 && showGoToTop) {
          setState(() {
            showGoToTop = false;
          });
        }

        if (scroll is ScrollEndNotification) {
          if (isScrolling) {
            setState(() {
              isScrolling = false;
            });
          }
        } else if (scroll is ScrollStartNotification) {
          if (!isScrolling) {
            setState(() {
              isScrolling = true;
            });
          }
        }
        return true;
      },
      child: Center(
        child: SingleChildScrollView(
          controller: scrollController,
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              if (widget.body != null) widget.body,
              if (widget.footer != null) widget.footer,
            ],
          ),
        ),
      ),
    );
  }
}
