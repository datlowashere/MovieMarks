import 'package:flutter/material.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';
import 'package:movie_marks/constants/api_urls.dart';
import 'package:movie_marks/data/models/crew_model.dart';
import 'package:movie_marks/data/models/movie_credits_model.dart';
import 'package:movie_marks/presentation/components/custom_text_with_image.dart';

class CrewMovieTab extends StatefulWidget {
  final MovieCreditsModel movieCreditsModel;

  const CrewMovieTab({super.key, required this.movieCreditsModel});

  @override
  State<CrewMovieTab> createState() => _CrewMovieTabState();
}

class _CrewMovieTabState extends State<CrewMovieTab> {
  @override
  Widget build(BuildContext context) {
    final groupedJobs = <String, List<CrewModel>>{};
    for (var crewMember in widget.movieCreditsModel.crew) {
      if (!groupedJobs.containsKey(crewMember.knownForDepartment)) {
        groupedJobs[crewMember.knownForDepartment] = [];
      }
      groupedJobs[crewMember.knownForDepartment]?.add(crewMember);
    }
    final sortedJobTitles = groupedJobs.keys.toList()..sort();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 18),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sortedJobTitles.length,
          itemBuilder: (context, index) {
            final jobTitle = sortedJobTitles[index];
            final crewMembers = groupedJobs[jobTitle];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  jobTitle,
                  style: AppTextStyles.beVietNamProStyles.medium12White,
                ),
                const SizedBox(height: 8),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: crewMembers?.length ?? 0,
                  itemBuilder: (context, crewIndex) {
                    final crewMember = crewMembers?[crewIndex];
                    return CustomTextWithImage(
                      avatarHeight: 60,
                      avatarWidth: 60,
                      imageUrl:
                          ApiUrls.imageUrl + (crewMember?.profilePath ?? ""),
                      title: crewMember?.name ?? "",
                      content: crewMember?.job ?? "",
                    );
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
