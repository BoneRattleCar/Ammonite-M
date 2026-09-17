import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import Quickshell.Wayland
import qs.services
import QtQuick.Shapes
import QtQuick.Effects
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

PanelWindow {
    screen: Quickshell.screens[1]

    anchors.left: true
    anchors.right: true
    implicitHeight:200

    color:"transparent"

    Rectangle{
        id: selectorArea
        anchors.leftMargin:290

        anchors.fill: parent
        color: "#ffc0ca"
    }
}
