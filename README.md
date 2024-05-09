# calculator-fpga

Calculator cu urmatoarele operatii: adunare, scadere, inmultire, impartire, factorial, ridicare la putere, radical. 
Fiecare modul este implementat folosind Verilog HDL, iar la final se va pune pe o placa FPGA Cyclone IV care are un port PS2 si VGA.
Vom face un model software in C care va fi folosit la simulare, pentru a ne asigura ca totul functioneaza conform specificatiei.

Operanzii sunt introdusi prin intermediul unei tastaturi cu conexiune PS2, iar operatia se selecteaza apasand pe tasta corespunzatoare:
    a-adunare
    s-scadere
    i-inmultire
    d-impartire
    f-factorial
    p-ridicare la putere
    r-radical
    
Calculatorul nu poate lucra cu numere peste 99.999.999 si lucreaza doar cu intregi cu semn.
Numerele introduse de la tastatura se vor afisa pe ecran, iar dupa apasarea tastei enter se afiseaza rezultatul sub forma de intreg (se rotunjeste in jos).
Rezolutia ecranului este 640x480.
Pentru introducerea unui numar negativ se apasa tasta - inainte de introducerea numarului.
Eroarea maxima admisibila = 1:   de ex pt 999/100=9.99 se va afisa 9.
Se vor trata cazuri de overflow, impartire la 0, radical din numar negativ, factorial de numar negativ.
Frecventa semnalului de tact pt placa noastra FPGA este 50Mhz.
Pentru simulare folosim ModelSim, iar pentru sintetizare/punere pe placa folosim Intel® Quartus® Prime Lite Edition.
Ne vom folosi de operatorii +,-,* care sunt gata implementate si sintetizabile.


Module Realizate: suma, diferenta, inmultire, impartire, factorial

TO DO LIST
-radical
-ridicare la putere
