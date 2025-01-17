import 'package:latlong2/latlong.dart';

const String urlTemplateVoyager =
    'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png';
const String urlTemplatePositron =
    'https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png';
const String urlTemplateDarkMatter =
    'https://stamen-tiles.a.ssl.fastly.net/toner/{z}/{x}/{y}.png';
const defaultInitialLatLng = LatLng(
  -8.838333,
  13.234444,
);
const maxZoom = 18.0; // Zoom máximo permitido
const minZoom = 5.0; // Zoom mínimo permitido
const maxPriceFilter = 100000000.00;
