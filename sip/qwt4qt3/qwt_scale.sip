// The SIP interface specification for:
//      QwtScale.
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


class QwtScale: QWidget
{
%TypeHeaderCode
#include <qwt_scale.h>
%End // %TypeHeaderCode

public:
    enum Position {
        Left,
        Right,
        Top,
        Bottom
    }; // enum Position

    QwtScale(QWidget* /TransferThis/ = 0, const char* = 0);
    QwtScale(QwtScale::Position, QWidget* /TransferThis/ = 0, const char* = 0);
    virtual ~QwtScale();
    void setTitle(const QString&);
    const QString title() const;
    void setTitleColor(const QColor&);
    const QColor titleColor() const;
    void setTitleFont(const QFont&);
    const QFont titleFont() const;
    void setTitleAlignment(int);
    int titleAlignment() const;
    void setBorderDist(int, int);
    int startBorderDist() const;
    int endBorderDist() const;
    void minBorderDist(int& /Out/, int& /Out/) const;
    void setBaselineDist(int);
    int baseLineDist() const;
    void setTitleDist(int);
    int titleDist() const;
    void setScaleDiv(const QwtScaleDiv&);
    void setScaleDraw(QwtScaleDraw* /Transfer/);
    const QwtScaleDraw* scaleDraw() const;
    void setLabelFormat(char, int, int);
    void labelFormat(char& /Out/, int& /Out/, int& /Out/) const;
    void setLabelAlignment(int);
    void setLabelRotation(double);
    virtual QSize sizeHint() const;
    virtual QSize minimumSizeHint() const;
    virtual QSizePolicy sizePolicy() const;
    int titleHeightForWidth(int) const;
    int dimForLength(int, const QFontMetrics&) const;
    void drawTitle(QPainter*, QwtScaleDraw::Orientation, const QRect&) const;
    void setPosition(QwtScale::Position);
    QwtScale::Position position() const;
protected:
    void draw(QPainter*) const;
    virtual void paintEvent(QPaintEvent*);
    virtual void resizeEvent(QResizeEvent*);
    void scaleChange();
    virtual void fontChange(const QFont&);
    void layoutScale(bool = TRUE);
}; // class QwtScale


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
