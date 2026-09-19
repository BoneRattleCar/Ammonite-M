import QtQuick
import QtQuick.Layouts

import "../../../services"


ColumnLayout {
    Layout.alignment: Qt.AlignHCenter

    Text{
        color: Theme.primary
        text:Time.hour
    }

    Text{
        color: Theme.primary
        text:Time.mins
    }
}