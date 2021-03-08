import 'dart:async';

import 'package:cupizz_app/src/base/base.dart';

class RotateAnimatedTextKit extends StatefulWidget {
  final List<String> text;

  final TextStyle? textStyle;

  final Duration? pause;

  final Duration? duration;

  final double? transitionHeight;

  final VoidCallback? onTap;

  final VoidCallback? onFinished;

  final void Function(int?, bool)? onNext;

  final void Function(int?, bool)? onNextBeforePause;

  final AlignmentGeometry alignment;

  final TextAlign textAlign;

  final int totalRepeatCount;

  final bool repeatForever;

  final bool isRepeatingAnimation;

  final bool displayFullTextOnTap;

  const RotateAnimatedTextKit(
      {Key? key,
      required this.text,
      this.textStyle,
      this.transitionHeight,
      this.pause,
      this.onNext,
      this.onNextBeforePause,
      this.onFinished,
      this.totalRepeatCount = 3,
      this.duration,
      this.onTap,
      this.alignment = const Alignment(0.0, 0.0),
      this.textAlign = TextAlign.start,
      this.displayFullTextOnTap = false,
      this.repeatForever = false,
      this.isRepeatingAnimation = true})
      : super(key: key);

  @override
  _RotatingTextState createState() => _RotatingTextState();
}

class _RotatingTextState extends State<RotateAnimatedTextKit>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  double? _transitionHeight;

  late Animation _fadeIn, _fadeOut, _slideIn, _slideOut;

  List<Widget> textWidgetList = [];

  Duration? _pause;

  final List<Map<String, dynamic>> _texts = [];

  int? _index;

  bool _isCurrentlyPausing = false;

  Timer? _timer;

  int? _currentRepeatCount;

  Duration? _duration;

  @override
  void initState() {
    super.initState();

    _pause = widget.pause ?? const Duration(milliseconds: 500);

    _index = -1;

    _currentRepeatCount = 0;

    _duration = widget.duration ?? const Duration(milliseconds: 2000);

    widget.text.forEach((text) {
      _texts.add({'text': text, 'pause': _pause});
    });

    _initAnimation();
    _nextAnimation();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller?.stop();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      _texts[_index!]['text'],
      style: widget.textStyle,
      textAlign: widget.textAlign,
    );
    return GestureDetector(
      onTap: _onTap,
      child: SizedBox(
        height: _transitionHeight,
        child: _isCurrentlyPausing || !_controller!.isAnimating
            ? textWidget
            : AnimatedBuilder(
                animation: _controller!,
                builder: (BuildContext context, Widget? child) {
                  return AlignTransition(
                    alignment: _slideIn.value.y != 0.0
                        ? _slideIn as Animation<AlignmentGeometry>
                        : _slideOut as Animation<AlignmentGeometry>,
                    child: Opacity(
                        opacity: _fadeIn.value != 1.0
                            ? _fadeIn.value
                            : _fadeOut.value,
                        child: child),
                  );
                },
                child: textWidget,
              ),
      ),
    );
  }

  void _initAnimation() {
    _controller = AnimationController(
      duration: _duration,
      vsync: this,
    );

    if (_index == 0) {
      _slideIn = AlignmentTween(
              begin: Alignment(-1.0, -1.0).add(widget.alignment) as Alignment?,
              end: Alignment(-1.0, 0.0).add(widget.alignment) as Alignment?)
          .animate(CurvedAnimation(
              parent: _controller!,
              curve: const Interval(0.0, 0.4, curve: Curves.linear)));

      _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _controller!,
          curve: const Interval(0.0, 0.4, curve: Curves.easeOut)));
    } else {
      _slideIn = AlignmentTween(
              begin: Alignment(-1.0, -1.0).add(widget.alignment) as Alignment?,
              end: Alignment(-1.0, 0.0).add(widget.alignment) as Alignment?)
          .animate(CurvedAnimation(
              parent: _controller!,
              curve: const Interval(0.0, 0.4, curve: Curves.linear)));

      _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _controller!,
          curve: const Interval(0.0, 0.4, curve: Curves.easeOut)));
    }

    _slideOut = AlignmentTween(
      begin: Alignment(-1.0, 0.0).add(widget.alignment) as Alignment?,
      end: Alignment(-1.0, 1.0).add(widget.alignment) as Alignment?,
    ).animate(CurvedAnimation(
        parent: _controller!,
        curve: const Interval(0.7, 1.0, curve: Curves.linear)));

    _fadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: _controller!,
        curve: const Interval(0.7, 1.0, curve: Curves.easeIn)))
      ..addStatusListener(_animationEndCallback);
  }

  void _nextAnimation() {
    final isLast = _index == widget.text.length - 1;

    _isCurrentlyPausing = false;

    if (_index! > -1) {
      widget.onNext?.call(_index, isLast);
    }

    if (isLast) {
      if (widget.isRepeatingAnimation &&
          (widget.repeatForever ||
              _currentRepeatCount != (widget.totalRepeatCount - 1))) {
        _index = 0;
        if (!widget.repeatForever) {
          _currentRepeatCount = _currentRepeatCount ?? 0 + 1;
        }
      } else {
        widget.onFinished?.call();
        return;
      }
    } else {
      _index = _index ?? 0 + 1;
    }

    if (mounted) setState(() {});

    if (widget.transitionHeight == null) {
      _transitionHeight = widget.textStyle!.fontSize! * 10 / 3;
    } else {
      _transitionHeight = widget.transitionHeight;
    }

    _controller!.forward(from: 0.0);
  }

  void _setPause() {
    final isLast = _index == widget.text.length - 1;

    _isCurrentlyPausing = true;
    if (mounted) setState(() {});

    widget.onNextBeforePause?.call(_index, isLast);
  }

  void _animationEndCallback(state) {
    if (state == AnimationStatus.completed) {
      assert(null == _timer || !_timer!.isActive);
      _timer = Timer(_texts[_index!]['pause'], _nextAnimation);
    }
  }

  void _onTap() {
    if (widget.displayFullTextOnTap) {
      if (_isCurrentlyPausing) {
        _timer?.cancel();
        _nextAnimation();
      } else {
        _controller?.stop();

        _setPause();

        assert(null == _timer || !_timer!.isActive);
        _timer = Timer(_texts[_index!]['pause'], _nextAnimation);
      }
    }

    widget.onTap?.call();
  }
}
