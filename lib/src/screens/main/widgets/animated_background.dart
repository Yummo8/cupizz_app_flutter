part of '../home_screen.dart';

class AnimatedBackground extends StatefulWidget {
  @override
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> {
  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      backgroundColor: context.colorScheme.primary,
      config: CustomConfig(
        gradients: [
          [context.colorScheme.primary, context.colorScheme.primaryVariant],
          [context.colorScheme.background, context.colorScheme.background]
        ],
        durations: [10000, 5000],
        heightPercentages: [0.02, 0.04],
        blur: MaskFilter.blur(BlurStyle.solid, 10),
        gradientBegin: Alignment.bottomLeft,
        gradientEnd: Alignment.topRight,
      ),
      waveAmplitude: 0,
      size: Size(
        double.infinity,
        double.infinity,
      ),
    );
  }
}
