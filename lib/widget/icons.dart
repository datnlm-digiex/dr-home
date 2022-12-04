class MeditationSvgAssets {
  static final MeditationSvgAssets _instance = MeditationSvgAssets._internal();

  factory MeditationSvgAssets() {
    return _instance;
  }

  MeditationSvgAssets._internal();

  Map<AssetName, String> assets = {
    AssetName.search: "assets/icons/search.svg",
    AssetName.vectorBottom: "assets/images/Vector.svg",
    AssetName.vectorTop: "assets/images/Vector-1.svg",
    AssetName.headphone: "assets/icons/headphone.svg",
    AssetName.tape: "assets/icons/tape.svg",
    AssetName.vectorSmallBottom: "assets/images/VectorSmallBottom.svg",
    AssetName.vectorSmallTop: "assets/images/VectorSmallTop.svg",
    AssetName.back: "assets/icons/back.svg",
    AssetName.heart: "assets/icons/heart-svgrepo-com.svg",
    AssetName.chart: "assets/icons/chart.svg",
    AssetName.discover: "assets/icons/discover.svg",
    AssetName.profile: "assets/icons/profile.svg",
    AssetName.brain: "assets/icons/brain-svgrepo-com.svg",
    AssetName.lungs: "assets/icons/lungs-svgrepo-com.svg"
  };
}

enum AssetName {
  search,
  vectorBottom,
  vectorTop,
  headphone,
  tape,
  vectorSmallBottom,
  vectorSmallTop,
  back,
  heart,
  chart,
  discover,
  profile,
  brain,
  lungs
}
