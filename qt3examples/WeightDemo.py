#!/usr/bin/env python

# Contributed by Tony Willis.
# An exemple to show side by side plots with the same X axis labels.

import random, sys
from qt import *
from Qwt4.Qwt import *
from Qwt4.anynumpy import *


class DoubleScaleDraw(QwtScaleDraw):
    """A scale draw which simulates two scale draws for a single axis.
    """
    
    def __init__(self, start_value, end_value):
        QwtScaleDraw.__init__(self)
        self.start_value = start_value
        self.end_value = end_value
        self.delta = self.end_value - self.start_value

    # __init__()

    def label(self, v):
        if v >= self.end_value:
            v = v - self.delta
        return QwtScaleDraw.label(self, v)

    # label()

    def draw(self, painter):
        # 1. paint low value ticks as done in C++ code
        # 2. paint high value ticks with a shift depending on
        #    the dimension and tick spacing
        # 3. draw backbone, if needed

        step_eps = 1.0e-6    # constant value in the C++ equivalent
        scldiv = QwtScaleDraw.scaleDiv(self)
        majLen, medLen, minLen = QwtScaleDraw.tickLength(self)
        self.offset = 0
        self.separator = self.end_value
        # plot major ticks
        for i in range(scldiv.majCnt()):
            val = scldiv.majMark(i)
            v = val
            if val >= self.end_value:
                v = val - self.delta
            if self.offset == 0 and v != val:
                self.offset = scldiv.majStep() - v % scldiv.majStep()
            val = val + self.offset
            QwtScaleDraw.drawTick(self, painter, val, majLen)
            QwtScaleDraw.drawLabel(self, painter, val)

        # also, plot a major tick at the dividing point
        QwtScaleDraw.drawTick(self, painter, self.separator, majLen)
        QwtScaleDraw.drawLabel(self, painter, self.separator)

        # probably can't handle logs properly??
        if scldiv.logScale():
            for i in range(scldiv.minCnt()):
                QwtScaleDraw.drawTick(
                    self, painter, scldiv.minMark(i), minLen)
        else:
            # do minor ticks
            kmax = scldiv.majCnt() - 1
            if kmax > 0:
                majTick = scldiv.majMark(0)
                hval = majTick - 0.5 * scldiv.majStep()
                k = 0
                for i in range(scldiv.minCnt()):
                    val = scldiv.minMark(i)
                    if  val > majTick:
                        if k < kmax:
                            k = k + 1
                            majTick = scldiv.majMark(k)
                        else:
                            majTick += (scldiv.majMark(kmax)
                                        + scldiv.majStep())
                        hval = majTick - 0.5 * scldiv.majStep()
                    if abs(val-hval) < step_eps * scldiv.majStep():
                        QwtScaleDraw.drawTick(self, painter, val, medLen)
                    else:
                        QwtScaleDraw.drawTick(self, painter, val, minLen)

        if QwtScaleDraw.options(self) & QwtScaleDraw.Backbone:
            QwtScaleDraw.drawBackbone(self, painter)

    # draw()
    
# class DoubleScaleDraw()


class WeightPlot(QwtPlot):
    """Displays the length as a function of weight for a group of females and
    a group of males.   The weight of the females is in the range (0, 100) and
    the weight of the males is in the range (100, 200).
    However, the DoubleScaleDraw helps to plot the data side-by-side with two
    axes running from 0 to 100.
    """

    def __init__(self, *args):
        QwtPlot.__init__(self, *args)
        self.setCanvasBackground(Qt.white)

        # Initialize data arrays
        num_data_points = 100
        self.f_wt = zeros(num_data_points, Float) # female weight
        self.f = zeros(len(self.f_wt), Float)     # female height
        self.m_wt = zeros(len(self.f_wt), Float)  # male weight
        self.m = zeros(len(self.f_wt), Float)     # male height

        # generate some fake data
        self.generateData()

        self.setTitle("Male / Female Height vs Weight")
        self.setAutoLegend(True)

        self.curveF = self.insertCurve("Female Data")
        self.curveM = self.insertCurve("Male Data")

        self.setCurveSymbol(self.curveM, QwtSymbol(
            QwtSymbol.Ellipse, QBrush(Qt.blue), QPen(Qt.blue), QSize(7, 7)))
        self.setCurveSymbol(self.curveF, QwtSymbol(
            QwtSymbol.Ellipse, QBrush(Qt.red), QPen(Qt.red), QSize(7, 7)))

        self.setCurvePen(self.curveF, QPen(Qt.red))
        self.setCurvePen(self.curveM, QPen(Qt.blue))
        self.setCurveStyle(self.curveF, QwtCurve.Dots)
        self.setCurveStyle(self.curveM, QwtCurve.Dots)

        self.setAxisTitle(QwtPlot.xBottom, "Weight (kg)")
        self.setAxisTitle(QwtPlot.yLeft, "Height (cm)")

        # code to make second half of the X axis appear to
        # still display units in the range 0 to 100 kg
        self.setAxisScaleDraw(QwtPlot.xBottom, DoubleScaleDraw(0.0, 100.0) )
        self.marker = self.insertLineMarker('', QwtPlot.xBottom)
        self.setMarkerLinePen(self.marker, QPen(Qt.black, 2, Qt.SolidLine))
        self.setMarkerXPos(self.marker, 100.0)

        self.setCurveData(self.curveF, self.f_wt, self.f)
        self.setCurveData(self.curveM, self.m_wt, self.m)

        self.updateAxes()


    # __init__()
    
    def generateData(self):
        """ generate some fake data for sample of males and females """

        # female height
        for i in range(len(self.f)):
            self.f[i] = 20 + 100 *random.random()
        # female weight - has some height dependence
        for i in range(len(self.f_wt)):
            self.f_wt[i] = (self.f[i]/10.0) + 80 *random.random()
            # modify height a bit: taller women will tend to weight a bit more
            self.f[i] = self.f[i] + self.f_wt[i]/2.0
		
        # male height
        for i in range(len(self.m)):
            self.m[i] = 50 + 150 *random.random()

        # male weight - has some height dependence
        # note: we add extra value of 100 to offset male weights 
        # 100 units to the right
        for i in range(len(self.m_wt)):
            self.m_wt[i] = (self.m[i]/10.0) + 80 *random.random()
            self.m[i] = self.m[i] + self.m_wt[i]/2.0
            self.m_wt[i] = self.m_wt[i] + 100

# class WeightPlot

def main(args): 
    app = QApplication(args)
    demo = make()
    app.setMainWidget(demo)
    app.exec_loop()

# main()

def make():
    demo = WeightPlot()
    demo.resize(500, 300)
    demo.show()
    
    return demo

# make()

# Admire
if __name__ == '__main__':
    main(sys.argv)

# Local Variables: ***
# mode: python ***
# End: ***
