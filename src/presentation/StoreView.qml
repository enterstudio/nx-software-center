import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

import Snapd 1.0

import org.nx.softwarecenter 1.0

import "qrc:/scripts/Utils.js" as Utils
import "qrc:/actions/InstallSnapAction.js" as InstallSnapAction

Item {
    id: storeViewRoot

    property bool busy: false

    SnapdClient {
        id: snapdClient
    }

    objectName: "storeView"

    //    Rectangle {
    //        color: "lightblue"
    //        anchors.fill: parent
    //        opacity: 0.1
    //    }
    Loader {
        id: contentLoader
        anchors.fill: parent

        //        sourceComponent:
        //        sourceComponent: storeSnapsModel.busy
        //                         || storeSnapsModel.count == 0 ? searchView : snapsView
    }

    Component {
        id: statusView
        Item {
            PlasmaComponents.Label {
                id: messageText
                anchors.top: busyModelIndicator.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: 400
                height: 100

                text: storeSnapsModel.errorMessage
                      == "" ? storeSnapsModel.statusMessage : storeSnapsModel.errorMessage

                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                minimumPixelSize: 10
                font.pixelSize: 20
            }

            PlasmaComponents.BusyIndicator {
                id: busyModelIndicator
                visible: storeSnapsModel.busy
                anchors.centerIn: parent
            }

            PlasmaCore.IconItem {
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -20
                width: 64
                height: 64

                source: storeSnapsModel.statusMessageIcon
                visible: !busyModelIndicator.visible
            }
        }
    }

    DepartamentsView {
        id: departamentsView
        anchors.fill: parent

    }



    Component.onCompleted: {
        var actions = []
        statusArea.updateContext("documentinfo",
                                 i18n("Available actions"), actions)

        //        var actions = [InstallSnapAction.prepare(SnapdRootClient,
//                                                 storeSnapsModel)]
//        statusArea.updateContext("documentinfo",
//                                 i18n("Available actions"), actions)
    }
}
