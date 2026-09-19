import QtQuick
import Quickshell.Hyprland
import QtQuick.Layouts

import "../../../services"


Rectangle {
    readonly property var occupied: {
        const occ = {};
        Hyprland.workspaces.values.map(ws=>occ[ws.id]=ws.active);
        return occ;
    }

    anchors.horizontalCenter: parent.horizontalCenter
    color: Theme.surfaceContainerHigh
    implicitWidth:30
    implicitHeight:150
    radius:15

    ColumnLayout{
        anchors.centerIn: parent
        Repeater {
            model: 5
            Rectangle {
                required property int index
                color:`${occupied[index+1] ? Theme.primary : occupied.hasOwnProperty(index+1) ? Theme.onPrimary : Theme.outlineVariant}`
                implicitWidth:15
                implicitHeight:15
                radius:15
            }
        }
    }
}