import QtQuick
import QtQuick.Effects
import M3Shapes
import Quickshell.Services.Mpris
import org.kde.kirigami as Kirigami

Item {
    id: root

    property string fallbackColour: "#FFC0CA"
    property list<MprisPlayer> players: Mpris.players.values
    property MprisPlayer sptf: findSpotify(players) ?? null
    property string src

    function findSpotify(list: list<MprisPlayer>): MprisPlayer {
        console.log(list[0].identity);
        return list.find(p => {
            if (p.identity === "Spotify")
                return p;
        });
    }

    implicitHeight: 200
    implicitWidth: 200
    layer.enabled: true

    // layer.effect: MultiEffect {
    //     blurMax: 1
    //     shadowColor: root.fallbackColour
    //     shadowEnabled: true
    //     shadowOpacity: 1
    // }

    Item {
        id: shapeWrapper

        anchors.fill: parent
        layer.enabled: true
        opacity: 1

        MaterialShape {
            id: shape

            color: Qt.alpha(root.fallbackColour, 1)
            implicitSize: 200
            layer.enabled: true
            shape: MaterialShape.Cookie12Sided

            NumberAnimation on rotation {
                duration: 23500
                easing.type: Easing.Linear
                loops: Animation.Infinite
                paused: false
                running: true
                to: 360
            }
        }
    }
    Image {
        id: image

        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        layer.enabled: true
        source: sptf.trackArtUrl

        layer.effect: MultiEffect {
            maskEnabled: true
            maskSource: shapeWrapper
            maskSpreadAtMin: 1
            maskThresholdMin: 0.5
        }
    }

    Kirigami.ImageColors {
        id: imgColors

        source: "https://i.scdn.co/image/ab67616d0000b2731a20909318eb79ab5acae05e"
    }
    Rectangle {
        color: imgColors.dominant
        implicitHeight: 20
        implicitWidth: 20
    }
}
