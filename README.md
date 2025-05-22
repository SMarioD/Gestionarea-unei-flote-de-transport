# Gestionarea unei Flote de Transport (Oracle SQL & PL/SQL)

Acesta este un proiect academic ce implementează o bază de date relațională în Oracle SQL pentru gestionarea eficientă a unei flote de transport. Proiectul include definirea structurii bazei de date, popularea cu date de test, implementarea constrângerilor pentru integritatea datelor și dezvoltarea unor use-case-uri specifice folosind PL/SQL.

**Coordonator:** Prof. Mironeanu Cătălin
**Student:** Stoian Mario-Daniel
**Grupa:** 1312A
**Instituție:** Universitatea Tehnică "Gheorghe Asachi" din Iași
**An:** 2024

## Cuprins

1.  [Descrierea Proiectului](#descrierea-proiectului)
2.  [Funcționalități Principale](#funcționalități-principale)
3.  [Tehnologii Utilizate](#tehnologii-utilizate)
4.  [Schema Bazei de Date](#schema-bazei-de-date)
    *   [Tabele Principale](#tabele-principale)
    *   [Relații](#relații)
    *   [Normalizare](#normalizare)
    *   [Diagrama Entitate-Relație (ERD)](#diagrama-entitate-relație-erd)
5.  [Structura Fișierelor Proiectului](#structura-fișierelor-proiectului)
6.  [Use-Case-uri Implementate (PL/SQL)](#use-case-uri-implementate-plsql)
7.  [Testarea Constrângerilor](#testarea-constrângerilor)
8.  [Instalare și Rulare](#instalare-și-rulare)

## Descrierea Proiectului

Proiectul vizează analiza, proiectarea și implementarea unei baze de date care să modeleze gestiunea unei flote de transport. Informațiile gestionate includ:
*   Vehiculele din flotă (marcă, model, an, VIN, locație curentă)
*   Șoferii (nume, număr permis, status, acțiuni, departament)
*   Departamentele companiei și locațiile asociate
*   Rutele de transport (locație start/sfârșit, distanță)
*   Programările de mentenanță pentru vehicule
*   Plățile efectuate către șoferi

## Funcționalități Principale

*   Evidența detaliată a vehiculelor și alocarea acestora șoferilor.
*   Managementul șoferilor, inclusiv statusul lor (liber/ocupat) și numărul de curse efectuate.
*   Definirea și gestionarea rutelor de transport.
*   Înregistrarea și urmărirea operațiunilor de mentenanță.
*   Evidența plăților salariale pentru șoferi.
*   Asigurarea integrității datelor prin constrângeri multiple (PK, FK, UNIQUE, CHECK, NOT NULL).
*   Automatizarea unor procese de business prin blocuri PL/SQL.

## Tehnologii Utilizate

*   **Oracle SQL:** Pentru definirea structurii bazei de date (DDL), manipularea datelor (DML) și interogări.
*   **PL/SQL:** Pentru implementarea logicii de business complexe, a procedurilor stocate și a use-case-urilor.

## Schema Bazei de Date

### Tabele Principale

*   `Departments`: Informații despre departamentele companiei.
*   `Drivers`: Detalii despre șoferii angajați.
*   `Vehicles`: Informații despre vehiculele din flotă.
*   `Routes`: Detalii despre rutele de transport.
*   `Maintenance`: Înregistrări ale operațiunilor de mentenanță.
*   `Payments`: Evidența plăților efectuate către șoferi.

### Relații

*   **1:1** între `Departments` și `Routes` (un departament este asociat unei rute principale de operare).
*   **1:N** între `Departments` și `Drivers` (un departament poate avea mai mulți șoferi).
*   **1:N** între `Drivers` și `Vehicles` (un șofer poate fi responsabil de mai multe vehicule, deși în use-case-ul principal un vehicul are un șofer asignat la un moment dat).
*   **1:N** între `Vehicles` și `Maintenance` (un vehicul poate avea mai multe înregistrări de mentenanță).
*   **1:N** între `Drivers` și `Payments` (un șofer poate primi mai multe plăți).

### Normalizare

Baza de date a fost proiectată respectând formele normale până la **Forma Normală Boyce-Codd (BCNF)** pentru a minimiza redundanța datelor și a preveni anomaliile de actualizare.

## Structura Fișierelor Proiectului

*   `Script_pentru_crearea_tabelor.txt`: Conține instrucțiunile DDL pentru crearea tabelelor, secvențelor și constrângerilor.
*   `Script_pentru_popularea_bazei_de_date.txt`: Conține instrucțiuni DML pentru inserarea datelor inițiale în tabele.
*   `Script_pentru_stergerea_tabelor.txt`: Script pentru eliminarea tabelelor și secvențelor (util pentru curățare/resetare).
*   `Testare_Use-Case1.txt`: Script PL/SQL pentru testarea scenariului de alocare a unei curse unui șofer cu un vehicul.
*   `Testare_Use-Case2.txt`: Script PL/SQL pentru testarea scenariului de atribuire a salariului șoferilor care au îndeplinit un număr minim de curse.
*   `Testare_Use-Case3.txt`: Script PL/SQL pentru testarea scenariului de marcare a unui șofer ca indisponibil dacă vehiculul său este în mentenanță.
*   `Script_de_testare_a_constrangerilor.txt`: Conține instrucțiuni DML pentru a testa diversele constrângeri definite pe tabele (PK, FK, UNIQUE, CHECK).
*   `/Documentatie_Proiect/` (sugestie director): Aici poți plasa fișierele PDF sau imaginile din documentația originală.

## Use-Case-uri Implementate (PL/SQL)

1.  **Alocarea unei curse (`Testare_Use-Case1.txt`):**
    *   Verifică disponibilitatea șoferului.
    *   Verifică dacă vehiculul este în mentenanță în ziua curentă.
    *   Verifică dacă locația vehiculului corespunde cu punctul de plecare al rutei.
    *   Dacă toate condițiile sunt îndeplinite, actualizează statusul șoferului, locația vehiculului, adaugă o intrare temporară în `Maintenance` pentru cursă și incrementează numărul de acțiuni al șoferului. Ulterior, eliberează șoferul și șterge intrarea de mentenanță specifică cursei.

2.  **Atribuirea salariului lunar (`Testare_Use-Case2.txt`):**
    *   Selectează șoferii care au efectuat un număr minim de 3 curse (`actions >= 3`).
    *   Verifică dacă a trecut cel puțin o lună de la ultima plată (sau dacă este prima plată).
    *   Inserează o nouă plată în tabelul `Payments` pentru șoferii eligibili.

3.  **Marcarea șoferului ca indisponibil (`Testare_Use-Case3.txt`):**
    *   Verifică dacă există o programare de mentenanță pentru un vehicul în ziua curentă.
    *   Dacă da, identifică șoferul asociat vehiculului.
    *   Actualizează statusul șoferului respectiv la "indisponibil" (1).

## Testarea Constrângerilor

Fișierul `Script_de_testare_a_constrangerilor.txt` conține o serie de instrucțiuni `INSERT` concepute pentru a testa integritatea referențială și unicitatea impuse de constrângerile:
*   Primary Key (pe toate tabelele)
*   Unique (VIN pentru vehicule, număr licență pentru șoferi, route_id pentru departamente)
*   Foreign Key (între tabelele relaționate)
*   Check (distanța rutei > 0)

Scriptul include atât inserări valide, cât și inserări care ar trebui să eșueze pentru a demonstra funcționarea corectă a constrângerilor.

## Instalare și Rulare

1.  **Mediu:** Asigură-te că ai acces la un mediu Oracle Database (ex: Oracle XE, Oracle Cloud Free Tier, sau o instanță existentă).
2.  **Crearea Structurii:** Execută conținutul fișierului `Script_pentru_crearea_tabelor.txt` pentru a crea toate tabelele, secvențele și constrângerile.
3.  **Popularea Datelor:** Execută conținutul fișierului `Script_pentru_popularea_bazei_de_date.txt` pentru a încărca datele inițiale.
4.  **Testarea Constrângerilor (Opțional):** Execută secțiuni din `Script_de_testare_a_constrangerilor.txt` pentru a verifica funcționarea constrângerilor.
5.  **Rularea Use-Case-urilor:** Execută scripturile PL/SQL din fișierele `Testare_Use-CaseX.txt` pentru a observa funcționalitatea implementată. Poate fi necesar `SET SERVEROUTPUT ON;` în clientul SQL pentru a vedea mesajele DBMS_OUTPUT.
6.  **Curățare (Opțional):** Execută `Script_pentru_stergerea_tabelor.txt` pentru a elimina toate obiectele create de proiect.

---
