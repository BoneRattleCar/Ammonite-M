import QtQuick
import Quickshell
import Quickshell.Wayland
import Caelestia.Config
import qs.services
import QtQuick.Shapes
import QtQuick.Effects

PanelWindow{
    screen: Quickshell.screens[1]
    exclusiveZone: 1

    WlrLayershell.exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Background
    // WlrLayershell.layer: contentItem.Config.background.wallpaperEnabled ? WlrLayer.Background : WlrLayer.Bottom
    // color: contentItem.Config.background.wallpaperEnabled ? "black" : "#ffc0ca"
    color: "black"

    anchors.top: true
    anchors.bottom: true
    anchors.left: true
    anchors.right: true

    Image {
        id: image

        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        layer.enabled: true
        source: "assets/wpp.jpg"
    }
}
