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
    id:root
    screen: Quickshell.screens[1]

    anchors.left: true
    anchors.right: true
    implicitHeight:300

    color:"transparent"

    property string wp

    mask: Region{
        item: selectorArea
    }

    FolderListModel {
        id: wpFolder
        folder: Qt.resolvedUrl("../assets/wallpapers")
    }



    Rectangle{
        id: selectorArea
        anchors.leftMargin:0
        MarginWrapperManager { margin: 15 }



        anchors.fill: parent
        color: "#ffc0ca"

        RowLayout {
            spacing:10
            Repeater {
                model: wpFolder

                delegate:Rectangle {
                    Layout.alignment: Qt.AlignHCenter
                    // anchors.verticalCenter: parent.verticalCenter
                    color:"white"
                    width:300
                    height:root.height - 30

                    Text{
                        text: model.fileName
                    }
                    MouseArea {
                        anchors.fill:parent
                        onClicked:{
                            // console.log("asdasdasddc")
                            wp = "../../assets/wallpapers/" + model.fileName
                        }
                    }
                }
            }
        }
    }

    // MouseArea {
    //     anchors.fill:parent
    //
    //     onClicked:{
    //         // console.log("asdasdasddc")
    //         wp = "../../assets/wpp.jpg"
    //     }
    // }


}
