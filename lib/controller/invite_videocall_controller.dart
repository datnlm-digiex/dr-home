import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';

class InviteVideoCallController extends GetxController {
  RxInt healthCheckIDInvite = 0.obs;

  RxString linkVideoCall = "".obs;
  getLinkVideoCall(int healthCheckID) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://metacine.page.link/',
      link: Uri.parse(
        'https://telemedicine-doctor-121fb.web.app/guest/' +
            healthCheckID.toString() +
            '?healthCheckID=' +
            healthCheckID.toString(),
      ),
      androidParameters: AndroidParameters(
        packageName: 'com.example.telemedicine_mobile',
      ),
    );

    Uri url; // = await parameters.buildUrl();
    final ShortDynamicLink shortLink = await parameters.buildShortLink();
    url = shortLink.shortUrl;

    linkVideoCall.value = url.toString();
  }
}
