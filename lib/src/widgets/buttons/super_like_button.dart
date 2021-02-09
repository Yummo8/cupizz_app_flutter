import 'dart:async';

import 'package:cupizz_app/src/base/base.dart';
import 'package:google_fonts/google_fonts.dart';

class SuperLikeButton extends StatefulWidget {
  final Function onPressed;

  const SuperLikeButton({Key key, this.onPressed}) : super(key: key);

  @override
  SuperLikeButtonState createState() => SuperLikeButtonState();
}

class SuperLikeButtonState extends State<SuperLikeButton> {
  bool _showingRemain = false;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    resetTimer();
  }

  void resetTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(5.seconds, (timer) {
      showRemain();
    });
  }

  Future showRemain() async {
    _showingRemain = true;
    setState(() {});
    _timer?.cancel();
    await 2.delay();
    _showingRemain = false;
    setState(() {});
    resetTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
        controllers: [CurrentUserController],
        builder: (context, snapshot) {
          final model = snapshot<CurrentUserModel>();
          return GestureDetector(
            onTap: model.currentUser.getRemainingSuperLike > 0
                ? widget.onPressed
                : () {
                    Fluttertoast.showToast(
                      msg: Strings.error.outOfSuperLike,
                    );
                  },
            child: AnimatedSwitcher(
              duration: 500.milliseconds,
              transitionBuilder: (child, animation) => ScaleTransition(
                scale: animation,
                child: FadeTransition(opacity: animation, child: child),
              ),
              child: Container(
                key: ValueKey<bool>(_showingRemain &&
                    model.currentUser.getRemainingSuperLike > 0),
                child: _showingRemain &&
                        model.currentUser.getRemainingSuperLike > 0
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          model.currentUser.getRemainingSuperLike.toString(),
                          style: GoogleFonts.carterOne(
                            fontSize: 26,
                            color: Colors.yellow[800],
                            shadows: [
                              Shadow(
                                blurRadius: 1.0,
                                color: Colors.black,
                                offset: Offset(1.0, 1.0),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Icon(
                        Icons.star,
                        color: model.currentUser.getRemainingSuperLike > 0
                            ? context.colorScheme.primary
                            : context.colorScheme.onSurface,
                        size: 30,
                      ),
              ),
            ),
          );
        });
  }
}
