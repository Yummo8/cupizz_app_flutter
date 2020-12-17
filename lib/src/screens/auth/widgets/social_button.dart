part of '../index.dart';

class SocialButton extends StatelessWidget {
  final String imageName;
  final EdgeInsetsGeometry margin;
  final SocialProviderType type;

  const SocialButton({
    Key key,
    this.imageName,
    this.margin,
    @required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: context.colorScheme.primary.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: InkWell(
        onTap: () {
          Momentum.controller<AuthController>(context).loginSocial(type);
        },
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Image.asset(
            imageName,
            height: 28,
            width: 28,
          ),
        ),
      ),
    );
  }
}
