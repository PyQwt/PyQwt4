// The SIP interface specification for:
//      QwtPlotItem,
//      QwtPlotMappedItem.
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


class QwtPlotItem
{
%TypeHeaderCode
#include <qwt_plot_item.h>
%End // %TypeHeaderCode

public:
    QwtPlotItem(QwtPlot* /TransferThis/, bool = TRUE);
    virtual ~QwtPlotItem();
    void reparent(QwtPlot*);
    QwtPlot* parentPlot();
    // signature: const QwtPlot* parentPlot() const;
    virtual void setEnabled(bool);
    bool enabled() const;
    virtual void itemChanged();

%If (HAS_QWT5)
%ConvertToSubClassCode
    Py_BEGIN_ALLOW_THREADS
    switch (sipCpp->rtti()) {
    case QwtPlotItem::Rtti_PlotItem: sipClass = sipClass_QwtPlotItem; break;
    case QwtPlotItem::Rtti_PlotGrid: sipClass = sipClass_QwtPlotGrid; break; 
#ifdef HAS_QWT_PLOT_SCALE_ITEM
    case QwtPlotItem::Rtti_PlotScale: sipClass = sipClass_QwtPlotScaleItem; break; 
#endif // HAS_QWT_PLOT_SCALE_ITEM 
    case QwtPlotItem::Rtti_PlotMarker: sipClass = sipClass_QwtPlotMarker; break; 
    case QwtPlotItem::Rtti_PlotCurve: sipClass = sipClass_QwtPlotCurve; break;
    // MISSING case QwtPlotItem::Rtti_PlotHistogram: sipClass = sipClass_QwtPlotHistogram; break;
    case QwtPlotItem::Rtti_PlotSpectrogram: sipClass = sipClass_QwtPlotSpectrogram; break;
#ifdef HAS_QWT_PLOT_SVG_ITEM
    case QwtPlotItem::Rtti_PlotSVG: sipClass = sipClass_QwtPlotSvgItem; break; 
#endif // HAS_QWT_PLOT_SVG_ITEM
    default: sipClass = 0;
    }
    Py_END_ALLOW_THREADS
%End // %ConvertToSubClassCode
%End // HAS_QWT5

}; // class QwtPlotItem


class QwtPlotMappedItem: QwtPlotItem
{
%TypeHeaderCode
#include <qwt_plot_item.h>
%End // %TypeHeaderCode

public:
    QwtPlotMappedItem(QwtPlot* /TransferThis/, bool = TRUE);
    void setAxis(int, int);
    void setXAxis(int);
    int xAxis() const;
    void setYAxis(int);
    int yAxis() const;
    virtual ~QwtPlotMappedItem();
}; // class QwtPlotMappedItem


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
