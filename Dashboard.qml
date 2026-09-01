import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import M3Shapes
import QtQuick.Shapes

import "modules/dashboard/music/"

Scope {
    PanelWindow {
        color: "transparent"
        implicitHeight: 200

        // exclusiveZone: 0
        implicitWidth: 900
        screen: Quickshell.screens[0]

        anchors {
            top: true
        }
        Rectangle {
            anchors.fill: parent
            bottomLeftRadius: 10
            bottomRightRadius: 10
            color: "#16141b"

            // Portrait {
            //     // src: "https://i.scdn.co/image/ab67616d0000b2732cca715920d6cc70705cee7b"
            // }

        }
    }
}
