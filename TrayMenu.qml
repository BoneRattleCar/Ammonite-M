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

PanelWindow {
    screen: Quickshell.screens[1]

    implicitWidth: 200
    implicitHeight: 200
    QsMenuOpener {
        id: menuOpener

        menu: SystemTray.items.values[0].menu
    }

    ColumnLayout {
        Repeater {
            model: menuOpener.children

            Rectangle {
                implicitWidth: 20
                implicitHeight: 20

                Text{
                    text: menuOpener.children.values[index].text
                    property string a: {
                        console.log(menuOpener.children.values[index].text.length === 0 ? "notext" : "bleh")
                    return "a"
                    }
                }
            }
        }
    }
}
