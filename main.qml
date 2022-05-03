import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Window {
    id: root
    width: 900
    height: 600
    minimumHeight: 600
    minimumWidth: 900
    visible: true
    title: qsTr("Quanter")
    color: '#c2b6c8'

    Button {
        id: play
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.right: reset.left
        anchors.rightMargin: 20
        icon.source: 'play.png'
        icon.width: width*0.8
        icon.height: height*0.8
        background: Rectangle { radius: 15; border.width: 1; color: play.down ? '#c7bfc9' :
                                play.hovered ? '#e1e1e1' : "#f0eef0" }
        height: 60
        width: height
        padding: 0
        display: Button.IconOnly
        onReleased: { view.model = solver.solve(Number(n_count.text), Number(period.text),
                        Number(load.text), Number(exit.text), Number(waste.text), priors.text); }
    }

    Button {
        id: reset
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 35
        icon.source: 'reset.png'
        icon.width: width*0.7
        icon.height: height*0.7
        height: 60
        width: height
        padding: 0
        display: Button.IconOnly
        background: Rectangle { radius: 15; border.width: 1; color: reset.down ? '#c7bfc9' :
                                reset.hovered ? '#e1e1e1' : "#f0eef0" }
        onReleased: { f_reset(); }
    }

    TabBar {
        id: tabbar
        anchors.left: parent.left
        anchors.right: parent.right
        height: 60
        anchors.top: reset.bottom
        anchors.margins: 20

        onCurrentIndexChanged: { f_reset(); }

        TabButton {
            height: parent.height
            font.pointSize: 14
            text: 'С приоритетом'
        }
        TabButton {
            height: parent.height
            font.pointSize: 14
            text: 'Без приоритета'
        }
    }

    Rectangle {
        id: prior
        width: tabbar.width
        anchors.left: tabbar.left
        anchors.top: tabbar.bottom
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20

        Row {
            id: row
            anchors.leftMargin: 40
            anchors.horizontalCenter: parent.horizontalCenter
            height: 40
            spacing: 20

            Text {
                visible: tabbar.currentIndex == 1 ? true : false
                text: 'N'
                font.pointSize: 14
                anchors.verticalCenter: parent.verticalCenter
            }

            TextField {
                id: n_count
                visible: tabbar.currentIndex == 1 ? true : false
                height: 40
                font.pointSize: 14
                placeholderText: '0'
                horizontalAlignment: TextInput.AlignHCenter
                width: 60
                maximumLength: 4
                validator: RegExpValidator { regExp: /[0-9]+/ }
                onAccepted: { focus = false; }
            }

            Text {
                text: 'Тд'
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: 14
            }

            TextField {
                id: period
                height: 40
                width: 60
                placeholderText: '0'
                horizontalAlignment: TextInput.AlignHCenter
                font.pointSize: 14
                maximumLength: 4
                validator: RegExpValidator { regExp: /[0-9]+/ }
                onAccepted: { focus = false; }
            }

            Text {
                text: 'Тз'
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: 14
            }

            TextField {
                id: load
                height: 40
                width: 60
                placeholderText: '0'
                font.pointSize: 14
                horizontalAlignment: TextInput.AlignHCenter
                maximumLength: 4
                validator: RegExpValidator { regExp: /[0-9]+/ }
                onAccepted: { focus = false; }
            }

            Text {
                text: 'Тв'
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: 14
            }

            TextField {
                id: exit
                height: 40
                width: 60
                placeholderText: '0'
                horizontalAlignment: TextInput.AlignHCenter
                font.pointSize: 14
                maximumLength: 4
                validator: RegExpValidator { regExp: /[0-9]+/ }
                onAccepted: { focus = false; }
            }

            Text {
                text: 'СИ'
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: 14
            }

            TextField {
                id: waste
                height: 40
                width: 60
                placeholderText: '0'
                horizontalAlignment: TextInput.AlignHCenter
                font.pointSize: 14
                maximumLength: 4
                validator: RegExpValidator { regExp: /[0-9]+/ }
                onAccepted: { focus = false; }
            }

            Text {
                visible: tabbar.currentIndex == 0 ? true : false
                text: 'P'
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: 14
            }

            TextField {
                id: priors
                visible: tabbar.currentIndex == 0 ? true : false
                height: 40
                width: 150
                placeholderText: '0'
                horizontalAlignment: TextInput.AlignHCenter
                font.pointSize: 14
                validator: RegExpValidator { regExp: /[0-9 ]+/ }
                onAccepted: { focus = false; }
            }
        }



        ScrollView {
            anchors.left: parent.left
            anchors.right: parent.right
            height: 150
//            anchors.bottom: parent.bottom
            anchors.top: row.bottom
            anchors.topMargin: 150
            anchors.leftMargin: 25
            anchors.rightMargin: 25

//            ScrollBar.horizontal.policy: ScrollBar.AlwaysOn
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff

            ListView {
                id: view
                clip: true
                width: parent.width

                interactive: false
                orientation: ListView.Horizontal

                delegate: Rectangle {
                    height: 50
                    border.width: 1
                    width: _row.width+2

                    Row {
                        id: _row
                        height: parent.height-2
                        anchors.left: parent.left
                        anchors.leftMargin: 1
                        anchors.top: parent.top
                        anchors.topMargin: 1

                        Rectangle {
                            id: _load
                            height: parent.height
                            width: modelData[1] * 15-1
                            color: 'orange'
                        }

                        Rectangle {
                            id: _quant
                            height: parent.height
                            width: modelData[2] * 15
                            color: 'green'
                        }

                        Rectangle {
                            id: _exit
                            height: parent.height
                            width: modelData[3] * 15
                            color: 'red'
                        }

                        Rectangle {
                            id: _waste
                            height: parent.height
                            width: modelData[4] * 15-1
                            color: 'grey'
                        }
                    }

                    Text {
                        font.pointSize: 14
                        anchors.centerIn: parent
                        text: 'П' + String(modelData[0]+1)
                    }
                }
            }

            ListView {
                id: timeline
                width: parent.width
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 80
                orientation: ListView.Horizontal
                height: 15
                interactive: false
//                clip: true

                model: Math.ceil(view.contentWidth / 15)

                delegate: Rectangle {
                    color: 'transparent'
                    height: 10
                    width: 15

                    Rectangle {
                        width: parent.width
                        color: 'black'
                        height: 2
                        anchors.centerIn: parent
                    }
                    Rectangle {
                        anchors.right: parent.right
                        anchors.rightMargin: -1
                        width: 2
                        height: parent.height
                        color: 'black'
                    }

                    Text {
                        visible: (index + 1) % 5 == 0 ? true : false
                        font.pointSize: 14
                        text: index + 1
                        anchors.right: parent.right
                        anchors.top: parent.bottom
                        anchors.topMargin: 5
                        anchors.rightMargin: -7
                    }
                }
            }
        }

        Row {
            id: legend
            height: 30
            spacing: 20
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 15

            Text {
                font.pointSize: 14
                text: 'Загрузка'
                anchors.verticalCenter: parent.verticalCenter
            }

            Rectangle {
                height: parent.height
                width: height
                color: 'orange'
            }

            Text {
                font.pointSize: 14
                text: 'Квант'
                anchors.verticalCenter: parent.verticalCenter
            }

            Rectangle {
                height: parent.height
                width: height
                color: 'green'
            }

            Text {
                font.pointSize: 14
                text: 'Выгрузка'
                anchors.verticalCenter: parent.verticalCenter
            }

            Rectangle {
                height: parent.height
                width: height
                color: 'red'
            }

            Text {
                font.pointSize: 14
                text: 'Издержки'
                anchors.verticalCenter: parent.verticalCenter
            }

            Rectangle {
                height: parent.height
                width: height
                color: 'grey'
            }
        }
    }

    function f_reset()
    {
        n_count.clear();
        priors.clear();
        period.clear();
        waste.clear();
        load.clear();
        exit.clear();
        view.model = [];
    }
}
