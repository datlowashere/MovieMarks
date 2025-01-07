class ExternalIdsModel {
  final String? imdbId;
  final String? facebookId;
  final String? instagramId;
  final String? twitterId;
  final String? wikidataId;
  final int? id;

  ExternalIdsModel({
    this.imdbId,
    this.facebookId,
    this.instagramId,
    this.twitterId,
    this.wikidataId,
    this.id,
  });

  factory ExternalIdsModel.fromJson(Map<String, dynamic> json) {
    return ExternalIdsModel(
      imdbId: json['imdb_id'] is String ? json['imdb_id'] as String : "",
      facebookId:
          json['facebook_id'] is String ? json['facebook_id'] as String : "",
      instagramId:
          json['instagram_id'] is String ? json['instagram_id'] as String : "",
      twitterId:
          json['twitter_id'] is String ? json['twitter_id'] as String : "",
      wikidataId:
          json['wikidata_id'] is String ? json['wikidata_id'] as String : "",
      id: json['id'] is int ? json['id'] as int : 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imdb_id': imdbId,
      'facebook_id': facebookId,
      'instagram_id': instagramId,
      'twitter_id': twitterId,
      'wikidata_id': wikidataId,
      'id': id,
    };
  }

  ExternalIdsModel copyWith({
    String? imdbId,
    String? facebookId,
    String? instagramId,
    String? twitterId,
    String? wikidataId,
    int? id,
  }) {
    return ExternalIdsModel(
      imdbId: imdbId ?? this.imdbId,
      facebookId: facebookId ?? this.facebookId,
      instagramId: instagramId ?? this.instagramId,
      twitterId: twitterId ?? this.twitterId,
      wikidataId: wikidataId ?? this.wikidataId,
      id: id ?? this.id,
    );
  }
}
