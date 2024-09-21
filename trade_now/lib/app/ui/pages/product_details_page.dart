import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_now/app/controllers/product_details_controller.dart';
import 'package:trade_now/app/core/constants/color_constants.dart';
import 'package:trade_now/app/ui/components/product_card.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = Get.mediaQuery.size.width;
    var screenHeight = Get.mediaQuery.size.height;
    final controller = Get.put(ProductDetailsController());
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text(
            "Anúncio",
            style: TextStyle(
                color: lightColor, fontWeight: FontWeight.bold, fontSize: 36),
          ),
          centerTitle: true,
          toolbarHeight: 65,
          backgroundColor: bgColor,
        ),
        body: SingleChildScrollView(
          child: Obx(() => Column(
                children: [
                  CarouselSlider(
                      items: controller.product == null
                          ? []
                          : controller.product.value.imgsUrl!.map<Widget>((img) {
                              return CachedNetworkImage(
                                imageUrl: img,
                                fit: BoxFit.fill,
                              );
                            }).toList(),
                      options: CarouselOptions(
                          scrollDirection: Axis.horizontal,
                          height: 150,
                          viewportFraction: 1.0))
                ],
              )),
        ));
  }
}
