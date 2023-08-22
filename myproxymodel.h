#ifndef MYPROXYMODEL_H
#define MYPROXYMODEL_H

#include <QObject>
#include <QSortFilterProxyModel>

class MyProxyModel: public QSortFilterProxyModel
{
    Q_OBJECT
    Q_PROPERTY(bool myFilterEnabled READ myFilterEnabled WRITE setMyFilterEnabled NOTIFY myFilterEnabledChanged FINAL)
    Q_PROPERTY(QString searchedID READ searchedID WRITE setSearchedID NOTIFY searchedIDChanged FINAL)

public:
    explicit MyProxyModel(QObject *parent = nullptr);

    bool filterAcceptsRow(int source_row, const QModelIndex &source_parent) const override;

    bool myFilterEnabled() const;
    void setMyFilterEnabled(bool newMyFilterEnabled);

    QString searchedID() const;
    void setSearchedID(const QString &newSearchedID);

    Q_INVOKABLE void myRemoveRow(const QModelIndex &index);

signals:
    void myFilterEnabledChanged();

    void searchedIDChanged();

private:
    bool m_myFilterEnabled;
    QString m_searchedID;

    // QSortFilterProxyModel interface
protected:
    bool lessThan(const QModelIndex &source_left, const QModelIndex &source_right) const override;
};

#endif // MYPROXYMODEL_H
