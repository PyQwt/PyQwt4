// The SIP interface specification for:
//      QwtPicker.
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


class QwtPicker: QObject, QwtEventPattern
{
%TypeHeaderCode
#include <qwt_picker.h>
%End // %TypeHeaderCode

public:
    enum SelectionType {
        NoSelection,
        PointSelection,
        RectSelection,
        PolygonSelection
    }; // enum SelectionType

    enum RectSelectionType {
        CornerToCorner,
        CenterToCorner,
        CenterToRadius
    }; // enum RectSelectionType

    enum SelectionMode {
        ClickSelection,
        DragSelection
    }; // enum SelectionMode

    enum RubberBand {
        NoRubberBand,
        HLineRubberBand,
        VLineRubberBand,
        CrossRubberBand,
        RectRubberBand,
        EllipseRubberBand,
        PolygonRubberBand,
        UserRubberBand
    }; // enum RubberBand

    enum DisplayMode {
        AlwaysOff,
        AlwaysOn,
        ActiveOnly
    }; // enum DisplayMode

    enum ResizeMode {
        Stretch,
        KeepSize
    }; // enum ResizeMode

    QwtPicker(QWidget* /TransferThis/, const char* = 0);
    QwtPicker(int, QwtPicker::RubberBand, QwtPicker::DisplayMode, QWidget* /TransferThis/, const char* = 0);
    virtual ~QwtPicker();
    virtual void setSelectionFlags(int);
    int selectionFlags() const;
    virtual void setRubberBand(QwtPicker::RubberBand);
    QwtPicker::RubberBand rubberBand() const;
    virtual void setCursorLabelMode(QwtPicker::DisplayMode);
    QwtPicker::DisplayMode cursorLabelMode() const;
    virtual void setResizeMode(QwtPicker::ResizeMode);
    QwtPicker::ResizeMode resizeMode() const;
    virtual void setRubberBandPen(const QPen&);
    QPen rubberBandPen() const;
    virtual void setCursorLabelPen(const QPen&);
    QPen cursorLabelPen() const;
    virtual void setCursorLabelFont(const QFont&);
    QFont cursorLabelFont() const;
    bool isEnabled() const;
    virtual void setEnabled(bool);
    bool isActive() const;
    virtual bool eventFilter(QObject*, QEvent*);
    QWidget* parentWidget();
    // signature: const QWidget* parentWidget() const;
    virtual QRect pickRect() const;
    const QPointArray& selection() const;
    virtual bool event(QEvent*);
signals:
    void selected(const QPointArray&);
    void appended(const QPoint&);
    void moved(const QPoint&);
    void changed(const QPointArray&);
protected:
    virtual bool accept(QPointArray&) const;
    virtual void transition(const QEvent*);
    virtual void begin();
    virtual void append(const QPoint&);
    virtual void move(const QPoint&);
    virtual bool end(bool = TRUE);
    virtual void widgetMousePressEvent(QMouseEvent*);
    virtual void widgetMouseReleaseEvent(QMouseEvent*);
    virtual void widgetMouseDoubleClickEvent(QMouseEvent*);
    virtual void widgetMouseMoveEvent(QMouseEvent*);
    virtual void widgetWheelEvent(QWheelEvent*);
    virtual void widgetKeyPressEvent(QKeyEvent*);
    virtual void widgetKeyReleaseEvent(QKeyEvent*);
    virtual void drawRubberBand(const QRect& = QRect()) const;
    virtual void drawRubberBand(QPainter*, const QRect&, const QPointArray&) const;
    virtual void drawCursorLabel(const QRect& = QRect()) const;
    virtual void drawCursorLabel(QPainter*, const QRect&, const QPoint&, const QPointArray&) const;
    virtual void stretchSelection(const QSize&, const QSize&);
    virtual QString cursorLabel(const QPoint&) const;
    virtual QwtPickerMachine* stateMachine(int) const /Factory/;
    void repaint(const QRect& = QRect());
}; // class QwtPicker


// Local Variables:
// mode: C++
// c-file-style: "stroustrup"
// indent-tabs-mode: nil
// End:
