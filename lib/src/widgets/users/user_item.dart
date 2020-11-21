part of '../index.dart';

class UserItem extends StatelessWidget {
  final SimpleUser simpleUser;
  final Function(SimpleUser simpleUser) onPressed;

  const UserItem({Key key, @required this.simpleUser, this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return simpleUser == null
        ? const SizedBox.shrink()
        : ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              topRight: Radius.circular(50),
            ),
            child: InkWell(
              onTap: () => onPressed?.call(simpleUser),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: NetworkImage(
                      simpleUser.avatar?.url ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            context.colorScheme.background.withOpacity(0),
                            context.colorScheme.background.withOpacity(0),
                            context.colorScheme.background.withOpacity(0.03),
                            context.colorScheme.background.withOpacity(0.07),
                            context.colorScheme.background.withOpacity(0.1),
                            context.colorScheme.background.withOpacity(0.3),
                            context.colorScheme.background.withOpacity(0.5),
                            context.colorScheme.background.withOpacity(0.7),
                            context.colorScheme.background.withOpacity(0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    left: 20,
                    child: Wrap(
                      direction: Axis.vertical,
                      children: [
                        Wrap(
                          spacing: 5,
                          crossAxisAlignment: WrapCrossAlignment.end,
                          children: [
                            Text(
                              simpleUser.displayName ?? '',
                              style: context.textTheme.subtitle1.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.colorScheme.primary,
                              ),
                            ),
                            if (simpleUser.age != null)
                              Text(
                                simpleUser.age.toString(),
                                style: context.textTheme.caption,
                              ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
