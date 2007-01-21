// The SIP interface specification for:
//      QwtMarker.
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


class QwtMarker
{
%TypeHeaderCode
#include <qwt_marker.h>
%End // %TypeHeaderCode

public:
    enum LineStyle {
        NoLine,
        HLine,
        VLine,
        Cross
    }; // enum LineStyle

    QwtMarker();
    virtual ~QwtMarker();
    QwtMarker(const QwtMarker&);
    // Not Pythonic: QwtMarker& operator=(const QwtMarker&);
    void setLineStyle(QwtMarker::LineStyle);
    QwtMarker::LineStyle lineStyle() const;
    void setSymbol(const QwtSymbol&);
    const QwtSymbol& symbol() const;
    void setLabel(const QString&, const QFont& = QFont(), const QColor& = QColor(), const QPen& = QPen(Qt::NoPen), const QBrush& = QBrush(Qt::NoBrush));
    void setLabelText(const QString&);
    const QString label() const;
    void setLabelAlignment(int);
    int labelAlignment() const;
    void setLabelColor(const QColor&);
    const QColor labelColor() const;
    void setLabelPen(const QPen&);
    const QPen labelPen() const;
    void setLinePen(const QPen&);
    const QPen& linePen() const;
    void setFont(const QFont&);
    const QFont font() const;
    virtual void draw(QPainter*, int, int, const QRect&);
protected:
    virtual void markerChanged();
}; // class QwtMarker


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
