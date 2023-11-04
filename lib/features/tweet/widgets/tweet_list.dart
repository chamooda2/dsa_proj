import 'package:dsa_proj/common/common.dart';
import 'package:dsa_proj/features/tweet/controller/tweet_controller.dart';
import 'package:dsa_proj/features/tweet/widgets/tweet_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/appwrite_constants.dart';
import '../../../models/tweet_model.dart';

class TweetList extends ConsumerWidget {
  const TweetList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getTweetsProvider).when(
          data: (tweets) {
            return ref.watch(getLatestTweetsProvider).when(
                  data: (data) {
                    if (data.events.contains(
                          'databases.*.collections.${AppwriteConstants.tweetsCollectionID}.documents.*.create',
                        ) ||
                        data.events.contains(
                          'databases.*.collections.${AppwriteConstants.usersID}.documents.*.create',
                        )) {
                      print("inserting...");
                      tweets.insert(0, Tweet.fromMap(data.payload));
                    }
                    return ListView.builder(
                      itemCount: tweets.length,
                      itemBuilder: (BuildContext context, int index) {
                        final tweet = tweets[index];
                        return TweetCard(tweet: tweet);
                      },
                    );
                  },
                  error: (error, st) => ErrorText(error: error.toString()),
                  loading: () {
                    return ListView.builder(
                      itemCount: tweets.length,
                      itemBuilder: (BuildContext context, int index) {
                        final tweet = tweets[index];
                        return TweetCard(tweet: tweet);
                      },
                    );
                  },
                );
          },
          error: (error, st) => ErrorText(error: error.toString()),
          loading: () => const Loader(),
        );
  }
}
