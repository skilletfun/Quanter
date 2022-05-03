# This Python file uses the following encoding: utf-8
import sys
import os
import json

from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QObject, pyqtSlot


class Solver(QObject):
    def __init__(self):
        super(Solver, self).__init__()


    @pyqtSlot(int, int, int, int, int, str, result=list)
    def solve(self, count, period, load, exit, waste, priors):
        znamenatel = 1

        if priors:
            # Гененрируется список с кортежами (индекс, приоритет) и сортируется по приоритету. Индекс - номер процесса
            priors = sorted([( el[0], int(el[1]) ) for el in enumerate(priors.split())], key=lambda x: x[1], reverse=True)
            znamenatel = sum([el[1] for el in priors])
            count = len(priors)
        else:
            znamenatel = count
        
        quant = (period - count * (load+exit+waste) ) / (znamenatel)

        if quant < 0: return []

        if priors:
            return [ [el[0], load, quant * int(el[1]), exit, waste] for el in priors ]
        else:
            return [ [i, load, quant, exit, waste] for i in range(count) ]


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    solver = Solver()

    ctx = engine.rootContext()

    ctx.setContextProperty('solver', solver)

    engine.load(os.path.join(os.path.dirname(__file__), "main.qml"))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())
