part of '../post_page.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 12.0),
      child: Column(
        children: [
          _PostInfo(),
          _Post(),
        ],
      ),
    );
  }
}

class _Post extends StatelessWidget {
  const _Post({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF28b5ca),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 15.0),
        child: Column(
          children: <Widget>[
            _PostContent(
              title: 'Felling: #Happy',
              summary:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            ),
            SizedBox(
              height: 20.0,
            ),
            _PostAction()
          ],
        ),
      ),
    );
  }
}

class _PostContent extends StatelessWidget {
  final String title;
  final String summary;

  const _PostContent({Key key, this.title, this.summary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0),
          Text(summary, style: TextStyle(color: Colors.white, height: 1.75)),
        ],
      ),
    );
  }
}

class _PostInfo extends StatelessWidget {
  const _PostInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _UserImage(
            userImage:
                'https://i.pinimg.com/originals/b1/bf/1c/b1bf1c6af93949ea1d76443b3ada163d.jpg',
          ),
          _User(
            postTimeStamp: '10 phút trước',
            name: 'Test',
          ),
          _PostLocation(
            farAway: '10 kms',
          ),
          Expanded(
              child: IconButton(
            onPressed: () {
              // You enter here what you want the button to do once the user interacts with it
            },
            icon: Icon(
              Icons.more_vert,
              color: Colors.grey,
            ),
            iconSize: 30.0,
          )),
        ],
      ),
    );
  }
}

class _User extends StatelessWidget {
  final String name;

  final String postTimeStamp;

  const _User({Key key, this.name, this.postTimeStamp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              name,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 2.0,
            ),
            Text(
              postTimeStamp,
              style: TextStyle(
                color: AppColors.indigo100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserImage extends StatelessWidget {
  final String userImage;

  const _UserImage({Key key, this.userImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: CircleAvatar(
        backgroundImage: NetworkImage(userImage),
        minRadius: Sizes.RADIUS_20,
        maxRadius: Sizes.RADIUS_20,
      ),
    );
  }
}

class _PostLocation extends StatelessWidget {
  final String farAway;

  const _PostLocation({Key key, this.farAway}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SvgPicture.asset(
            'assets/icons/upwards_arrow_with_tip_rightwards.svg',
            width: 12.0,
            height: 12.0,
          ),
          SizedBox(
            width: 2.0,
          ),
          Text(
            farAway,
            style: TextStyle(
              color: AppColors.indigo100,
            ),
          ),
        ],
      ),
    );
  }
}

class _PostAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var iconTextStyle = theme.textTheme.subtitle1.copyWith(
      color: AppColors.white,
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ActionIcon(
            onTap: () => {},
            title: StringConst.NUMBER_OF_LIKES,
            iconData: FeatherIcons.heart,
            isHorizontal: true,
            titleStyle: iconTextStyle,
            color: AppColors.white,
          ),
          SpaceW16(),
          ActionIcon(
            onTap: () => {},
            title: StringConst.NUMBER_OF_COMMENTS,
            iconData: FeatherIcons.messageSquare,
            isHorizontal: true,
            color: AppColors.white,
            titleStyle: iconTextStyle,
          ),
          Spacer(),
          IconButton(
              icon: Icon(FeatherIcons.share2, color: AppColors.white),
              onPressed: () => {})
        ],
      ),
    );
  }
}
