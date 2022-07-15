function fn() {
  var env = karate.env;
  var appId = karate.properties['appId'];
  var prodKey = karate.properties['prodKey'];
  var exportKey = karate.properties['exportKey'];
  var devKey = karate.properties['devKey']
  var UUID = '' + java.util.UUID.randomUUID();
  var LM = Java.type('leanplumapi.MaskingLogModifier');
  karate.configure('logModifier', new LM());

  if (!env) {
    env = 'qa';
  }

  var config = {
    baseUrl: 'https://api.leanplum.com/api',
    apiVersion: '1.0.6',
    appId: appId,
    prodKey: prodKey,
    exportKey: exportKey,
    devKey: devKey,
    UUID: UUID
  }

  return config;
}