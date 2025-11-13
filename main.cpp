#include "networkhandler.h"
#include "CircularReveal.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QObject>
#include <QCoreApplication>
#include <QQmlEngine>  // 新增：用于 qmlRegisterType

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    NetworkHandler *handler = new NetworkHandler(&app);
    engine.rootContext()->setContextProperty("networkHandler", handler);

    // 新增：注册 CircularReveal 为 QML 类型（无需直接 #include 头文件）
    qmlRegisterType<CircularReveal>("AppComponents", 1, 0, "CircularReveal");

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection
        );

    engine.loadFromModule("QT_Project", "Main");

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
