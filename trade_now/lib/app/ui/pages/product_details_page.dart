import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_now/app/controllers/product_details_controller.dart';
import 'package:trade_now/app/core/constants/color_constants.dart';
import 'package:trade_now/app/ui/components/app_bar.dart';
import 'package:trade_now/app/ui/components/home_card.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = Get.mediaQuery.size.width;
    final controller = Get.put(ProductDetailsController());
    return Scaffold(
        appBar: const TopBar(nomePag: "Anúncio"),
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
                                fontSize: 24, fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 0.5,
                            indent: 5,
                            endIndent: 5,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            "Descrição",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                                minHeight: 120, maxHeight: 300),
                            child: Container(
                              width: screenWidth,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              child: Text(
                                controller.product.value.description == null
                                    ? ""
                                    : controller.product.value.description!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w200),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: TextButton(
                                onPressed: () => {},
                                child: Container(
                                  height: 50,
                                  width: 140,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: InkWell(
                                      onTap: () async {
                                        await launchUrl(
                                            Uri.parse(controller.contactLink));
                                      },
                                      child: const Text(
                                        "Entrar em contato",
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Mais anúncios em \"${controller.product.value.category ?? ""}\"",
                            textAlign: TextAlign.left,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  HomeCard(
                    category: controller.product.value.category ?? '', 
                    products: controller.productsSameCategory,
                    comingFrom: 1,
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: green6,
        );
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
