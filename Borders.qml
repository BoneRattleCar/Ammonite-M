import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.services
import QtQuick.Shapes
import QtQuick.Effects

Scope {
    id: root
    property string colorr: "#ffc0ca"
    property int thickness: 5
    property int barSize: 40


    PanelWindow {
        color: "transparent"
        screen: Quickshell.screens[1]
        anchors {
            top: true
            left: true
            bottom: true
            right:true
        }

        WlrLayershell.exclusionMode: ExclusionMode.Ignore
        mask: Region {}

        Item {
            anchors.fill: parent

            MultiEffect {
                source: background
                anchors.fill: background
                maskEnabled: true
                maskSource: mask

                layer.smooth: true
                maskInverted: true

                maskThresholdMin: 0.5
                maskSpreadAtMin: 1
            }

            Rectangle {
                id: background
                anchors.fill: parent
                smooth:true
                visible:false
                color: "#ffc0ca"
            }

            Item {
                id: mask
                anchors.fill: parent

                visible:false
                layer.enabled: true

                layer.smooth: true
                layer.samples: 4


                Rectangle {
                    width: parent.width - root.thickness * 2 - root.barSize
                    height: parent.height - root.thickness * 2
                    x: root.thickness + root.barSize
                    y: root.thickness

                    // anchors.centerIn: parent
                    radius: 20
                    color: "black"
                    antialiasing: true
                }
            }
        }
    }

    Bar {
        screen: Quickshell.screens[1]
        color: "white"
        anchors { left: true; top: true; bottom: true }
        implicitWidth: root.thickness + root.barSize
        WlrLayershell.exclusionMode: ExclusionMode.Normal
        exclusiveZone: root.thickness + root.barSize
        // mask: Region {}
    }

    PanelWindow {
        screen: Quickshell.screens[1]
        color: "transparent"
        anchors { bottom: true; left: true; right: true }
        implicitHeight: root.thickness
        WlrLayershell.exclusionMode: ExclusionMode.Normal
        exclusiveZone: root.thickness
        mask: Region {}
    }

    PanelWindow {
        screen: Quickshell.screens[1]
        color: "transparent"
        anchors { top: true; left: true; right: true }
        implicitHeight: root.thickness
        WlrLayershell.exclusionMode: ExclusionMode.Normal
        exclusiveZone: root.thickness
        mask: Region {}
    }


    PanelWindow {
        screen: Quickshell.screens[1]
        color: "transparent"
        anchors { right: true; top: true; bottom: true }
        implicitWidth: root.thickness
        WlrLayershell.exclusionMode: ExclusionMode.Normal
        exclusiveZone: root.thickness
        mask: Region {}
    }
}