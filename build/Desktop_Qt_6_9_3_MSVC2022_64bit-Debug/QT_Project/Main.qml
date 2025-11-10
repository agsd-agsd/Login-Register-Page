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

    // 自定义 appBar（覆盖默认，添加右上角按钮）
    appBar: FluAppBar {
        id: customAppBar
        title: "AIR 飞行管理系统"
        height: 48

        // 左侧：帮助图标
        RowLayout {
            anchors.left: parent.left
            anchors.leftMargin: 10
            spacing: 10
            FluIconButton {
                icon: FluentIcons.Help
                ToolTip.text: "主题设置"
                ToolTip.visible: hovered
                onClicked: stackView.push(themePage)
            }
        }

        // 右侧：主题切换 + 设置 + 窗口按钮
        RowLayout {
            anchors.right: parent.right
            anchors.rightMargin: 10
            spacing: 10
            FluIconButton {
                icon: FluentIcons.Brightness
                ToolTip.text: "切换浅色主题"
                ToolTip.visible: hovered
                onClicked: {
                    FluTheme.darkMode = FluThemeType.Light
                    console.log("切换到浅色主题")
                }
            }
            FluIconButton {
                icon: FluentIcons.Settings
                ToolTip.text: "设置"
                ToolTip.visible: hovered
                onClicked: console.log("打开设置")
            }
            // 窗口控制（最小化/最大化/关闭）
            FluIconButton {
                icon: FluentIcons.ChromeMinimize
                onClicked: window.showMinimized()
            }
            FluIconButton {
                icon: FluentIcons.ChromeMaximize
                onClicked: window.visibility = window.visibility === Window.Maximized ? Window.Windowed : Window.Maximized
            }
            FluIconButton {
                icon: FluentIcons.ChromeClose
                onClicked: window.close()
            }
        }
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
