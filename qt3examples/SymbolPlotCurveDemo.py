#!/usr/bin/env python

# Based on a contribution by Tony Willis.

import sys
from qt import *
from Qwt4.Qwt import *
from Qwt4.anynumpy import *


class SymbolPlotCurve(QwtPlotCurve):
    '''A QwtPlotCurve with adjustable QwtSymbols
    '''

    def __init__(self, parent=None, title=''):
        QwtPlotCurve.__init__(self, parent, title)
        self.symbolSizes = []
        self.symbolList = []

    # __init__()

    def setData(self, xData, yData, sizes=[], symbols=[]):
        '''Override default QwtCurve setData method.
        '''
        self.symbolSizes = sizes
        self.symbolList = symbols
        QwtPlotCurve.setData(self, xData, yData)
        QwtPlotCurve.curveChanged(self)

    # setData()

    def drawSymbols(self, painter, symbol, xMap, yMap, start, to):
        if 0 == len(self.symbolList) and 0 == len(self.symbolSizes):
            # Fall back on the default behaviour.
            QwtPlotCurve.drawSymbols(
                self, painter, symbol, xMap, yMap, start, to)

        painter.setBrush(symbol.brush())
        painter.setPen(symbol.pen())
        rect = QRect()
        for i in range(start, to+1):
            if len(self.symbolList):
                painter.setBrush(self.symbolList[i].brush());
                painter.setPen(self.symbolList[i].pen())
                size = self.symbolList[i].size()
                rect.setSize(QwtPainter.metricsMap().screenToLayout(size))
            if len(self.symbolSizes):
                sizex = QwtPainter.metricsMap().screenToLayoutX(
                    self.symbolSizes[i])
                sizey = QwtPainter.metricsMap().screenToLayoutY(
                    self.symbolSizes[i])
                rect.setSize(QSize(sizex, sizey))

            xi = xMap.transform(self.x(i))
            yi = yMap.transform(self.y(i))
            rect.moveCenter(QPoint(xi, yi))
            if len(self.symbolList):
                self.symbolList[i].draw(painter, rect)
            else:
                symbol.draw(painter, rect);

      # drawSymbols()

# class SymbolPlotCurve()


def make():
    demo = QwtPlot('SymbolPlotCurve Demo')
    demo.setCanvasBackground(Qt.white)
    demo.resize(300, 300)
    curveSizes = SymbolPlotCurve(demo)
    curveSizes.setPen(QPen(Qt.blue, 2))
    # a default symbol for the curve is needed
    # due to the inner workings of QwtCurve
    curveSizes.setSymbol(QwtSymbol(QwtSymbol.Ellipse,
                                   QBrush(Qt.green),
                                   QPen(Qt.black, 2),
                                   QSize(5,5)))
    curveSymbols = SymbolPlotCurve(demo)
    curveSymbols.setPen(QPen(Qt.blue, 2))
    # a default symbol for the curve is needed
    # due to the inner workings of QwtCurve
    curveSymbols.setSymbol(QwtSymbol(QwtSymbol.Ellipse,
                                     QBrush(Qt.green),
                                     QPen(Qt.black),
                                     QSize(5,5)))

    # create data
    xs = arange(0, 20, 1, Float)
    ys = 2*arange(0, 20, 1, Float)
    sizes = arange(0, 20, 1, Float) + 3
    symbols = []
    for i in range(len(sizes)):
        if i % 2:
            symbols.append(QwtSymbol(QwtSymbol.UTriangle,
                                     QBrush(Qt.blue),
                                     QPen(Qt.black, 2),
                                     QSize(sizes[i], sizes[i])))
        else:
            symbols.append(QwtSymbol(QwtSymbol.DTriangle,
                                     QBrush(Qt.red),
                                     QPen(Qt.black, 2),
                                     QSize(sizes[i], sizes[i])))
    curveSizes.setData(xs, ys, sizes=sizes)
    demo.insertCurve(curveSizes)
    xs += 10
    curveSymbols.setData(xs, ys, symbols=symbols)
    demo.insertCurve(curveSymbols)
    demo.replot()
    return demo

# make()


def main(args):
    app = QApplication(args)
    demo = make()
    demo.show()
    app.setMainWidget(demo)
    app.exec_loop()

# main()


# Admire
if __name__ == '__main__':
    main(sys.argv)

# Local Variables: ***
# mode: python ***
# End: ***
