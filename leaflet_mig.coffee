class Dashing.LeafletMig extends Dashing.Widget

  ready: ->
    container = $(@node).parent()
  # Gross hacks. Let's fix this.
    width = (Dashing.widget_base_dimensions[0] * container.data("sizex")) + Dashing.widget_margins[0] * 2 * (container.data("sizex") - 1)
    height = (Dashing.widget_base_dimensions[1] * container.data("sizey"))

    @maptile=new L.tileLayer 'https://cartocdn_{s}.global.ssl.fastly.net/base-midnight/{z}/{x}/{y}.png',  { noWrap: false, zIndex: -1000 }

    # If a map center and zoom is specified, create the map with it.
    if @get('viewspec')
      viewspec=@get('viewspec')
      center=viewspec.center
      zoom=viewspec.zoom
    else
      center=[0, 0]
      zoom=1

    # No mouse controls.
    @maptileOptions =
      boxZoom: false
      center: center
      dragging: false
      doubleClickZoom: false
      fadeAnimation: false
      layers:
        @maptile
      zoom: zoom
      zoomSnap: 0 
      zoomControl: false 
      attributionControl: false

    @mymap = new L.map($(@node).find(".chart")[0], @maptileOptions)

    if @get('paths')
      paths = @get('paths')
    else
      paths = []

    @migrationOptions =
      map: @mymap
      data: paths
      pulseBorderWidth: 2
      pulseRadius: 20
      arcLabel: true
      arcLabelFont: '8px sans-serif'

    @migLayer = new L.migrationLayer @migrationOptions
    @migLayer.addTo @mymap
    if @get('noanimate')
      @migLayer.pause()

  onData: (data) ->
    if @migLayer
      # Check for new path data and update.
      if data.paths
        @migLayer.setData data.paths
      # If a viewspec was passed, animate a transition to it.
      if data.viewspec
        @mymap.flyTo(data.viewspec.center, data.viewspec.zoom)
      # If animation was disabled, keep it disabled.
      if @get('noanimate')
        @migLayer.pause() 
