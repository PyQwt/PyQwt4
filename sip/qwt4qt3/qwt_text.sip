// The SIP interface specification for:
//      QwtPlainText,
//      QwtRichText,
//      QwtText.
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


class QwtPlainText: QwtText
{
%TypeHeaderCode
#include <qwt_text.h>
%End // %TypeHeaderCode

public:
    virtual ~QwtPlainText();
    QwtPlainText(const QString&, const QFont&, int = 2628, const QColor& = QColor(), const QPen& = QPen(Qt::NoPen), const QBrush& = QBrush(Qt::NoBrush));
    QwtPlainText(const QString&, const QFont&, const QColor&);
    virtual QwtText* clone() const /Factory/;
    virtual int heightForWidth(int) const;
    virtual QRect boundingRect(QPainter* = 0) const;
    virtual void draw(QPainter*, const QRect&) const;
}; // class QwtPlainText


class QwtRichText: QwtText
{
%TypeHeaderCode
#include <qwt_text.h>
%End // %TypeHeaderCode

public:
    QwtRichText(const QString&, const QFont&, int = 2628, const QColor& = QColor(), const QPen& = QPen(Qt::NoPen), const QBrush& = QBrush(Qt::NoBrush));
    QwtRichText(const QString&, const QFont&, const QColor&);
    virtual ~QwtRichText();
    virtual QwtText* clone() const /Factory/;
    virtual void setText(const QString&);
    virtual void setFont(const QFont&);
    virtual void setAlignment(int);
    virtual int heightForWidth(int) const;
    virtual QRect boundingRect(QPainter* = 0) const;
    virtual void draw(QPainter*, const QRect&) const;
}; // class QwtRichText


class QwtText
{
%TypeHeaderCode
#include <qwt_text.h>
%End // %TypeHeaderCode

public:
    virtual ~QwtText();
    static QwtText* makeText(const QString&, Qt::TextFormat, int, const QFont&, const QColor& = QColor(), const QPen& = QPen(Qt::NoPen), const QBrush& = QBrush(Qt::NoBrush));
    static QwtText* makeText(const QString&, int, const QFont&, const QColor& = QColor(), const QPen& = QPen(Qt::NoPen), const QBrush& = QBrush(Qt::NoBrush));
    static void setDefaultFormat(Qt::TextFormat);
    static Qt::TextFormat defaultFormat();
    virtual void setText(const QString&);
    QString text() const;
    bool isNull() const;
    bool isEmpty() const;
    virtual void setFont(const QFont&);
    QFont font() const;
    QFontMetrics fontMetrics() const;
    virtual void setAlignment(int);
    int alignment() const;
    virtual void setColor(const QColor&);
    QColor color() const;
    virtual void setRectPen(const QPen&);
    QPen rectPen() const;
    virtual void setRectBrush(const QBrush&);
    QBrush rectBrush() const;
    virtual int heightForWidth(int) const = 0;
    virtual QRect boundingRect(QPainter* = 0) const = 0;
    virtual void draw(QPainter*, const QRect&) const = 0;
    virtual QwtText* clone() const = 0 /Factory/;
protected:
    QwtText(const QString&, const QFont&, int, const QColor&, const QPen& = QPen(Qt::NoPen), const QBrush& = QBrush(Qt::NoBrush));
}; // class QwtText


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
