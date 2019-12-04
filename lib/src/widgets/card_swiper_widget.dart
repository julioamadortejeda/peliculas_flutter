import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<dynamic> peliculas;

  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      //height: double.infinity,
      padding: EdgeInsetsDirectional.only(top: 10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                "http://via.placeholder.com/500x250",
                fit: BoxFit.cover,
              ));
        },
        itemCount: peliculas.length,
        pagination: new SwiperPagination(),
        //control: new SwiperControl(),
      ),
    );
  }
}
