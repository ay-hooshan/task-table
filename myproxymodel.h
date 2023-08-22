#ifndef MYPROXYMODEL_H
#define MYPROXYMODEL_H

#include <QObject>
#include <QSortFilterProxyModel>

class MyProxyModel: public QSortFilterProxyModel
{
    Q_OBJECT
    Q_PROPERTY(bool myFilterEnabled READ myFilterEnabled WRITE setMyFilterEnabled NOTIFY myFilterEnabledChanged FINAL)
    Q_PROPERTY(QString searchedID READ searchedID WRITE setSearchedID NOTIFY searchedIDChanged FINAL)
    Q_PROPERTY(QString searchedName READ searchedName WRITE setSearchedName NOTIFY searchedNameChanged FINAL)
    Q_PROPERTY(QString searchedFamily READ searchedFamily WRITE setSearchedFamily NOTIFY searchedFamilyChanged FINAL)
    Q_PROPERTY(QString searchedAddress READ searchedAddress WRITE setSearchedAddress NOTIFY searchedAddressChanged FINAL)

public:
    explicit MyProxyModel(QObject *parent = nullptr);

    bool filterAcceptsRow(int source_row, const QModelIndex &source_parent) const override;

    bool myFilterEnabled() const;
    void setMyFilterEnabled(bool newMyFilterEnabled);

    QString searchedID() const;
    void setSearchedID(const QString &newSearchedID);

    Q_INVOKABLE void myRemoveRow(const QModelIndex &index);

    QString searchedName() const;
    void setSearchedName(const QString &newSearchedName);

    QString searchedFamily() const;
    void setSearchedFamily(const QString &newSearchedFamily);

    QString searchedAddress() const;
    void setSearchedAddress(const QString &newSearchedAddress);

signals:
    void myFilterEnabledChanged();

    void searchedIDChanged();

    void searchedNameChanged();

    void searchedFamilyChanged();

    void searchedAddressChanged();

private:
    bool m_myFilterEnabled;
    QString m_searchedID;

    // QSortFilterProxyModel interface
    QString m_searchedName;

    QString m_searchedFamily;

    QString m_searchedAddress;

protected:
    bool lessThan(const QModelIndex &source_left, const QModelIndex &source_right) const override;
};

#endif // MYPROXYMODEL_H
