// The SIP interface specification for:
//      QwtCurve.
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


class QwtCurve
{
%TypeHeaderCode
#include <qwt_curve.h>
%End // %TypeHeaderCode

public:
    enum CurveStyle {
        NoCurve,
        Lines,
        Sticks,
        Steps,
        Dots,
        Spline,
        UserCurve
    }; // enum CurveStyle

    enum CurveOption {
        Auto,
        Yfx,
        Xfy,
        Parametric,
        Periodic,
        Inverted
    }; // enum CurveOption

    QwtCurve(const QString& = QString::null);
    QwtCurve(const QwtCurve&);
    virtual ~QwtCurve();
    // Not Pythonic: const QwtCurve& operator=(const QwtCurve&);
    // Not Pythonic: void setRawData(const double*, const double*, int);
    void setData(SIP_PYOBJECT, SIP_PYOBJECT);
%MethodCode
QwtArray<double> xArray;
if (-1 == try_PyObject_to_QwtArray(a0, xArray))
    return 0;

QwtArray<double> yArray;
if (-1 == try_PyObject_to_QwtArray(a1, yArray))
    return 0;

sipCpp->QwtCurve::setData(xArray, yArray);
%End

    void setData(const QwtArrayDouble&, const QwtArrayDouble&);
    void setData(const QwtArrayQwtDoublePoint&);
    void setData(const QwtData&);
    int dataSize() const;
    double x(int) const;
    double y(int) const;
    virtual QwtDoubleRect boundingRect() const;
    double minXValue() const;
    double maxXValue() const;
    double minYValue() const;
    double maxYValue() const;
    void setOptions(int);
    int options() const;
    void setTitle(const QString&);
    const QString& title() const;
    void setPen(const QPen&);
    const QPen& pen() const;
    void setBrush(const QBrush&);
    const QBrush& brush() const;
    void setBaseline(double);
    double baseline() const;
    void setStyle(int, int = 0);
    int style() const;
    void setSymbol(const QwtSymbol&);
    const QwtSymbol& symbol() const;
    void setSplineSize(int);
    int splineSize() const;
    virtual void draw(QPainter*, const QwtDiMap&, const QwtDiMap&, int = 0, int = -1);
protected:
    void init(const QString&);
    void copy(const QwtCurve&);
    virtual void drawCurve(QPainter*, int, const QwtDiMap&, const QwtDiMap&, int, int);
    virtual void drawSymbols(QPainter*, QwtSymbol&, const QwtDiMap&, const QwtDiMap&, int, int);
    void drawLines(QPainter*, const QwtDiMap&, const QwtDiMap&, int, int);
    void drawSticks(QPainter*, const QwtDiMap&, const QwtDiMap&, int, int);
    void drawDots(QPainter*, const QwtDiMap&, const QwtDiMap&, int, int);
    void drawSteps(QPainter*, const QwtDiMap&, const QwtDiMap&, int, int);
    void drawSpline(QPainter*, const QwtDiMap&, const QwtDiMap&);
    void closePolyline(const QwtDiMap&, const QwtDiMap&, QPointArray&) const;
    virtual void curveChanged();
    int verifyRange(int& /In,Out/, int& /In,Out/);
}; // class QwtCurve


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
