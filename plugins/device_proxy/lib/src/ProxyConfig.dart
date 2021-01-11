class ProxyConfig {
  bool isEnable;
  String host;
  String port;
  String proxyUrl;

  ProxyConfig(String proxyUrl) {
    _init(proxyUrl);
  }

  void _init(String proxyUrl) {
    isEnable = proxyUrl.isNotEmpty;

    if (isEnable) {
      this.proxyUrl = proxyUrl;
      final proxyRaw = proxyUrl.split(':');
      this.host = proxyRaw[0];
      this.port = proxyRaw[1];
    }
  }
}
