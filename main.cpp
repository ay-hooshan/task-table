#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QQmlContext>

#include "mytablemodel.h"
#include "myproxymodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    MyTableModel myModel;

    MyProxyModel myProxyModel;
    myProxyModel.setSourceModel(&myModel);

//    engine.rootContext()->setContextProperty("mymodel", &myModel);
    engine.rootContext()->setContextProperty("myproxymodel", &myProxyModel);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.loadFromModule("MyTable", "Main");

    return app.exec();
}
