#!/usr/bin/env python

# The Python version of qwt-*/examples/linux/cpuload/cpuload.cpp
# Example finished by Hans-Peter Jansen

import sys, math
from qt import *
from Qwt4.Qwt import *


class LowPass:

    def __init__(self):
        self.tsampl = 1.0
        self.tconst = 0.0
        self.recalc()
        self.reset(0.0)

    # __init__()

    def setTConst(self, t):
        self.tconst = t
        self.recalc()

    # setTConst()

    def setTSampl(self, t):
        self.tsampl = t
        self.recalc()

    # setTSampl()

    def reset(self, v):
        self.val = v

    # reset()
        
    def input(self, v):
        self.val = self.c2*v + self.c1*self.val
        return self.val

    # input()

    def value(self):
        return self.val

    # value()
    
    def recalc(self):
        if self.tconst > 0.00001:
            self.c1 = math.exp(-self.tsampl/self.tconst)
        else:
            self.c1 = 0.0
        self.c2 = 1.0 - self.c1

    # recalc()

# class LowPass


class ConfigDiag(QDialog):

    def __init__(self, parent = None, name = None):
        QDialog.__init__(self, parent, name)
        self.ctSampl = QwtCounter(self)
        self.ctConst = QwtCounter(self)
        lbSampl = QLabel("Update Rate [s]", self)
        lbConst = QLabel("Average Time [s]", self)
        btDismiss = QPushButton("Dismiss", self)
        lbSampl.setGeometry(10,10,120,20)
        lbConst.setGeometry(10,40,120,20)
        self.ctSampl.setGeometry(130,10,120,20)
        self.ctConst.setGeometry(130,40,120,20)
        btDismiss.setGeometry(95,75,70,25)

        self.ctSampl.setRange(0.1,5.0,0.1)
        self.ctConst.setRange(0.0,60,0.5)

        self.connect(btDismiss, SIGNAL("clicked()"), self.accept)
        self.connect(
            self.ctSampl, SIGNAL("valueChanged(double)"), self.chgTSampl)
        self.connect(
            self.ctConst, SIGNAL("valueChanged(double)"), self.chgTConst)

    # __init__()

    def setTSampl(self, t):
        self.ctSampl.setValue(t)

    # setTSampl()
    
    def setTConst(self, t):
        self.ctConst.setValue(t)

    # setTConst()
    
    def chgTSampl(self, t):
        self.emit(PYSIGNAL("tSamplChg"), (t,))

    # chgTSampl()

    def chgTConst(self, t):
        self.emit(PYSIGNAL("tConstChg"), (t,))

    # chgTConst()

# class ConfigDialog


CpuUser = 0
CpuNice = 1
CpuSystem = 2
CpuIdle = 3
ThermoCnt = 4

class CPUloadDemo(QWidget):

    def __init__(self, *args):
        QWidget.__init__(self, *args)

        puProg = QPopupMenu(self)
        puProg.insertItem("Quit", qApp.quit)

        puScale = QPopupMenu(self)
        puScale.insertItem("Dynamic", self.setDynScale)
        puScale.insertItem("Fixed (0-100)", self.setFixedScale)

        puConf = QPopupMenu(self)
        puConf.insertItem("Update Mode...", self.showDialog)
        puConf.insertItem("Scale", puScale)

        self.menu = QMenuBar(self)
        self.menu.insertItem("Program", puProg)                  
        self.menu.insertItem("Options", puConf);
    
        self.cfg = ConfigDiag()

        self.lpFilters = []
        self.thermometers = []
        self.labels = []
        self.currval = []
        self.oldval = []
        self.timer = None
        self.dynscale = 0

        info = ["% User", "% Nice", "% System", " % Idle"]
        for i in range(ThermoCnt):
            self.lpFilters.append(LowPass())
            
            thermo = QwtThermo(self)
            thermo.setGeometry(10 + i*60, 30, 50, 100)
            thermo.setOrientation(QwtThermo.Vertical, QwtThermo.Left)
            thermo.setRange(0.0, 100.0)
            thermo.setValue(0.0)
            thermo.setBorderWidth(1)
            thermo.setPipeWidth(4)
            thermo.setFont(QFont("Helvetica", 10))
            thermo.setScaleMaxMajor(6)
            thermo.setScaleMaxMinor(5)
            thermo.setFillColor(QColor("MidnightBlue"))
            self.thermometers.append(thermo)

            l = QLabel(self, "")
            l.setText(info[i])
            l.setGeometry(10 + i*60, 130, 50, 20)
            l.setAlignment(Qt.AlignRight | Qt.AlignTop)
            self.labels.append(l)

            self.currval.append(0)
            self.oldval.append(0)

        self.connect(self.cfg, PYSIGNAL("tSamplChg"), self.setTSampl)
        self.connect(self.cfg, PYSIGNAL("tConstChg"), self.setTConst)

        self.read()
        self.setTConst(1.0)
        self.setTSampl(0.2)
        self.cfg.setTConst(1.0)
        self.cfg.setTSampl(0.2)
            
        self.setFixedSize(10+ThermoCnt*60, 150)

    # __init__()
    
    def setTSampl(self, seconds):
        if self.timer:
            self.killTimer(self.timer)
        for i in range(ThermoCnt):
            self.lpFilters[i].setTSampl(seconds)
        self.timer = self.startTimer(int(seconds * 1000.0))

    # setTSampl()
    
    def setTConst(self, seconds):
        for i in range(ThermoCnt):
            self.lpFilters[i].setTConst(seconds)

    # setTConst()
    
    def setFixedScale(self):
        self.dynscale = 0
        for i in range(ThermoCnt):
            self.thermometers[i].setRange(0.0, 100.0)

    def setDynScale(self):
        self.dynscale = 1

    # setDynScale()
    
    def showDialog(self):
        self.cfg.show()

    # showDialog()
    
    def read(self):
        ld = open("/proc/stat").readline()[5:-1].split(' ')
        for i in range(ThermoCnt):
            self.oldval[i] = self.currval[i]
            self.currval[i] = int(ld[i])

    # read()
    
    def update(self):
        self.read()

        delta = []
        sum = 0
        for i in range(ThermoCnt):
            v = self.currval[i] - self.oldval[i]
            sum += v
            delta.append(v)
        if sum > 0:
            factor = 100.0 / float(sum)
        else:
            factor = 0.0

        if self.dynscale:
            for i in range(ThermoCnt):
                newval = self.lpFilters[i].input(float(delta[i] * factor))
                maxval = max(qwtCeil125(newval), 3.0)
                if maxval > self.thermometers[i].maxValue() or \
                    maxval < 0.35 * self.thermometers[i].maxValue():
                    self.thermometers[i].setRange(0.0, qwtCeil125(maxval))
                self.thermometers[i].setValue(newval)
        else:
            for i in range(ThermoCnt):
                self.thermometers[i].setValue(
                        self.lpFilters[i].input(float(delta[i] * factor)))

    # update()
    
    def timerEvent(self, e):
        self.update()

    # timerEvent()
    
# class CPUloadDemo


def make():
    demo = CPUloadDemo()
    demo.setCaption("CPU Load")
    demo.show()
    return demo

# make()

def main():
    app = QApplication(sys.argv)
    demo = make()
    app.setMainWidget(demo)
    return(app.exec_loop())

# main()

# Look closer
def mainprofile():
    import profile
    pf = 'profile_results'
    profile.run('main()', pf)
    import pstats
    p = pstats.Stats(pf)
    p.sort_stats('cumulative').print_stats(50)
    os.unlink(pf)

# mainprofile()

# Admire
if __name__ == '__main__':
    if '-p' in sys.argv:
        mainprofile()
    else:
        main()

# Local Variables: ***
# mode: python ***
# End: ***

