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

import "../../"
import "../../services"
import "modules"


PanelWindow {
    MarginWrapperManager { margin: 15 }
    Rectangle {
        id: content
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        color:"transparent"

        Workspaces {}

        ActiveWindow {}

        ColumnLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom

            Tray {}
            TimeWidget {}
        }
    }
}