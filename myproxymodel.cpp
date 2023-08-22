#include "myproxymodel.h"
#include "mytablemodel.h"

MyProxyModel::MyProxyModel(QObject *parent)
    : QSortFilterProxyModel(parent)
{
//    setDynamicSortFilter(true);
    m_myFilterEnabled = true;
}

bool MyProxyModel::filterAcceptsRow(int source_row, const QModelIndex &source_parent) const
{
//    qDebug() << "filterAcceptRow called!";
    if (!m_myFilterEnabled)
        return true;

    const QModelIndex index = sourceModel()->index(source_row, 1, source_parent);

    const QString name = sourceModel()->data(index).toString();

    return (name.contains(m_searchedID));
}

bool MyProxyModel::myFilterEnabled() const
{
    return m_myFilterEnabled;
}

void MyProxyModel::setMyFilterEnabled(bool newMyFilterEnabled)
{
    if (m_myFilterEnabled == newMyFilterEnabled)
        return;
    m_myFilterEnabled = newMyFilterEnabled;
    emit myFilterEnabledChanged();
}

QString MyProxyModel::searchedID() const
{
    return m_searchedID;
}

void MyProxyModel::setSearchedID(const QString &newSearchedID)
{
    if (m_searchedID == newSearchedID)
        return;
    m_searchedID = newSearchedID;
    emit searchedIDChanged();

    invalidateFilter(); // this line cause to "filterAcceptsRow" called!
}

void MyProxyModel::myRemoveRow(const QModelIndex &index)
{
//    qDebug() << "myRemoveRow of MyProxyModel called";

    dynamic_cast<MyTableModel*>(sourceModel())->myRemoveRow(mapToSource(index));
}


bool MyProxyModel::lessThan(const QModelIndex &source_left, const QModelIndex &source_right) const
{
    QVariant leftData = sourceModel()->data(source_left);
    QVariant rightData = sourceModel()->data(source_right);

    return leftData.toString() < rightData.toString();
}
