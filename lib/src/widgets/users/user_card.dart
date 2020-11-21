part of '../index.dart';

class UserCard extends StatelessWidget {
  final Function onPressed;
  final SimpleUser simpleUser;
  final bool showHobbies;

  const UserCard({
    Key key,
    this.onPressed,
    @required this.simpleUser,
    this.showHobbies = true,
  })  : assert(simpleUser != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: context.colorScheme.background,
            ),
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colorScheme.background,
              ),
            ),
          ),
          Positioned.fill(
              child: NetworkImage(
                  simpleUser.cover?.url ?? simpleUser.avatar?.url)),
          Positioned(
            bottom: 0,
            child: Container(
              height: 200,
              width: context.width,
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
            bottom: 10,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: NetworkImage(simpleUser.avatar.thumbnail,
                          isAvatar: true),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 5,
                            crossAxisAlignment: WrapCrossAlignment.end,
                            children: [
                              Text(
                                simpleUser.displayName,
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
                          if (simpleUser.introduction.isExistAndNotEmpty)
                            Text(
                              simpleUser.introduction,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.caption.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (showHobbies) ..._buildHobbyList(context)
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildHobbyList(BuildContext context) {
    List<HobbyWithIsSelect> hobbiesToShow =
        simpleUser.getSameHobbies(context) ?? [];

    return hobbiesToShow.isEmpty
        ? []
        : [
            Divider(color: Colors.grey[300]),
            RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                    style: context.textTheme.bodyText1,
                    children: hobbiesToShow
                        .asMap()
                        .map(
                          (i, e) => MapEntry(
                              i,
                              TextSpan(
                                text: e?.hobby?.value != null
                                    ? '${e.hobby.value}${i < hobbiesToShow.length - 1 ? ', ' : ''}'
                                    : '',
                                style: TextStyle(
                                  color: e.isSelected
                                      ? context.colorScheme.primary
                                      : context.colorScheme.onBackground,
                                ),
                              )),
                        )
                        .values
                        .toList()))
          ];
  }
}
