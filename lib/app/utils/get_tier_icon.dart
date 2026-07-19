import 'package:staffing/app/constants/app_assets.dart';

String getTierIcon(String tierName) {
  switch (tierName.toLowerCase()) {
    case "bronze":
      return AppAssets.bronze; // 🥉 medal outline
    case "silver":
      return AppAssets.silver; // 🥈 filled medal
    case "gold":
      return AppAssets.gold; // 🥇 award/cup
    case "diamond":
      return AppAssets.diamond; // 💎 diamond
    default:
      return AppAssets.bronze; // fallback
  }
}
