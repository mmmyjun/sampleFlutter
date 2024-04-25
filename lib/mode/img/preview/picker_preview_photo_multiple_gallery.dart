import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';


class GelleryImgModel {
  final String id;
  final String image;
  GelleryImgModel({required this.id, required this.image});
}
class PickerPreviewPhotoMultipleGallery extends StatefulWidget {
  final List<GelleryImgModel> galleryItems;
  const PickerPreviewPhotoMultipleGallery({required this.galleryItems, Key? key}) : super(key: key);

  @override
  State<PickerPreviewPhotoMultipleGallery> createState() => _PickerPreviewPhotoMultipleGalleryState();
}
class _PickerPreviewPhotoMultipleGalleryState extends State<PickerPreviewPhotoMultipleGallery> {

  final backgroundDecoration = const BoxDecoration(
    color: Colors.black,
  );
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: AssetImage(widget.galleryItems[index].image),
              initialScale: PhotoViewComputedScale.contained * 0.8,
              heroAttributes: PhotoViewHeroAttributes(
                  tag: widget.galleryItems[index].id),
            );
          },
          itemCount: widget.galleryItems.length,
          // loadingBuilder: (context, event) =>
          //     Center(
          //       child: Container(
          //         width: 20.0,
          //         height: 20.0,
          //         child: CircularProgressIndicator(
          //           value: event == null
          //               ? 0
          //               : event.cumulativeBytesLoaded /
          //               event.expectedTotalBytes,
          //         ),
          //       ),
          //     ),
          backgroundDecoration: backgroundDecoration,
          pageController: pageController,
          onPageChanged: (int index) {
            print('page change: $index');
            print(pageController.page);
          },
        )
    );
  }
}