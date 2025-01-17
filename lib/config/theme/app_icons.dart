enum AppIcons {
  search,
  bookmark,
  bookmarkFilled,
  cameraMovie,
  star,
  starFilled,
  arrowBack,
  facebook,
  x,
  instagram,
  link,
  google,
  fbBlue,
  close,
  closeWhite,
  arrowRight,
  privacy,
  alert,
  editFilled,
  help,
  logout,
  login,
  safety,
  about,
  review
}

extension AppIconsExtension on AppIcons {
  String get svgAssetPath {
    return 'assets/icons/ic_${name.toString().replaceAllMapped(RegExp(r'[A-Z]'), (match) => '_${match.group(0)}').toLowerCase()}.svg';
  }

  String get pngAssetPath {
    return 'assets/icons/ic_${name.toString().replaceAllMapped(RegExp(r'[A-Z]'), (match) => '_${match.group(0)}').toLowerCase()}.png';
  }
}
