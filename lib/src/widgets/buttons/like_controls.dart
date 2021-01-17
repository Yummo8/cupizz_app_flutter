import 'package:cupizz_app/src/base/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class LikeControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Positioned.fill(
                    child: Container(
                  color: context.colorScheme.background,
                )),
                Container(
                  width: 245,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: context.colorScheme.primary.withOpacity(0.2),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color:
                            context.colorScheme.onBackground.withOpacity(0.15),
                        blurRadius: 20,
                        offset: Offset(2, 1.5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.close,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.star,
                            color: context.colorScheme.primary,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 30,
                      offset: Offset(2, 1.5),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.favorite,
                    size: 40,
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
