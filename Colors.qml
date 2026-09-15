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


Rectangle{
    // Kirigami.ImageColors {
    //     id: colorQuantizer
    //
    //     source: "assets/sickGuy.jpg"
    //
    //     // property ModelData a: {
    //     //
    //     // }
    // }

    ColorQuantizer {
        id: colorQuantizer
        source: Qt.resolvedUrl("./assets/sickGuy.jpg")
        depth: 4
        rescaleSize:64

        property var a: {
            console.log(colors)
        }
    }

    ColumnLayout {
        Repeater{
            model: colorQuantizer.colors
            delegate:Rectangle {
                color: modelData
                implicitHeight: 20
                implicitWidth: 20
            }
        }
    }
}

