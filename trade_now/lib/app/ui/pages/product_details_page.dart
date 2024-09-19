import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
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
        toolbarHeight: 50,
        backgroundColor: bgColor,
      ),
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Column(
          children: [
            CarouselSlider(
                items: const [], options: CarouselOptions(height: 80.0)),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.1, vertical: 0),
              child: Column(
                children: [
                  const Text(
                    "RS 1.100",
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Usado"),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Descrição"),
                  Container(
                    height: 80,
                    width: screenWidth,
                    decoration: BoxDecoration(
                        color: lightColor,
                        border: Border.all(color: Colors.black)),
                    child: const Text(
                        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus."),
                  )
                ],
              ),
            ),
            const Text("Mais anúncios em Categoria"),
            ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return const ProductCard(
                  imgUrl:
                      "https://static.wikia.nocookie.net/bleach/images/e/e4/Ichigo_Kurosaki_TYBW.png/revision/latest?cb=20231002190352&path-prefix=pt",
                  name: "Itsugo",
                  price: 99.99,
                );
              },
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemExtent: screenWidth * 0.3,
            )
          ],
        ),
      ),
    );
  }
}
