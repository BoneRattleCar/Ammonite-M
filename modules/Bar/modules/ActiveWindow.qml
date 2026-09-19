import QtQuick
import Quickshell.Hyprland

import "../../../services"

Text{
    readonly property var acWin: {
        const wholeName= Hyprland.activeToplevel?.title
        const reg = /^.*\s[—–-]\s/
        return wholeName.replace(reg, "")
    }
    color:Theme.primary

    id:text
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    text: acWin ?? "bleh"
    rotation:-90

    Behavior on text {
        SequentialAnimation {
            NumberAnimation {
                target: text
                property: "opacity"
                to: 0
                duration:100
            }
            PropertyAction {}
            NumberAnimation {
                target: text
                property: "opacity"
                to: 1
                duration:100

            }
        }
    }
}