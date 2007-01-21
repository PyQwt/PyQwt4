// The SIP interface specification for:
//      QwtLegend,
//      QwtLegendButton,
//      QwtLegendItem,
//      QwtLegendLabel.
//
// Copyright (C) 2001-2007 Gerard Vermeulen
// Copyright (C) 2000 Mark Colclough
//
// This file is part of PyQwt.
//
// PyQwt is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// PyQwt is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License along
// with PyQwt; if not, write to the Free Software Foundation, Inc.,
// 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
//
// In addition, as a special exception, Gerard Vermeulen gives permission
// to link PyQwt dynamically with non-free versions of Qt and PyQt,
// and to distribute PyQwt in this form, provided that equally powerful
// versions of Qt and PyQt have been released under the terms of the GNU
// General Public License.
//
// If PyQwt is dynamically linked with non-free versions of Qt and PyQt,
// PyQwt becomes a free plug-in for a non-free program.


class QwtLegend: QScrollView
{
%TypeHeaderCode
#include <qwt_legend.h>
%End // %TypeHeaderCode

public:
    enum LegendDisplayPolicy {
        None,
        Fixed,
        Auto
    }; // enum LegendDisplayPolicy

    virtual ~QwtLegend();
    QwtLegend(QWidget* /TransferThis/ = 0, const char* = 0);
    void setReadOnly(bool);
    bool isReadOnly() const;
    void setDisplayPolicy(QwtLegend::LegendDisplayPolicy, int = -1);
    QwtLegend::LegendDisplayPolicy displayPolicy() const;
    int identifierMode() const;
    QWidget* contentsWidget();
    // signature: const QWidget* contentsWidget() const;
    void insertItem(QWidget* /Transfer/, long);
    QWidget* findItem(long);
    // signature: const QWidget* findItem(long) const;
    QWidget* takeItem(long) /TransferBack/;
    /* FIXME: virtual */ QWidgetIntDictIt itemIterator() const;
    long key(const QWidget*) const;
    void clear();
    bool isEmpty() const;
    uint itemCount() const;
    virtual bool eventFilter(QObject*, QEvent*);
    virtual QSize sizeHint() const;
    virtual int heightForWidth(int) const;
protected:
    virtual void viewportResizeEvent(QResizeEvent*);
    virtual void layoutContents();
}; // class QwtLegend


class QwtLegendButton: QwtPushButton, QwtLegendItem
{
%TypeHeaderCode
#include <qwt_legend.h>
%End // %TypeHeaderCode

public:
    virtual ~QwtLegendButton();
    QwtLegendButton(QWidget* /TransferThis/ = 0, const char* = 0);
    QwtLegendButton(const QwtSymbol&, const QPen&, const QString&, QWidget* /TransferThis/ = 0, const char* = 0);
    virtual void setTitle(const QString&);
    virtual QString title() const;
protected:
    virtual QwtText* titleText() const;
    virtual void updateItem();
    virtual void updateIconset();
}; // class QwtLegendButton


class QwtLegendItem
{
%TypeHeaderCode
#include <qwt_legend.h>
%End // %TypeHeaderCode

public:
    enum IdentifierMode {
        NoIdentifier,
        ShowLine,
        ShowSymbol,
        ShowText
    }; // enum IdentifierMode

    QwtLegendItem();
    QwtLegendItem(const QwtSymbol&, const QPen&);
    virtual ~QwtLegendItem();
    void setIdentifierMode(int);
    int identifierMode() const;
    void setSymbol(const QwtSymbol&);
    const QwtSymbol& symbol() const;
    void setCurvePen(const QPen&);
    const QPen& curvePen() const;
    virtual void drawIdentifier(QPainter*, const QRect&) const;
    virtual void drawItem(QPainter*, const QRect&) const;
    virtual void setTitle(const QString&) = 0;
    virtual QString title() const = 0;
protected:
    virtual QwtText* titleText() const = 0;
    virtual void updateItem();
}; // class QwtLegendItem


class QwtLegendLabel: QLabel, QwtLegendItem
{
%TypeHeaderCode
#include <qwt_legend.h>
%End // %TypeHeaderCode

public:
    virtual ~QwtLegendLabel();
    QwtLegendLabel(QWidget* = 0, const char* = 0);
    QwtLegendLabel(const QwtSymbol&, const QPen&, const QString&, QWidget* = 0, const char* = 0);
    virtual void setTitle(const QString&);
    virtual QString title() const;
protected:
    virtual QwtText* titleText() const;
    virtual void drawContents(QPainter*);
    virtual void updateItem();
}; // class QwtLegendLabel


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
