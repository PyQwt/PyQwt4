// The SIP interface specification for:
//      QwtSliderBase.
//
// Copyright (C) 2001-2006 Gerard Vermeulen
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


class QwtSliderBase: QWidget, QwtDblRange
{
%TypeHeaderCode
#include <qwt_sldbase.h>
%End // %TypeHeaderCode

public:
    enum ScrollMode {
        ScrNone,
        ScrMouse,
        ScrTimer,
        ScrDirect,
        ScrPage
    }; // enum ScrollMode

    QwtSliderBase(Qt::Orientation, QWidget* /TransferThis/ = 0, const char* = 0, uint = 0);
    virtual ~QwtSliderBase();
    void setUpdateTime(int);
    void stopMoving();
    void setTracking(bool);
    virtual void setMass(double);
    virtual double mass() const;
    virtual void setOrientation(Qt::Orientation);
    Qt::Orientation orientation() const;
    bool isReadOnly() const;
    bool isValid() const;
    void setValid(bool);
public slots:
    virtual void setValue(double);
    virtual void fitValue(double);
    virtual void incValue(int);
    virtual void setReadOnly(bool);
signals:
    void valueChanged(double);
    void sliderPressed();
    void sliderReleased();
    void sliderMoved(double);
protected:
    void setPosition(const QPoint&);
    virtual void valueChange();
    virtual void timerEvent(QTimerEvent*);
    virtual void mousePressEvent(QMouseEvent*);
    virtual void mouseReleaseEvent(QMouseEvent*);
    virtual void mouseMoveEvent(QMouseEvent*);
    virtual void keyPressEvent(QKeyEvent*);
    virtual void wheelEvent(QWheelEvent*);
    virtual double getValue(const QPoint&) = 0;
    virtual void getScrollMode(const QPoint&, int& /Out/, int& /Out/) = 0;
}; // class QwtSliderBase


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
