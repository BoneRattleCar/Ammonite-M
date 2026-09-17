import QtQuick
import Quickshell
import Quickshell.Wayland
import Caelestia.Config
import qs.services
import QtQuick.Shapes
import QtQuick.Effects

import "../../services"

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

    property string source: WallpaperChanger.wp
    property Image current
    property bool completed

    Component.onCompleted: {
        current = wpComp.createObject(wallpaperContainer, { source: "../../assets/wallpapers/wp.jpg" });
    }

    onSourceChanged:{
        current.destroy()
        current = wpComp.createObject(wallpaperContainer, { source: source });
    }

    // Timer{
    //     interval: 5000
    //     running:true
    //     repeat:true
    //     onTriggered: {
    //         current.destroy()
    //         current = wpComp.createObject(wallpaperContainer, { source: "../../assets/wpp.jpg" });
    //     }
    // }

    Item {
        id: wallpaperContainer
        anchors.fill: parent
    }
    Component {
        id: wpComp
        Image {
            id: wp
            asynchronous: true

            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            layer.enabled: true

            // source: "../../assets/wpp.jpg"

            onStatusChanged: {
                if (status === Image.Ready)
                    fadeInAnim.start();
            }

            PropertyAnimation {
                id: fadeInAnim

                target: wp
                property: "opacity"
                from: 0
                to: 1

                duration: 200
            }
        }
    }
}
