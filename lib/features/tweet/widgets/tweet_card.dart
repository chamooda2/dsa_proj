import 'package:any_link_preview/any_link_preview.dart';
import 'package:dsa_proj/constants/constants.dart';
import 'package:dsa_proj/core/enums/tweet_type_enum.dart';
import 'package:dsa_proj/features/auth/controller/auth_controller.dart';
import 'package:dsa_proj/features/tweet/widgets/carousel_image.dart';
import 'package:dsa_proj/features/tweet/widgets/hashtag_text.dart';
import 'package:dsa_proj/features/tweet/widgets/tweet_icon_buttons.dart';
import 'package:dsa_proj/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../common/error_page.dart';
import '../../../common/loading_page.dart';
import '../../../models/tweet_model.dart';

class TweetCard extends ConsumerWidget {
  final Tweet tweet;
  const TweetCard({super.key, required this.tweet});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(userDetailsProvider(tweet.uid)).when(
          data: (user) {
            return SafeArea(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(user.profilePic),
                          radius: 35,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    user.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  child: Text(
                                    "@${user.name} • ${timeago.format(tweet.tweetedAt, locale: "en_short")}",
                                    style: const TextStyle(
                                      fontSize: 17,
                                      color: Pallete.greyColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            HashtagText(text: tweet.text),
                            if (tweet.tweetType == TweetType.image)
                              CarouselImage(imageLinks: tweet.imageLinks),
                            if (tweet.link.isNotEmpty) ...[
                              const SizedBox(
                                height: 4,
                              ),
                              AnyLinkPreview(
                                  displayDirection:
                                      UIDirection.uiDirectionHorizontal,
                                  link: "https://${tweet.link}"),
                            ],
                            Container(
                              margin: const EdgeInsets.only(
                                top: 10,
                                right: 20,
                              ),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TweetIconButton(
                                        path: AssetsConstants.viewsIcon,
                                        onTap: () {},
                                        text: (tweet.commentIds.length +
                                                tweet.reshareCount +
                                                tweet.likes.length)
                                            .toString()),
                                    TweetIconButton(
                                        path: AssetsConstants.commentIcon,
                                        onTap: () {},
                                        text: (tweet.commentIds.length)
                                            .toString()),
                                    TweetIconButton(
                                        path: AssetsConstants.retweetIcon,
                                        onTap: () {},
                                        text: (tweet.reshareCount).toString()),
                                    TweetIconButton(
                                        path: AssetsConstants.likeOutlinedIcon,
                                        onTap: () {},
                                        text: (tweet.likes.length).toString()),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.share_outlined,
                                          size: 21,
                                          color: Pallete.greyColor,
                                        ))
                                  ]),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 1),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Divider(
                      color: Pallete.greyColor,
                    ),
                  )
                ],
              ),
            );
          },
          error: (error, st) => ErrorText(error: error.toString()),
          loading: () => const Loader(),
        );
  }
}
