import QtQuick
import Quickshell.Services.SystemTray
import QtQuick.Layouts

ColumnLayout {
    id: trayColumn
    Layout.alignment: Qt.AlignHCenter
    property int hoveredIndex: -1
    property real hoveredY: 0

    Repeater {
        model:SystemTray.items.values

        delegate: Item{
            id: trayItem
            required property var modelData
            required property int index

            implicitWidth:25
            implicitHeight:25

            Image{
                id:trayIcon
                anchors.fill:parent
                source: modelData.icon
            }

            HoverHandler {
                onHoveredChanged: {
                    if(hovered){
                        trayColumn.hoveredIndex = index
                        trayColumn.hoveredY = trayItem.mapToItem(null, 0, trayItem.height / 2).y
                        trayMenu.notifyHover(modelData, trayColumn.hoveredY)
                    } else {
                        trayMenu.notifyLeave()
                    }
                }
            }
        }
    }

    TrayMenu {
        id: trayMenu
    }
}