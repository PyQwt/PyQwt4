// The SIP interface specification for:
//      QwtPlotCanvas.
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


class QwtPlotCanvas: QFrame
{
%TypeHeaderCode
#include <qwt_plot_canvas.h>
%End // %TypeHeaderCode

public:
    enum FocusIndicator {
        NoFocusIndicator,
        CanvasFocusIndicator,
        ItemFocusIndicator
    }; // enum FocusIndicator

    void setFocusIndicator(QwtPlotCanvas::FocusIndicator);
    QwtPlotCanvas::FocusIndicator focusIndicator() const;
    void setCacheMode(bool);
    bool cacheMode() const;
    // dead code: const QPixmap* cache() const;
    void invalidateCache();
protected:
    QwtPlotCanvas(QwtPlot* /TransferThis/);
    virtual ~QwtPlotCanvas();
    QPixmap* cache();
    virtual void frameChanged();
    virtual void drawContents(QPainter*);
    virtual void drawFocusIndicator(QPainter*, const QRect&);
    void drawCanvas(QPainter* = 0);
public:
    void enableOutline(bool);
    bool outlineEnabled() const;
    void setOutlinePen(const QPen&);
    const QPen& outlinePen() const;
    void setOutlineStyle(Qwt::Shape);
    Qwt::Shape outlineStyle() const;
signals:
    void mousePressed(const QMouseEvent&);
    void mouseReleased(const QMouseEvent&);
    void mouseMoved(const QMouseEvent&);
protected:
    virtual void mousePressEvent(QMouseEvent*);
    virtual void mouseReleaseEvent(QMouseEvent*);
    virtual void mouseMoveEvent(QMouseEvent*);
}; // class QwtPlotCanvas


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
