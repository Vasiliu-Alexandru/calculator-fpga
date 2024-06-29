# calculator-fpga

Calculator cu urmatoarele operatii: adunare, scadere, inmultire, impartire, factorial, ridicare la putere, radical. 
Fiecare modul este implementat folosind Verilog HDL, iar la final se va pune pe o placa FPGA Cyclone IV care are un port PS2 si VGA.

Operanzii sunt introdusi prin intermediul unei tastaturi cu conexiune PS2, iar operatia se selecteaza apasand pe tasta corespunzatoare:
    +-adunare
    - -scadere
    *-inmultire
    /-impartire
    f-factorial
    p-ridicare la putere
    r-radical
    
Calculatorul nu poate lucra cu numere peste 99999999 si lucreaza doar cu intregi fara semn.
Numerele introduse de la tastatura se vor afisa pe ecran, iar dupa apasarea tastei enter se afiseaza rezultatul sub forma de intreg (se rotunjeste in jos).
Rezolutia ecranului este 640x480.
Eroarea maxima admisibila = 1:   de ex pt 999/100=9.99 se va afisa 9.
Se vor trata cazuri de overflow, impartire la 0.
Frecventa semnalului de tact pt placa noastra FPGA este 50Mhz.
Pentru simulare folosim ModelSim, iar pentru sintetizare/punere pe placa folosim Intel® Quartus® Prime Lite Edition.
Ne vom folosi de operatorii +,-,* care sunt gata implementate si sintetizabile.

