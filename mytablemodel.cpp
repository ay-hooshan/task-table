#include "mytablemodel.h"

const QVector<QString> columnNames = {"ID", "Name", "Family", "Address"};

MyTableModel::MyTableModel(QObject *parent)
    : QAbstractTableModel(parent)
{
    m_tableData.append({"0", "Ali", "Alavi", "Tehran Shahid Beheshti Street"});
    m_tableData.append({"1", "Naghi", "Mamooli", "Tehran Shahid Beheshti Street"});
    m_tableData.append({"2", "Taghi", "Mamooli", "Tehran Shahid Beheshti Street"});
    m_tableData.append({"3", "Arasto", "Aamel", "Tehran Shahid Babaii Street"});
    m_tableData.append({"4", "Nasrin", "Nasrini", "Tehran Shahid Soleimani Street"});
    m_tableData.append({"5", "Ali", "Alavi", "Tehran Shahid Beheshti Street"});
    m_tableData.append({"6", "Naghi", "Mamooli", "Tehran Shahid Beheshti Street"});
    m_tableData.append({"7", "Taghi", "Mamooli", "Tehran Shahid Babaii Street"});
    m_tableData.append({"8", "Arasto", "Aamel", "Tehran Shahid Beheshti Street"});
    m_tableData.append({"9", "Nasrin", "Nasrini", "Tehran Shahid Soleimani Street"});
    m_tableData.append({"10", "Akbar", "Akbari", "Tehran Shahid Beheshti Street"});
    m_tableData.append({"11", "Goodarz", "Goodarzi", "Tehran Shahid Sayyad Street"});
    m_tableData.append({"12", "Abbas", "Abbasi", "Tehran Shahid Chamran Street"});
    m_tableData.append({"0", "Ali", "Alavi", "Tehran Shahid Beheshti Street"});
    m_tableData.append({"1", "Naghi", "Mamooli", "Tehran Shahid Beheshti Street"});
    m_tableData.append({"2", "Taghi", "Mamooli", "Tehran Shahid Beheshti Street"});
    m_tableData.append({"3", "Arasto", "Aamel", "Tehran Shahid Babaii Street"});
    m_tableData.append({"4", "Nasrin", "Nasrini", "Tehran Shahid Soleimani Street"});
    m_tableData.append({"5", "Ali", "Alavi", "Tehran Shahid Beheshti Street"});
    m_tableData.append({"6", "Naghi", "Mamooli", "Tehran Shahid Beheshti Street"});
    m_tableData.append({"7", "Taghi", "Mamooli", "Tehran Shahid Babaii Street"});
    m_tableData.append({"8", "Arasto", "Aamel", "Tehran Shahid Beheshti Street"});
    m_tableData.append({"9", "Nasrin", "Nasrini", "Tehran Shahid Soleimani Street"});
    m_tableData.append({"10", "Akbar", "Akbari", "Tehran Shahid Beheshti Street"});
    m_tableData.append({"11", "Goodarz", "Goodarzi", "Tehran Shahid Sayyad Street"});
    m_tableData.append({"12", "Abbas", "Abbasi", "Tehran Shahid Chamran Street"});
    m_tableData.append({"0", "Ali", "Alavi", "Tehran Shahid Beheshti Street"});
    m_tableData.append({"1", "Naghi", "Mamooli", "Tehran Shahid Beheshti Street"});
    m_tableData.append({"2", "Taghi", "Mamooli", "Tehran Shahid Beheshti Street"});
    m_tableData.append({"3", "Arasto", "Aamel", "Tehran Shahid Babaii Street"});
    m_tableData.append({"4", "Nasrin", "Nasrini", "Tehran Shahid Soleimani Street"});
    m_tableData.append({"5", "Ali", "Alavi", "Tehran Shahid Beheshti Street"});
    m_tableData.append({"6", "Naghi", "Mamooli", "Tehran Shahid Beheshti Street"});
    m_tableData.append({"7", "Taghi", "Mamooli", "Tehran Shahid Babaii Street"});
    m_tableData.append({"8", "Arasto", "Aamel", "Tehran Shahid Beheshti Street"});
    m_tableData.append({"9", "Nasrin", "Nasrini", "Tehran Shahid Soleimani Street"});
    m_tableData.append({"10", "Akbar", "Akbari", "Tehran Shahid Beheshti Street"});
    m_tableData.append({"11", "Goodarz", "Goodarzi", "Tehran Shahid Sayyad Street"});
    m_tableData.append({"12", "Abbas", "Abbasi", "Tehran Shahid Chamran Street"});
}

QVariant MyTableModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    switch (role) {
    case Qt::DisplayRole:
        return columnNames.at(section);
    default:
        break;
    }

    return QVariant("Default Data");
}

int MyTableModel::rowCount(const QModelIndex &parent) const
{
    return m_tableData.size();
}

int MyTableModel::columnCount(const QModelIndex &parent) const
{
    return m_tableData.at(0).size();
}

QVariant MyTableModel::data(const QModelIndex &index, int role) const
{
    switch (role) {
    case Qt::DisplayRole:
        return m_tableData.at(index.row()).at(index.column());
    default:
        break;
    }

    return QVariant("Default Data");
}

void MyTableModel::myRemoveRow(QModelIndex index)
{
    beginRemoveRows(QModelIndex(), index.row(), index.row());
    m_tableData.removeAt(index.row());
    endRemoveRows();
}
