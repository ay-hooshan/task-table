#include "myproxymodel.h"

MyProxyModel::MyProxyModel(QObject *parent)
    : QSortFilterProxyModel(parent)
{
//    setDynamicSortFilter(true);
    m_myFilterEnabled = true;
}

bool MyProxyModel::filterAcceptsRow(int source_row, const QModelIndex &source_parent) const
{
    qDebug() << "filterAcceptColumn called!";
qDebug() << "searchedWord is " << m_searchedWord;
    if (!m_myFilterEnabled)
        return true;

    const QModelIndex index = sourceModel()->index(source_row, 1, source_parent);

    const QString name = sourceModel()->data(index).toString();

    return (name.contains(m_searchedWord));
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

QString MyProxyModel::searchedWord() const
{
    return m_searchedWord;
}

void MyProxyModel::setSearchedWord(const QString &newSearchedWord)
{
    if (m_searchedWord == newSearchedWord)
        return;
    m_searchedWord = newSearchedWord;
    emit searchedWordChanged();

    invalidateFilter(); // the most important line :)
}

bool MyProxyModel::lessThan(const QModelIndex &source_left, const QModelIndex &source_right) const
{
    QVariant leftData = sourceModel()->data(source_left);
    QVariant rightData = sourceModel()->data(source_right);

    return leftData.toString() < rightData.toString();
}
