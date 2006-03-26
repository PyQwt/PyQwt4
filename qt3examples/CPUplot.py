#!/usr/bin/env python

# The Python version of qwt-*/examples/cpuplot

import os, sys
from qt import *
from Qwt4.Qwt import *
from Qwt4.anynumpy import *

class CpuStat:

    User = 0
    Nice = 1
    System = 2
    Idle = 3
    counter = 0
    dummyValues = (
        ( 103726, 0, 23484, 819556 ),
        ( 103783, 0, 23489, 819604 ),
        ( 103798, 0, 23490, 819688 ),
        ( 103820, 0, 23490, 819766 ),
        ( 103840, 0, 23493, 819843 ),
        ( 103875, 0, 23499, 819902 ),
        ( 103917, 0, 23504, 819955 ),
        ( 103950, 0, 23508, 820018 ),
        ( 103987, 0, 23510, 820079 ),
        ( 104020, 0, 23513, 820143 ),
        ( 104058, 0, 23514, 820204 ),
        ( 104099, 0, 23520, 820257 ),
        ( 104121, 0, 23525, 820330 ),
        ( 104159, 0, 23530, 820387 ),
        ( 104176, 0, 23534, 820466 ),
        ( 104215, 0, 23538, 820523 ),
        ( 104245, 0, 23541, 820590 ),
        ( 104267, 0, 23545, 820664 ),
        ( 104311, 0, 23555, 820710 ),
        ( 104355, 0, 23565, 820756 ),
        ( 104367, 0, 23567, 820842 ),
        ( 104383, 0, 23572, 820921 ),
        ( 104396, 0, 23577, 821003 ),
        ( 104413, 0, 23579, 821084 ),
        ( 104446, 0, 23588, 821142 ),
        ( 104521, 0, 23594, 821161 ),
        ( 104611, 0, 23604, 821161 ),
        ( 104708, 0, 23607, 821161 ),
        ( 104804, 0, 23611, 821161 ),
        ( 104895, 0, 23620, 821161 ),
        ( 104993, 0, 23622, 821161 ),
        ( 105089, 0, 23626, 821161 ),
        ( 105185, 0, 23630, 821161 ),
        ( 105281, 0, 23634, 821161 ),
        ( 105379, 0, 23636, 821161 ),
        ( 105472, 0, 23643, 821161 ),
        ( 105569, 0, 23646, 821161 ),
        ( 105666, 0, 23649, 821161 ),
        ( 105763, 0, 23652, 821161 ),
        ( 105828, 0, 23661, 821187 ),
        ( 105904, 0, 23666, 821206 ),
        ( 105999, 0, 23671, 821206 ),
        ( 106094, 0, 23676, 821206 ),
        ( 106184, 0, 23686, 821206 ),
        ( 106273, 0, 23692, 821211 ),
        ( 106306, 0, 23700, 821270 ),
        ( 106341, 0, 23703, 821332 ),
        ( 106392, 0, 23709, 821375 ),
        ( 106423, 0, 23715, 821438 ),
        ( 106472, 0, 23721, 821483 ),
        ( 106531, 0, 23727, 821517 ),
        ( 106562, 0, 23732, 821582 ),
        ( 106597, 0, 23736, 821643 ),
        ( 106633, 0, 23737, 821706 ),
        ( 106666, 0, 23742, 821768 ),
        ( 106697, 0, 23744, 821835 ),
        ( 106730, 0, 23748, 821898 ),
        ( 106765, 0, 23751, 821960 ),
        ( 106799, 0, 23754, 822023 ),
        ( 106831, 0, 23758, 822087 ),
        ( 106862, 0, 23761, 822153 ),
        ( 106899, 0, 23763, 822214 ),
        ( 106932, 0, 23766, 822278 ),
        ( 106965, 0, 23768, 822343 ),
        ( 107009, 0, 23771, 822396 ),
        ( 107040, 0, 23775, 822461 ),
        ( 107092, 0, 23780, 822504 ),
        ( 107143, 0, 23787, 822546 ),
        ( 107200, 0, 23795, 822581 ),
        ( 107250, 0, 23803, 822623 ),
        ( 107277, 0, 23810, 822689 ),
        ( 107286, 0, 23810, 822780 ),
        ( 107313, 0, 23817, 822846 ),
        ( 107325, 0, 23818, 822933 ),
        ( 107332, 0, 23818, 823026 ),
        ( 107344, 0, 23821, 823111 ),
        ( 107357, 0, 23821, 823198 ),
        ( 107368, 0, 23823, 823284 ),
        ( 107375, 0, 23824, 823377 ),
        ( 107386, 0, 23825, 823465 ),
        ( 107396, 0, 23826, 823554 ),
        ( 107422, 0, 23830, 823624 ),
        ( 107434, 0, 23831, 823711 ),
        ( 107456, 0, 23835, 823785 ),
        ( 107468, 0, 23838, 823870 ),
        ( 107487, 0, 23840, 823949 ),
        ( 107515, 0, 23843, 824018 ),
        ( 107528, 0, 23846, 824102 ),
        ( 107535, 0, 23851, 824190 ),
        ( 107548, 0, 23853, 824275 ),
        ( 107562, 0, 23857, 824357 ),
        ( 107656, 0, 23863, 824357 ),
        ( 107751, 0, 23868, 824357 ),
        ( 107849, 0, 23870, 824357 ),
        ( 107944, 0, 23875, 824357 ),
        ( 108043, 0, 23876, 824357 ),
        ( 108137, 0, 23882, 824357 ),
        ( 108230, 0, 23889, 824357 ),
        ( 108317, 0, 23902, 824357 ),
        ( 108412, 0, 23907, 824357 ),
        ( 108511, 0, 23908, 824357 ),
        ( 108608, 0, 23911, 824357 ),
        ( 108704, 0, 23915, 824357 ),
        ( 108801, 0, 23918, 824357 ),
        ( 108891, 0, 23928, 824357 ),
        ( 108987, 0, 23932, 824357 ),
        ( 109072, 0, 23943, 824361 ),
        ( 109079, 0, 23943, 824454 ),
        ( 109086, 0, 23944, 824546 ),
        ( 109098, 0, 23950, 824628 ),
        ( 109108, 0, 23955, 824713 ),
        ( 109115, 0, 23957, 824804 ),
        ( 109122, 0, 23958, 824896 ),
        ( 109132, 0, 23959, 824985 ),
        ( 109142, 0, 23961, 825073 ),
        ( 109146, 0, 23962, 825168 ),
        ( 109153, 0, 23964, 825259 ),
        ( 109162, 0, 23966, 825348 ),
        ( 109168, 0, 23969, 825439 ),
        ( 109176, 0, 23971, 825529 ),
        ( 109185, 0, 23974, 825617 ),
        ( 109193, 0, 23977, 825706 ),
        ( 109198, 0, 23978, 825800 ),
        ( 109206, 0, 23978, 825892 ),
        ( 109212, 0, 23981, 825983 ),
        ( 109219, 0, 23981, 826076 ),
        ( 109225, 0, 23981, 826170 ),
        ( 109232, 0, 23984, 826260 ),
        ( 109242, 0, 23984, 826350 ),
        ( 109255, 0, 23986, 826435 ),
        ( 109268, 0, 23987, 826521 ),
        ( 109283, 0, 23990, 826603 ),
        ( 109288, 0, 23991, 826697 ),
        ( 109295, 0, 23993, 826788 ),
        ( 109308, 0, 23994, 826874 ),
        ( 109322, 0, 24009, 826945 ),
        ( 109328, 0, 24011, 827037 ),
        ( 109338, 0, 24012, 827126 ),
        ( 109347, 0, 24012, 827217 ),
        ( 109354, 0, 24017, 827305 ),
        ( 109367, 0, 24017, 827392 ),
        ( 109371, 0, 24019, 827486 ),
        )
    
    def __init__(self):
        self.procValues = self.__lookup()

    # __init__()
  
    def statistic(self):
        values = self.__lookup()
        userDelta = 0.0
        for i in [CpuStat.User, CpuStat.Nice]:
            userDelta += (values[i] - self.procValues[i])
        systemDelta = values[CpuStat.System] - self.procValues[CpuStat.System]
        totalDelta = 0.0
        for i in range(len(self.procValues)):
            totalDelta += (values[i] - self.procValues[i])
        self.procValues = values
        return 100.0*userDelta/totalDelta, 100.0*systemDelta/totalDelta

    # statistics()
    
    def upTime(self):
        result = QTime()
        for item in self.procValues:
            result = result.addSecs(item/100)
        return result

    # upTime()

    def average(self):
        if os.path.exists("/proc/loadavg"):
            file = open("/proc/loadavg")
            line = file.readline()
            file.close()
            words = line.split()
            return 100.0*float(words[2])
        else:
            return 30.0

    # average()
    
    def __lookup(self):
        if os.path.exists("/proc/stat"):
            file = open("/proc/stat")
            lines = file.readlines()
            file.close()
            for line in lines:
                words = line.split()
                if words[0] == "cpu" and len(words) >= 5:
                    return map(float, words[1:])
        else:
            result = CpuStat.dummyValues[CpuStat.counter]
            CpuStat.counter += 1
            CpuStat.counter %= len(CpuStat.dummyValues)
            return result

    # __lookup

# class CpuStat


class TimeScaleDraw(QwtScaleDraw):

    def __init__(self, baseTime, *args):
        apply(QwtScaleDraw.__init__, (self,) + args)
        self.baseTime = baseTime
        #self.setLabelRotation(-50.0)
        #self.setLabelAlignment(Qt.AlignLeft | Qt.AlignBottom)

    # __init__()

    def label(self, value):
        upTime = self.baseTime.addSecs(int(value))
        return upTime.toString()

    # label()

# class TimeScaleDraw


class CpuAverageCurve(QwtPlotCurve):

    def __init__(self, *args):
        apply(QwtPlotCurve.__init__, (self,) + args)

    # __init__()

    def drawCurve(self, painter, style, xMap, yMap, first, last):
        polyline = QPointArray(2*(last-first+1))
        k = 0
        for i in range(first, last+1):
            x = xMap.transform(self.x(i))
            y = yMap.transform(self.y(i))
            polyline.setPoint(k, x, y)
            k += 1
        totalCurve = self.parentPlot().cpuPlotCurve('Total')
        for j in range(last, first-1, -1):
            x = xMap.transform(totalCurve.x(j))
            y = yMap.transform(totalCurve.y(j))
            polyline.setPoint(k, x, y)
            k += 1
        painter.drawPolygon(polyline)


class CpuPieMarker(QwtPlotMarker):
    
    def __init__(self, *args):
        apply(QwtPlotMarker.__init__, (self,) + args)

    # __init__()

    def draw(self, painter, x, y, rect):
        plot = self.parentPlot()
        yMap = plot.canvasMap(QwtPlot.yLeft)
        margin = 5
        pieRect = QRect()
        pieRect.setX(rect.x() + margin)
        pieRect.setY(rect.y() + margin)
        pieRect.setHeight(yMap.transform(80.0))
        pieRect.setWidth(pieRect.height())

        angle = 3*5760/4
        for key in ["User", "System", "Idle"]:
            curve = plot.cpuPlotCurve(key)
            if curve.dataSize():
                value = int(5760*curve.y(0)/100.0)
                painter.save()
                painter.setBrush(
                    QBrush(curve.pen().color(), QBrush.SolidPattern))
                painter.drawPie(pieRect, -angle, -value)
                painter.restore()
                angle += value

    # draw()

# class CpuPieMarker
                        
    
HISTORY = 60


class CpuPlot(QwtPlot):

    def __init__(self, *args):
        apply(QwtPlot.__init__, (self,) + args)

        self.data = {}
        self.keys = {}
        self.timeData = 1.0*arange(HISTORY-1, -1, -1)
        self.cpuStat = CpuStat()

        self.plotLayout().setCanvasMargin(0)
        self.plotLayout().setAlignCanvasToScales(1)
        self.setCanvasBackground(Qt.darkGray)
        
        self.setAutoLegend(1)
        self.setLegendPos(Qwt.Right)
        
        self.setAxisTitle(QwtPlot.xBottom, "System Uptime [h:m:s]")

        self.setAxisScaleDraw(QwtPlot.xBottom,
                              TimeScaleDraw(self.cpuStat.upTime()))
        self.setAxisScale(QwtPlot.xBottom, 0, HISTORY)
        self.setAxisLabelRotation(QwtPlot.xBottom, -50.0)
        self.setAxisLabelAlignment(QwtPlot.xBottom,
                                   Qt.AlignLeft | Qt.AlignBottom)

        self.setAxisTitle(QwtPlot.yLeft, "Cpu Usage [%]")
        self.setAxisScale(QwtPlot.yLeft, 0, 100)

        key = self.insertCurve("Total")
        self.setCurvePen(key, QPen(Qt.black))
        self.setCurveBrush(key, QBrush(QColor(), QBrush.SolidPattern))
        self.data['Total'] = zeros(HISTORY, Float)
        self.keys['Total'] = key

        key = self.insertCurve("Idle")
        self.setCurvePen(key, QPen(Qt.lightGray))
        self.setCurveBrush(key, QBrush(QColor(), QBrush.Dense4Pattern))
        self.data['Idle'] = zeros(HISTORY, Float)
        self.keys['Idle'] = key
        
        key = self.insertCurve("User")
        self.setCurvePen(key, QPen(Qt.blue))
        self.setCurveBrush(key, QBrush(QColor(), QBrush.Dense2Pattern))
        self.data['User'] = zeros(HISTORY, Float)
        self.keys['User'] = key

        key = self.insertCurve("System")
        self.setCurvePen(key, QPen(Qt.red))
        self.setCurveBrush(key, QBrush(QColor(), QBrush.Dense2Pattern))
        self.data['System'] = zeros(HISTORY, Float)
        self.keys['System'] = key

        key = self.insertCurve(CpuAverageCurve(self, "Average"))
        self.setCurvePen(key, QPen(Qt.NoPen))
        self.setCurveBrush(key, QBrush(Qt.black, QBrush.BDiagPattern))
        self.data['Average'] = zeros(HISTORY, Float)
        self.keys['Average'] = key

        self.insertMarker(CpuPieMarker(self))

        self.startTimer(1000)
        self.replot()

        self.connect(self, SIGNAL("legendClicked(long)"), self.toggleCurve)

    # __init__()
    
    def cpuPlotCurve(self, key):
        return self.curve(self.keys[key])

    # cpuPlotCurve()
    
    def drawCanvas(self, p):
        yMap = self.canvasMap(QwtPlot.yLeft)

        r = p.window()
        r.setHeight(yMap.transform(80.0) - r.top())
        p.fillRect(r, QBrush(Qt.white))

        r.setTop(yMap.transform(80.0))
        r.setHeight(yMap.transform(40.0) - yMap.transform(80.0))
        p.fillRect(r, QBrush(Qt.gray))

        QwtPlot.drawCanvas(self, p)

    # drawCanvas()
    
    def timerEvent(self, e):
        for key in self.data.keys():
            self.data[key][1:-1] = self.data[key][0:-2]
        self.data["User"][0], self.data["System"][0] = self.cpuStat.statistic()
        self.data["Total"][0] = self.data["User"][0] + self.data["System"][0]
        self.data["Idle"][0] = 100.0 - self.data["Total"][0]
        self.data["Average"][0] = self.cpuStat.average()

        self.timeData += 1.0

        self.setAxisScale(QwtPlot.xBottom, self.timeData[-1], self.timeData[0])
        for key in self.data.keys():
            self.setCurveData(self.keys[key], self.timeData, self.data[key])

        self.replot()

    # timerEvent()
    
    def toggleCurve(self, key):
        curve = self.curve(key)
        if curve:
            curve.setEnabled(not curve.enabled())
            self.replot()

    # toggleCurve()

# class CpuPlot


def main(args):
    app = QApplication(args)
    box = make()
    app.setMainWidget(box)
    app.exec_loop()

# main()

def make():
    box = QVBox()
    plot = CpuPlot(box)
    plot.setTitle("History")
    plot.setMargin(5)
    info = QString("Press the legend to en/disable a curve")
    QLabel(info, box)
    box.resize(500, 300)
    box.show()
    return box

# make()

# Admire!
if __name__ == '__main__':
    main(sys.argv)

# Local Variables: ***
# mode: python ***
# End: ***
