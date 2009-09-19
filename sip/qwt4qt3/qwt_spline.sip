// The SIP interface specification for:
//      QwtSpline.
//
// Copyright (C) 2001-2009 Gerard Vermeulen
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


class QwtSpline
{
%TypeHeaderCode
#include <qwt_spline.h>
%End // %TypeHeaderCode

public:
    QwtSpline();
    ~QwtSpline();
    double value(double) const;
    int recalc(SIP_PYOBJECT, SIP_PYOBJECT, int = 0);
%MethodCode
QwtArray<double> xArray;
if (1 != try_PyObject_to_QwtArray(a0, xArray))
    return 0;

QwtArray<double> yArray;       
if (1 != try_PyObject_to_QwtArray(a1, yArray))
    return 0;

    int n = xArray.size() < yArray.size() ? xArray.size() : yArray.size();
        
    sipRes = sipCpp->QwtSpline::recalc(xArray.data(), yArray.data(), n, a2);
%End // recalc()

    int recalc(const QwtArrayDouble&, const QwtArrayDouble&, int = 0);
    // Not Pythonic: void copyValues(int = 1);
}; // class QwtSpline


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
