dosbatchscripts
===============

Various DOS batch scripts

README.md	- This file

gam-out-of-office.bat	- a batch file to use gam set out of office based on input file (OutofOfficeSettings.csv)
OutofOfficeSettings.csv	- settings used in gam-out-of-office.bat

gam-2.55-domain.bat -	batch file for switching between multiple domains in GAM 2.55

gam-3-domain.bat -	batch file for switching between multiple domains in GAM 3 using script.awk to determine domain name
in oauth2.txt file
script.awk - file for determining domain name in gam-3-domain.bat using awk.

gam3.01domain.bat - batch file as per gam-3 above but including support for the provision of a service account and 
checking that the required files exist when fist establishing the domain access.
