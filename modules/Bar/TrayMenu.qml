import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.SystemTray
import QtQuick.Controls
import Quickshell.Widgets
import Quickshell.Wayland
import qs.services
import QtQuick.Shapes
import QtQuick.Effects
import QtQuick.Layouts

PopupWindow {
    id:root

    property int yPos: 0
    property int xPos: 0
    property PanelWindow panelWindow
    property int menuIndex

    anchor.window: panelWindow
    anchor.rect.x: xPos
    anchor.rect.y: yPos

    implicitWidth: 200
    implicitHeight: Math.max(1, menuContent.implicitHeight)
    visible: false
    // grabFocus: true

    function showMenu() {
        if (targetItem) {
            visible = true
        }
    }

    function hideMenu() {
        visible = false
    }

    QsMenuOpener {
        id: menuOpener
        menu: SystemTray.items.values[menuIndex].menu
    }

    Rectangle {
        id: contentRect
        anchors.fill: parent
        color: "#ffffff"
        radius: 6

        ColumnLayout {
            id: menuContent
            Repeater {
                model: menuOpener.children

                Text{
                    text: menuOpener.children.values[index].text

                    // property string a: {
                    //     console.log(menuOpener.children.values[index].text.length === 0 ? "notext" : "bleh")
                    //     return "a"
                    // }
                }
            }
        }
    }
}
