// The SIP interface specification for:
//      QwtLayoutMetrics,
//      QwtMetricsMap.
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


class QwtLayoutMetrics
{
%TypeHeaderCode
#include <qwt_layout_metrics.h>
%End // %TypeHeaderCode

public:
    QwtLayoutMetrics();
    QwtLayoutMetrics(const QwtMetricsMap&);
    void setMap(const QwtMetricsMap&);
    QRect boundingRect(const QString&, int, QPainter*) const;
    QRect boundingRect(const QString&, int, const QFontMetrics&) const;
    int heightForWidth(const QString&, int, int, const QFontMetrics&) const;
    int heightForWidth(const QString&, int, int, QPainter*) const;
    QRect boundingRect(const QSimpleRichText&, int, QPainter* = 0) const;
    int heightForWidth(QSimpleRichText&, int) const;
}; // class QwtLayoutMetrics


class QwtMetricsMap
{
%TypeHeaderCode
#include <qwt_layout_metrics.h>
%End // %TypeHeaderCode

public:
    QwtMetricsMap();
    bool isIdentity() const;
    void setMetrics(const QPaintDeviceMetrics&, const QPaintDeviceMetrics&);
    int layoutToDeviceX(int) const;
    int deviceToLayoutX(int) const;
    int screenToLayoutX(int) const;
    int layoutToScreenX(int) const;
    int layoutToDeviceY(int) const;
    int deviceToLayoutY(int) const;
    int screenToLayoutY(int) const;
    int layoutToScreenY(int) const;
    QPoint layoutToDevice(const QPoint&, const QPainter* = 0) const;
    QPoint deviceToLayout(const QPoint&, const QPainter* = 0) const;
    QPoint screenToLayout(const QPoint&) const;
    QSize layoutToDevice(const QSize&) const;
    QSize deviceToLayout(const QSize&) const;
    QSize screenToLayout(const QSize&) const;
    QRect layoutToDevice(const QRect&, const QPainter* = 0) const;
    QRect deviceToLayout(const QRect&, const QPainter* = 0) const;
    QRect screenToLayout(const QRect&) const;
    QPointArray layoutToDevice(const QPointArray&, const QPainter* = 0) const;
    QPointArray deviceToLayout(const QPointArray&, const QPainter* = 0) const;
    static QRect translate(const QWMatrix&, const QRect&);
    static QPointArray translate(const QWMatrix&, const QPointArray&);
}; // class QwtMetricsMap


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
