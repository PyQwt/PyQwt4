// The SIP interface specification for:
//      QwtPainter.
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


class QwtPainter
{
%TypeHeaderCode
#include <qwt_painter.h>
%End // %TypeHeaderCode

public:
    enum TextXorRopMode {
        XorRopTextNormal,
        XorRopTextKeepFont,
        XorRopTextKeepColor
    }; // enum TextXorRopMode

    static void setMetricsMap(const QPaintDevice*, const QPaintDevice*);
    static void setMetricsMap(const QwtMetricsMap&);
    static void resetMetricsMap();
    static const QwtMetricsMap& metricsMap();
    static void setDeviceClipping(bool);
    static bool deviceClipping();
    static void setClipRect(QPainter*, const QRect&);
    static void drawText(QPainter*, int, int, const QString&, int = -1);
    static void drawText(QPainter*, const QPoint&, const QString&, int = -1);
    static void drawText(QPainter*, int, int, int, int, int, const QString&, int = -1);
    static void drawText(QPainter*, const QRect&, int, const QString&, int = -1);
    static void drawSimpleRichText(QPainter*, const QRect&, int, QSimpleRichText&);
    static void drawRect(QPainter*, int, int, int, int);
    static void drawRect(QPainter*, const QRect&);
    static void fillRect(QPainter*, const QRect&, const QBrush&);
    static void drawEllipse(QPainter*, const QRect&);
    static void drawLine(QPainter*, int, int, int, int);
    static void drawLine(QPainter*, const QPoint&, const QPoint&);
    static void drawPolygon(QPainter*, const QPointArray&);
    static void drawPolyline(QPainter*, const QPointArray&);
    static void drawPoint(QPainter*, int, int);
    static void drawRoundFrame(QPainter*, const QRect&, int, const QColorGroup&, bool);
    static QPointArray clip(const QPointArray&);
    static int textXorRopMode();
    static int setTextXorRopMode(QwtPainter::TextXorRopMode);
}; // class QwtPainter


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
