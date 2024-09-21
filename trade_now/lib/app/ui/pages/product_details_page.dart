import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_now/app/controllers/product_details_controller.dart';
import 'package:trade_now/app/core/constants/color_constants.dart';
import 'package:trade_now/app/model/product.dart';
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
            onPressed: () {
              Get.toNamed("/home");
            },
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
        body: Obx(() => SingleChildScrollView(
              child: Column(
                children: [
                  CarouselSlider(
                      items: controller.product.value.imgsUrl!
                          .map((item) => ClipRRect(
                                child: Image.network(item,
                                    fit: BoxFit.cover, width: screenWidth),
                              ))
                          .toList(),
                      options: CarouselOptions(
                        onPageChanged: (value, _) =>
                            controller.currentPage.value = value,
                        aspectRatio: 2.0,
                        viewportFraction: 1.0,
                      )),
                  buildCarouselIndicator(controller),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: SizedBox(
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            controller.product.value.price == null
                                ? ""
                                : "R\$${controller.product.value.price!.toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 32),
                          ),
                          Text(
                            controller.product.value.name == null
                                ? ""
                                : controller.product.value.name!,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 28, fontWeight: FontWeight.w400),
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 0.5,
                            indent: 5,
                            endIndent: 5,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Descrição",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                          Container(
                            height: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: Text(
                                controller.product.value.description == null
                                    ? ""
                                    : controller.product.value.description!),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Mais anúncios em ${controller.product.value.category ?? ""}",
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: controller.productsSameCategory.length > 10
                          ? 10
                          : controller.productsSameCategory.value.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext build, int index) {
                        Product prod =
                            controller.productsSameCategory.value[index];
                        return TextButton(
                            onPressed: () => Get.toNamed("/details"),
                            child: ProductCard(
                                imgsUrl: prod.imgsUrl!,
                                name: prod.name!,
                                price: prod.price!));
                      },
                    ),
                  ),
                  TextButton(
                      onPressed: () => {},
                      child: Container(
                        height: 50,
                        width: 140,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Center(
                          child: Text(
                            "Entrar em contato",
                          ),
                        ),
                      ))
                ],
              ),
            )));
  }

  buildCarouselIndicator(var controller) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < controller.product.value.imgsUrl.length; i++)
            Container(
              margin: const EdgeInsets.all(5),
              height: i == controller.currentPage.value ? 7 : 5,
              width: i == controller.currentPage.value ? 7 : 5,
              decoration: BoxDecoration(
                color: i == controller.currentPage.value
                    ? Colors.black
                    : Colors.grey,
                shape: BoxShape.circle,
              ),
            )
        ],
      ),
    );
  }
}
