import 'package:flutter/widgets.dart';
import 'package:movie_marks/presentation/screens/detail_movie/widgets/review_item.dart';

class ReviewMovieTab extends StatefulWidget {
  const ReviewMovieTab({super.key});

  @override
  State<ReviewMovieTab> createState() => _ReviewMovieTabState();
}

class _ReviewMovieTabState extends State<ReviewMovieTab> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ReviewItem(userUrl: "text")
    ],);
  }
}
