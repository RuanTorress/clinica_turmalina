'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "c0b1b379cf0316626eb0481d8b6ffaa4",
"assets/AssetManifest.bin.json": "873c70058c9fc25b1b68b197b792bbc1",
"assets/AssetManifest.json": "a526c6cf7baae8bb2768e0fccfcc84e2",
"assets/assets/images/20241203_165058768_iOS.jpg": "9921575077a9c68da516ef4e447d1954",
"assets/assets/images/20241203_165118090_iOS.jpg": "3eed018bc495b164eb115edc0746c232",
"assets/assets/images/20241203_165135692_iOS.jpg": "65e8bcb7dd892c39b5f7ebabad4eda60",
"assets/assets/images/20241203_165154822_iOS.jpg": "918b54c492f17edb208dcaf4ecab3af9",
"assets/assets/images/20241203_165247362_iOS.jpg": "3de82732ae874032bfad51bf6040164d",
"assets/assets/images/20241203_165308413_iOS.jpg": "ba2e5403ce61ef8c4f1d0a7602e6090a",
"assets/assets/images/20241203_165526616_iOS.jpg": "dcc3f24041619d0bada50a640fe5be07",
"assets/assets/images/20241203_165557641_iOS.jpg": "f6189130afd4545088e5c59ee9d77145",
"assets/assets/images/20a16af2-418e-46a1-b311-34ed790003ab.jpg": "2c9f39f10afd80a0627fbd390f617f0c",
"assets/assets/images/38f510fe-296e-4f53-a147-45710ed6cd85.jpg": "5a2ed72b52409fbd67ac37f03a5f1b2d",
"assets/assets/images/5a43a5cb-95a4-44e4-80f5-9a6474f8e5d3.jpg": "b93f754921caab75ae72e66dc45101e3",
"assets/assets/images/5e32d620-5d7d-4c9a-97e4-b29ee442ef04.jpg": "0ae58f8896c5a5e1a4baf1724a5ec920",
"assets/assets/images/Acn.png": "c50d2e2031646c424baf5ccd56bd327c",
"assets/assets/images/botox.jpg": "40022bdc8d4f5129ad20450b9a7499a0",
"assets/assets/images/d437855b-4b0f-4e98-bdf0-5419e5083ae1.jpg": "a44d3de9971833f7406e4f909e00a0ee",
"assets/assets/images/favicon-32x32.webp": "e859822ed737738045eba1f6fa5a5055",
"assets/assets/images/favicon.ico": "183bad2f5fd890f0389afd5940e75e4f",
"assets/assets/images/file.png": "4dec3aa45feb99295f473d0b8acff8a3",
"assets/assets/images/img.webp": "77ebdfbb900ed02fa2be5ee66be766fb",
"assets/assets/images/logo.png": "cedccf222abdd3a43275305f4a5cccc1",
"assets/assets/images/melasma.jpeg": "b0f5390da0b755aa6e4aa12e82c89c8d",
"assets/assets/images/microvazos.jpg": "4aa5430087b1c0c12722957deada0a56",
"assets/assets/images/microvazos.png": "d1adfcab21498fb0c87a0fdd26b42277",
"assets/assets/images/sheets.png": "f434ff3b2b316deccabb01354afd02e3",
"assets/assets/images/thay.webp": "38e15104c9ea9ae07ea5a63ae4dc7a36",
"assets/assets/images/WhatsApp%2520Image%25202025-07-24%2520at%252016.37.23.jpeg": "b93f754921caab75ae72e66dc45101e3",
"assets/assets/images/WhatsApp%2520Image%25202025-07-24%2520at%252016.47.23%2520(1).jpeg": "2aad14a80abb296513c1b6a0e88d5f0d",
"assets/assets/images/WhatsApp%2520Image%25202025-07-24%2520at%252016.47.23.jpeg": "9ccd54a760439950ed8feecea9c04594",
"assets/FontManifest.json": "5a32d4310a6f5d9a6b651e75ba0d7372",
"assets/fonts/MaterialIcons-Regular.otf": "cf24a6d4a6e521d9097349ae41ab7a33",
"assets/NOTICES": "7ddc9a90b35dd6e9e7f3052a867cce19",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "a53baa14911df76a48506ba22ea66b91",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "3ca5dc7621921b901d513cc1ce23788c",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "a2eb084b706ab40c90610942d98886ec",
"assets/packages/youtube_player_flutter/assets/speedometer.webp": "50448630e948b5b3998ae5a5d112622b",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"favicon.png": "cedccf222abdd3a43275305f4a5cccc1",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"flutter_bootstrap.js": "950783164812c9d6ca8b4060f8a33ca0",
"icons/Icon-192.png": "cedccf222abdd3a43275305f4a5cccc1",
"icons/Icon-512.png": "cedccf222abdd3a43275305f4a5cccc1",
"icons/Icon-maskable-192.png": "cedccf222abdd3a43275305f4a5cccc1",
"icons/Icon-maskable-512.png": "cedccf222abdd3a43275305f4a5cccc1",
"index.html": "f39e3123a05f4a028c5b8d8226e5a306",
"/": "f39e3123a05f4a028c5b8d8226e5a306",
"main.dart.js": "16a270c3df1977f7ddc776516100335e",
"manifest.json": "96e6d5ac2c0582b240551638313ca04c",
"version.json": "720692722fa46118c391985213fdd0a8"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
