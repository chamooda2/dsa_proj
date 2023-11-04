import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dsa_proj/common/common.dart';
import 'package:dsa_proj/constants/asset_constants.dart';
import 'package:dsa_proj/core/utils.dart';
import 'package:dsa_proj/features/auth/controller/auth_controller.dart';
import 'package:dsa_proj/features/tweet/controller/tweet_controller.dart';
import 'package:dsa_proj/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateTweetScreen extends ConsumerStatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const CreateTweetScreen());
  const CreateTweetScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateTweetScreenState();
}

class _CreateTweetScreenState extends ConsumerState<CreateTweetScreen> {
  final tweetTextController = TextEditingController();
  List<File> images = [];

  void onPickImage() async {
    images = await pickImages();
    setState(() {});
  }

  @override
  void dispose() {
    tweetTextController.dispose();
    super.dispose();
  }

  void shareTweet() {
    ref.read(tweetControllerProvider.notifier).shareTweet(
          images: images,
          text: tweetTextController.text,
          context: context,
        );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;
    final isLoading = ref.watch(tweetControllerProvider);
    // print(currentUser?.name);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
        actions: [
          RoundedSmallButton(
            onTap: shareTweet,
            label: "Tweet",
            backgroundColor: Pallete.blueColor,
            textColor: Pallete.whiteColor,
          )
        ],
      ),
      body: isLoading || currentUser == null
          ? const Loader()
          : SafeArea(
              child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(currentUser.profilePic),
                        radius: 30,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextField(
                          controller: tweetTextController,
                          style: const TextStyle(
                            fontSize: 22,
                          ),
                          decoration: const InputDecoration(
                            hintText: "What's happening?",
                            hintStyle: TextStyle(
                              color: Pallete.greyColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                            // border: UnderlineInputBorder(
                            //   borderRadius: BorderRadius.all(Radius.circular(1)),
                            //   borderSide: BorderSide(width: 2),
                            // ),
                          ),
                          maxLines: null,
                        ),
                      )
                    ],
                  ),
                  if (images.isNotEmpty)
                    CarouselSlider(
                      items: images.map((file) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 10),
                          child: Image.file(file),
                        );
                      }).toList(),
                      options: CarouselOptions(
                          height: 400, enableInfiniteScroll: false),
                    )
                ],
              ),
            )),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(
          color: Pallete.greyColor,
          width: 0.5,
        ))),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10).copyWith(
                left: 20,
                right: 20,
                bottom: 15,
              ),
              child: GestureDetector(
                  onTap: onPickImage,
                  child: SvgPicture.asset(AssetsConstants.galleryIcon)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(
                left: 20,
                right: 20,
                bottom: 15,
              ),
              child: SvgPicture.asset(AssetsConstants.gifIcon),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(
                left: 20,
                right: 20,
                bottom: 15,
              ),
              child: SvgPicture.asset(AssetsConstants.emojiIcon),
            ),
          ],
        ),
      ),
    );
  }
}
