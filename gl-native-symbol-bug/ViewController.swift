import Mapbox

class ViewController: UIViewController, MGLMapViewDelegate {
    
    var mapView: MGLMapView!
    var cameraIcon: UIImage!
    var starIcon: UIImage!
    var popup: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MGLMapView(frame: view.bounds, styleURL: MGLStyle.lightStyleURL())
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(CLLocationCoordinate2D(latitude: 53.747086635212845, longitude: -0.3330230712890625), animated: false)
        mapView.zoomLevel = 11.5
        mapView.delegate = self
        view.addSubview(mapView)
        
        cameraIcon = UIImage(named: "camera")
        starIcon = UIImage(named: "star")
    }
    
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "points", ofType: "geojson")!)
        
        let source = MGLShapeSource(identifier: "marker-source",
                                    url: url,
                                    options: nil)
        style.addSource(source)
        
        style.setImage(cameraIcon.withRenderingMode(.alwaysOriginal), forName: "camera-icon")
        style.setImage(starIcon.withRenderingMode(.alwaysTemplate), forName: "star-icon")
        
        let markerStyleLayer = MGLSymbolStyleLayer(identifier: "marker-style", source: source)
        
        markerStyleLayer.iconImageName  = NSExpression(
            format: "MGL_MATCH(type, 'camera', 'camera-icon', 'star', 'star-icon', 'rocket-15')")
        
        markerStyleLayer.iconColor = NSExpression(forConstantValue: UIColor.blue)
        
        style.addLayer(markerStyleLayer)
    }
    
    func mapView(_ mapView: MGLMapView, regionDidChangeAnimated animated: Bool) {
        print(mapView.zoomLevel)
    }
}
