#!/usr/bin/env python

# Plot of Numeric & numarray arrays and lists & tuples of Python floats.

import sys
from qt import *
from Qwt4.Qwt import *

def drange(start, stop, step):
    start, stop, step = float(start), float(stop), float(step)
    size = int(round((stop-start)/step))
    result = [start]*size
    for i in xrange(size):
        result[i] += i*step
    return result

# drange()

def lorentzian(x):
    return 1.0/(1.0+(x-5.0)**2)

# lorentzian()


class MultiDemo(QWidget):
    def __init__(self, *args):
        QWidget.__init__(self, *args)

        grid = QGridLayout(self, 2, 2)
        
        # try to create a plot widget for NumPy arrays
        try:
            # import does_not_exist
            import numpy
            numpy_plot = QwtPlot('Plot -- NumPy arrays', self)
            numpy_plot.plotLayout().setCanvasMargin(0)
            numpy_plot.plotLayout().setAlignCanvasToScales(1)
            numpy_x = numpy.arange(0.0, 10.0, 0.01)
            numpy_y = lorentzian(numpy_x)
            # insert a curve, make it red and copy the arrays
            key = numpy_plot.insertCurve('y = lorentzian(x)')
            numpy_plot.setCurvePen(key, QPen(Qt.red))
            numpy_plot.setCurveData(key, numpy_x, numpy_y)
            grid.addWidget(numpy_plot, 0, 0)
            numpy_plot.replot()
        except ImportError, message:
            print "%s: %s" % (ImportError, message)
            print "Install NumPy to plot NumPy arrays"
        except TypeError, message:
            print "%s: %s" % (TypeError, message)
            print "Rebuild PyQwt to plot NumPy arrays"
            self.removeChild(numpy_plot)


        # try to create a plot widget for Numeric arrays
        try:
            # import does_not_exist
            import Numeric
            numeric_plot = QwtPlot('Plot -- Numeric arrays', self)
            numeric_plot.plotLayout().setCanvasMargin(0)
            numeric_plot.plotLayout().setAlignCanvasToScales(1)
            numeric_x = Numeric.arange(0.0, 10.0, 0.01)
            numeric_y = lorentzian(numeric_x)
            # insert a curve, make it red and copy the arrays
            key = numeric_plot.insertCurve('y = lorentzian(x)')
            numeric_plot.setCurvePen(key, QPen(Qt.red))
            numeric_plot.setCurveData(key, numeric_x, numeric_y)
            grid.addWidget(numeric_plot, 0, 1)
            numeric_plot.replot()
        except ImportError, message:
            print "%s: %s" % (ImportError, message)
            print "Install Numeric to plot Numeric arrays"
        except TypeError, message:
            print "%s: %s" % (TypeError, message)
            print "Rebuild PyQwt to plot Numeric arrays"
            self.removeChild(numeric_plot)


        # try to create a plot widget for numarray arrays
        try:
            # import does_not_exist
            import numarray
            numarray_plot = QwtPlot('Plot -- numarray arrays', self)
            numarray_plot.plotLayout().setCanvasMargin(0)
            numarray_plot.plotLayout().setAlignCanvasToScales(1)
            numarray_x = numarray.arange(0.0, 10.0, 0.01)
            numarray_y = lorentzian(numarray_x)
            # insert a curve, make it red and copy the arrays
            key = numarray_plot.insertCurve('y = lorentzian(x)')
            numarray_plot.setCurvePen(key, QPen(Qt.red))
            numarray_plot.setCurveData(key, numarray_x, numarray_y)
            grid.addWidget(numarray_plot, 1, 0)
            numarray_plot.replot()
        except ImportError, message:
            print "%s: %s" % (ImportError, message)
            print "Install numarray to plot numarray arrays"
        except TypeError, message:
            print "%s: %s" % (TypeError, message)
            print "Rebuild PyQwt to plot numarray arrays"
            self.removeChild(numarray_plot)

        
        # create a plot widget for lists of Python floats
        list_plot = QwtPlot('Plot -- List of Python floats', self)
        list_plot.plotLayout().setCanvasMargin(0)
        list_plot.plotLayout().setAlignCanvasToScales(1)
        list_x = drange(0.0, 10.0, 0.01)
        list_y = map(lorentzian, list_x)
        # insert a curve, make it red and copy the lists
        key = list_plot.insertCurve('y = lorentzian(x)')
        list_plot.setCurvePen(key, QPen(Qt.red))
        list_plot.setCurveData(key, list_x, list_y)
        grid.addWidget(list_plot, 1, 1)
        list_plot.replot()

    # __init__()

# class MultiDemo


def main(args):
    app = QApplication(args)
    demo = make()
    app.setMainWidget(demo)
    sys.exit(app.exec_loop())

# main()

def make():
    demo = MultiDemo()
    demo.resize(400, 600)
    demo.show()
    return demo

# Admire!
if __name__ == '__main__':
    main(sys.argv)

# Local Variables: ***
# mode: python ***
# End: ***
