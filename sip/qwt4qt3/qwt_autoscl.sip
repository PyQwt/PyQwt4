// The SIP interface specification for:
//      QwtAutoScale.
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


class QwtAutoScale
{
%TypeHeaderCode
#include <qwt_autoscl.h>
%End // %TypeHeaderCode

public:
    enum {
        None,
        IncludeRef,
        Symmetric,
        Floating,
        Logarithmic,
        Inverted
    }; // enum

    QwtAutoScale();
    ~QwtAutoScale();
    void setAutoScale();
    bool autoScale() const;
    void setAutoRebuild(bool);
    bool autoRebuild() const;
    void changeOptions(int, bool);
    void setOptions(int);
    bool option(int) const;
    int options() const;
    void setMaxMajor(int);
    int maxMajor() const;
    void setMaxMinor(int);
    int maxMinor() const;
    void setReference(double);
    double reference() const;
    void setMargins(double, double);
    double loMargin() const;
    double hiMargin() const;
    void setScale(double, double, double = 0.0);
    const QwtScaleDiv& scaleDiv() const;
    void adjust(SIP_PYOBJECT, int = 0);
%MethodCode
QwtArray<double> array;
if (-1 == try_PyObject_to_QwtArray(a0, array))
    return 0;

sipCpp->QwtAutoScale::adjust(array, a1);
%End

    void adjust(const QwtArrayDouble&, int = 0);
    void adjust(double, double, int = 0);
    void build();
    void reset();
protected:
    void buildLinScale();
    void buildLogScale();
    void setRange(double, double);
}; // class QwtAutoScale


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
