import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import FluentUI 1.0

FluWindow {
    id: window
    width: 0.4 * screen.width
    height: 0.4 * screen.height
    visible: true
    title: qsTr("飞行管理系统")
    // 禁用系统标题栏
    useSystemAppBar: false
    Component.onCompleted: {
        FluTheme.darkMode = FluThemeType.Dark
        FluTheme.accentColor = FluColors.Blue
        FluTheme.animationEnabled = true
    }
    appBar: FluAppBar {
        id: appBar
        height: 36
        showDark: true
        closeClickListener: ()=>{ dialog_close.open() }
    }
    FluContentDialog {
        id: dialog_close
        title: qsTr("退出")
        message: qsTr("确定要退出飞行管理系统吗？")
        negativeText: qsTr("取消")
        positiveText: qsTr("退出")
        buttonFlags: FluContentDialogType.NegativeButton | FluContentDialogType.PositiveButton
        onPositiveClicked: Qt.quit()
    }
    StackView {
        id: stackView
        anchors.fill: parent
        Rectangle {
            anchors.fill: parent
            color: FluTheme.dark ? "#000000" : "#FFFFFF"
        }
        initialItem: Login { stackView: stackView }
        Component {
            id: themePage
            FluScrollablePage {
                title: qsTr("主题设置")
                FluFrame {
                    anchors.fill: parent
                    padding: 10
                    ColumnLayout {
                        spacing: 10
                        FluText { text: qsTr("暗黑模式") }
                        FluToggleSwitch {
                            checked: FluTheme.dark
                            onClicked: FluTheme.darkMode = FluTheme.dark ? FluThemeType.Light : FluThemeType.Dark
                        }
                        FluText { text: qsTr("动画效果") }
                        FluToggleSwitch {
                            checked: FluTheme.animationEnabled
                            onClicked: FluTheme.animationEnabled = !FluTheme.animationEnabled
                        }
                    }
                }
            }
        }
        Component {
            id: dashboardPage
            FluPage {
                title: "仪表盘"
                FluText {
                    anchors.centerIn: parent
                    text: "欢迎！航班管理系统"
                    font.pixelSize: 24
                    color: "white"
                }
            }
        }
        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 300
                easing.type: Easing.InOutQuad
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 300
                easing.type: Easing.InOutQuad
            }
        }
        popEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 300
                easing.type: Easing.InOutQuad
            }
        }
        popExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 300
                easing.type: Easing.InOutQuad
            }
        }
    }
}
