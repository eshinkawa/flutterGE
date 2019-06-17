import 'package:flutter/material.dart';

import '../App.dart';
import '../AppConfig.dart';

class Production extends StatelessWidget {
  @override
  build(BuildContext context) {
    String apiEndpoint =
        "http://falkor-cda.bastian.globo.com/feeds/93a4eb4b-8a93-4c09-b080-4ba92a01d142/posts/ssi";
    String host = 'http://globoesporte.globo.com/globo/raw/';

    return AppConfig(
        apiEndpoint: apiEndpoint,
        host: host,
        child: App(apiEndpoint: apiEndpoint));
  }
}
