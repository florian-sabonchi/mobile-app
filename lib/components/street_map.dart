import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:helpwave/styling/constants.dart';
import 'package:helpwave/styling/streetmap_marker.dart';

class StreetMap extends StatefulWidget {
  final double width;
  final double height;
  final double border;
  final MapController controller;
  final ValueNotifier<bool> trackingNotifier;

  const StreetMap({
    super.key,
    this.width = -1,
    this.height = -1,
    this.border = 5,
    required this.trackingNotifier,
    required this.controller,
  });

  @override
  State<StatefulWidget> createState() => _StreetMapState();
}

class _StreetMapState extends State<StreetMap> {
  @override
  Widget build(BuildContext context) {
    const double loadingCircleSize = iconSizeBig;
    const double circleTextDistance = distanceDefault;
    const double defaultWidthPercentage = 0.8;
    double border = widget.border;

    List<StaticPositionGeoPoint> staticPoints = [
      StaticPositionGeoPoint(
        "Unique Name 1",
        hospitalMarker,
        [
          GeoPoint(
            latitude: 51.9582531914801,
            longitude: 7.614308513084836,
          ),
          GeoPoint(
            latitude: 51.85,
            longitude: 7.6,
          )
        ],
      )
    ];

    OSMFlutter osmFlutter = OSMFlutter(
        controller: widget.controller,
        trackMyPosition: widget.trackingNotifier.value,
        initZoom: 12,
        minZoomLevel: 2,
        maxZoomLevel: 19,
        stepZoom: 1,
        // TODO update staticPoints and their display
        staticPoints: staticPoints,
        mapIsLoading: Container(
          color: Theme.of(context).colorScheme.surface,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                SizedBox(
                  width: loadingCircleSize,
                  height: loadingCircleSize,
                  child: CircularProgressIndicator(),
                ),
                SizedBox(height: circleTextDistance),
                Text("Laden..."),
              ],
            ),
          ),
        ),
        userLocationMarker: UserLocationMaker(
          personMarker: personMarker,
          directionArrowMarker: directionArrowMarker,
        ),
        roadConfiguration: RoadConfiguration(
          startIcon: startIcon,
          roadColor: Colors.yellowAccent,
        ),
        markerOption: MarkerOption(
          defaultMarker: defaultMarker,
        ));

    Size mediaQuery = MediaQuery.of(context).size;
    return Container(
      width: widget.width > 0
          ? widget.width
          : mediaQuery.width * defaultWidthPercentage,
      height: widget.height > 0
          ? widget.height
          : mediaQuery.width * defaultWidthPercentage,
      padding: EdgeInsets.all(border),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(border),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: osmFlutter,
    );
  }
}
