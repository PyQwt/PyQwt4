// The SIP interface specification for:
//      QwtScaleDraw.
//
// Copyright (C) 2001-2008 Gerard Vermeulen
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


class QwtScaleDraw: QwtDiMap
{
%TypeHeaderCode
#include <qwt_scldraw.h>
%End // %TypeHeaderCode

public:
    enum Orientation {
        Bottom,
        Top,
        Left,
        Right,
        Round
    }; // enum Orientation

    enum Option {
        None,
        Backbone
    }; // enum Option

    QwtScaleDraw();
    virtual ~QwtScaleDraw();
    void setScale(const QwtScaleDiv&);
    void setScale(double, double, int, int, double = 0.0, int = 0);
    void setOptions(int);
    int options() const;
    void setGeometry(int, int, int, QwtScaleDraw::Orientation);
    int x() const;
    int y() const;
    int length() const;
    QwtScaleDraw::Orientation orientation() const;
    void setAngleRange(double, double);
    void setLabelFormat(char, int, int = 0);
    void setLabelAlignment(int);
    void setLabelRotation(double);
    void setTickLength(unsigned, unsigned, unsigned);
    void setMargin(uint, uint);
    const QwtScaleDiv& scaleDiv() const;
    int maxWidth(const QPen&, const QFontMetrics&) const;
    int maxHeight(const QPen&, const QFontMetrics&) const;
    void minBorderDist(const QFontMetrics&, int&, int&) const;
    int minLabelDist(const QFontMetrics&) const;
    int minHeight(const QPen&, const QFontMetrics&) const;
    int minWidth(const QPen&, const QFontMetrics&) const;
    void labelFormat(char& /Out/, int& /Out/, int& /Out/) const;
    int labelAlignment() const;
    double labelRotation() const;
    void tickLength(unsigned&, unsigned&, unsigned&) const;
    unsigned majTickLength() const;
    virtual void draw(QPainter*) const;
    virtual QString label(double) const;
protected:
    virtual void labelPlacement(const QFontMetrics&, double, QPoint&, int& /Out/, double& /Out/) const;
    virtual int maxLabelHeight(const QFontMetrics&) const;
    virtual int maxLabelWidth(const QFontMetrics&) const;
    QRect labelBoundingRect(const QFontMetrics&, double) const;
    void drawTick(QPainter*, double, int) const;
    void drawBackbone(QPainter*) const;
    void drawLabel(QPainter*, double) const;
    QWMatrix labelWorldMatrix(const QFontMetrics&, const QPoint&, int, double, const QString&) const;
}; // class QwtScaleDraw


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
