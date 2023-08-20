cmake_minimum_required(VERSION 3.16)

project(MyTable VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appMyTable
    main.cpp
)

qt_add_qml_module(appMyTable
    URI MyTable
    VERSION 1.0
    QML_FILES Main.qml
    QML_FILES
    SOURCES mytablemodel.h mytablemodel.cpp
    QML_FILES AyText.qml
    QML_FILES AyBtn.qml
    QML_FILES AyLineEdit.qml
    SOURCES myproxymodel.h myproxymodel.cpp
    RESOURCES todo.txt
    QML_FILES MyTableView.qml
    RESOURCES qml.qrc
    QML_FILES CustomBorder.qml
    QML_FILES CustomRadius.qml
    QML_FILES ImageRadius.qml
)

qt_add_resources(appMyTable qml
    FILES icons/)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appMyTable PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appMyTable
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appMyTable
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appMyTable
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
