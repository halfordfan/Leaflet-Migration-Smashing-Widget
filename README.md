# Leaflet with Migration Plug-in Widget for Smashing

The [Smashing dashboard](https://github.com/Smashing/smashing) is a convenient way to visualize a variety of data sets in a kiosk-type mode.  This is a [Leaflet](https://github.com/Leaflet/Leaflet) widget with the [Migration Layer](https://github.com/lit-forest/leaflet.migrationLayer) plug-in to create animated "flight paths" on a map.  I use this widget to show geo-locations of attacks against a firewall.

## Installation

Copy the required JS libraries and CSS files to the appropriate ```assets``` directories:

```bash
cp leaflet.js leafletMigrationLayer.js assets/javascripts
cp leaflet.css assets/stylesheets
```

## Usage

Add the widget to your dashboard .erb file.

```html
<div data-id="migrationmap"
data-title="Migration Map" 
data-noanimate="false" 
data-viewspec='{"center" :[30, -118], "zoom": 2.9}' 
data-view="LeafletMig" data-moreinfo="">
```

Several options are available for configuring the view:
- ```data-title``` - The title text.  Edit the ```.scss``` file if you want to change the location.
- ```data-noanimate [true|false]``` - True will disable the animation on the flight paths which can cause significant CPU consumption.
- ```data-viewspec``` - A JSON structure containing the center of the map and the zoom specification.  If not set, will default to latitude, longitude, and zoom level of 0.  Tune this to get a map view you are happy with.  NOTE THE QUOTATION.

Send path data as required by Leaflet

```js
{
"paths": [ 
{ "from" : [ 30, -110 ], "to" : [ 35, 100 ], "labels": [ "here", "there" ], "color" : "#FF0000", "value" : 1 },
{ "from" : [ -30, -110 ], "to" : [ -35, 100 ], "labels": [ "this place", "this other place" ], "color" : "#0000FF", "value" : 10 }
],
"viewspec" : { "center" : [ 0, -110], "zoom" : 4 }
}
```

```paths``` and ```viewspec``` can be sent separately so you can make the map move without repeatedly sending new data points.

## Contributing
I may or may not respond to pull requests or issue submissions.

## License
[MIT](https://choosealicense.com/licenses/mit/)
