pragma Singleton
import QtQuick
import Quickshell
import Qt.labs.folderlistmodel
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
    implicitHeight:300

    color:"transparent"

    property string wp

    mask: Region{
        item: selectorArea
    }


    Rectangle{
        id: selectorArea
        anchors.leftMargin:0

        anchors.fill: parent
        color: "#ffc0ca"
    }
    MouseArea {
        anchors.fill:parent

        onClicked:{
            // console.log("asdasdasddc")
            wp = "../../assets/wpp.jpg"
        }
    }
}
