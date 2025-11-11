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

    effect: "gaussian-blur"  // 高斯模糊（毛玻璃核心）
    tintOpacity: 0.8  // 低透明度（增强霜感，减少着色）
    blurRadius: 60  // 高模糊半径（更强霜效果）

    Component.onCompleted: {
        FluTheme.darkMode = FluThemeType.Dark
        FluTheme.accentColor = FluColors.Blue
        FluTheme.animationEnabled = true
        FluTheme.nativeText = true
        FluTheme.blurBehindWindowEnabled = true  // 全局启用模糊
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
        initialItem: Login { stackView: stackView }
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
