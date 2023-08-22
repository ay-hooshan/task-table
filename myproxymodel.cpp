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

    const QModelIndex indexID = sourceModel()->index(source_row, 0, source_parent);
    const QModelIndex indexName = sourceModel()->index(source_row, 1, source_parent);
    const QModelIndex indexFamily = sourceModel()->index(source_row, 2, source_parent);
    const QModelIndex indexAddress = sourceModel()->index(source_row, 3, source_parent);

    const QString sourceID = sourceModel()->data(indexID).toString().toLower();
    const QString sourceName = sourceModel()->data(indexName).toString().toLower();
    const QString sourceFamily = sourceModel()->data(indexFamily).toString().toLower();
    const QString sourceAddress = sourceModel()->data(indexAddress).toString().toLower();

    return (sourceID.contains(m_searchedID.toLower()) and sourceName.contains(m_searchedName.toLower()) and sourceFamily.contains(m_searchedFamily.toLower()) and sourceAddress.contains(m_searchedAddress.toLower()));
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

QString MyProxyModel::searchedName() const
{
    return m_searchedName;
}

void MyProxyModel::setSearchedName(const QString &newSearchedName)
{
    if (m_searchedName == newSearchedName)
        return;
    m_searchedName = newSearchedName;
    emit searchedNameChanged();

    invalidateFilter(); // this line cause to "filterAcceptsRow" called!
}

QString MyProxyModel::searchedFamily() const
{
    return m_searchedFamily;
}

void MyProxyModel::setSearchedFamily(const QString &newSearchedFamily)
{
    if (m_searchedFamily == newSearchedFamily)
        return;
    m_searchedFamily = newSearchedFamily;
    emit searchedFamilyChanged();

    invalidateFilter(); // this line cause to "filterAcceptsRow" called!
}

QString MyProxyModel::searchedAddress() const
{
    return m_searchedAddress;
}

void MyProxyModel::setSearchedAddress(const QString &newSearchedAddress)
{
    if (m_searchedAddress == newSearchedAddress)
        return;
    m_searchedAddress = newSearchedAddress;
    emit searchedAddressChanged();
    invalidateFilter(); // this line cause to "filterAcceptsRow" called!
}
