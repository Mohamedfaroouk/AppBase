import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class ListLoading extends StatelessWidget {
  const ListLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
          5,
          (index) => const SizedBox(height: 180, child: LoadingItem()),
        ),
      ],
    );
  }
}

class LoadingItem extends StatelessWidget {
  const LoadingItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(
        bottom: 10,
        left: 16,
        right: 16,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                  borderRadius: BorderRadius.circular(8),
                  width: 100,
                  height: 100),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SkeletonLine(
                    style: SkeletonLineStyle(
                        height: 16,
                        width: 64,
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  SkeletonParagraph(
                    style: SkeletonParagraphStyle(
                        lines: 2,
                        spacing: 6,
                        lineStyle: SkeletonLineStyle(
                          randomLength: true,
                          height: 10,
                          borderRadius: BorderRadius.circular(8),
                          minLength: MediaQuery.of(context).size.width / 2,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
