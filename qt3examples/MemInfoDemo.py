#!/usr/bin/env python

# a translation of qwt-*/examples/linux/meminfo/meminfo.cpp

import re, sys
from qt import *
from Qwt4.Qwt import *

text = [ "Used: %3g %%",
         "Shared: %3g %%",
         "Buffers: %3g %%",
         "Cache: %3g %%",
         "Swap Used: %3g %%" ]

class MemInfoDemo(QWidget):
    
    def __init__(self, *args):
        apply(QWidget.__init__, (self,) + args)
        fnThermo = QFont("Helvetica", 8)
        fnLabel = QFont("Helvetica", 10)
        cFill = QColor("DarkMagenta")

        self.timer = 0
        
        self.therms = therms = []
        self.labels = labels = []
        for i in range(len(text)):
            labels.append(QLabel("", self))
            therms.append(QwtThermo(self, ""))
            labels[i].setGeometry(0, i*65, 130, 20)
            labels[i].setFont(fnLabel)
            labels[i].setAlignment(Qt.AlignCenter)
            therms[i].setGeometry(0, 20 + i * 65 , 130, 45)
            therms[i].setOrientation(Qt.Horizontal, QwtThermo.Bottom)
            therms[i].setRange(0.0, 100.0)
            therms[i].setValue(0.0)
            therms[i].setFont(fnThermo)
            therms[i].setPipeWidth(6)
            therms[i].setScaleMaxMajor(6)
            therms[i].setScaleMaxMinor(5)
            therms[i].setMargin(10)
            therms[i].setFillColor(cFill)

        self.setCaption("Memory Usage")
        self.setFixedSize(130, 325)

    # __init__()

    def update(self):
        file = open("/proc/meminfo", 'r')
        buffer = file.read(1024)
        file.close()
        numbers = re.findall("\d+", buffer)
        mtotal = 0.01*float(numbers[0])
        stotal = 0.01*float(numbers[6])
        data = [ float(numbers[1])/mtotal,
                 float(numbers[3])/mtotal,
                 float(numbers[4])/mtotal,
                 float(numbers[5])/mtotal,
                 float(numbers[7])/stotal ]
        for i in range(len(text)):
            self.therms[i].setValue(data[i])
            self.labels[i].setText(text[i] % data[i])

    # __update__()

    def start(self):
        self.update()
        self.timer = self.startTimer(2000)

    # start()
    
    def timerEvent(self, e):
        self.update()

    # timerEvent()

# class MemInfoDemo


def main(args):
    app = QApplication(args)
    demo = make()
    app.setMainWidget(demo)
    sys.exit(app.exec_loop())

# main()

def make():
    demo = MemInfoDemo()
    demo.resize(180, 140)
    demo.start()
    demo.show()
    return demo

# make()

# Admire!
if __name__ == '__main__':
    main(sys.argv)

# Local Variables: ***
# mode: python ***
# End: ***
