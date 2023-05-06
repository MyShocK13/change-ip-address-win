@echo off

:: Display the available network interfaces
echo Available network interfaces:
echo 1 - Ethernet
echo 2 - Wi-Fi
echo 3 - Other
echo.

:: Prompt the user to select a network interface
set /p interface_choice=Enter the number of the network interface to configure: 

if %interface_choice% == 1 (
    set interface=Ethernet
) else if %interface_choice% == 2 (
    set interface=Wi-Fi
) else if %interface_choice% == 3 (
    set /p interface=Enter the name of the network interface to configure: 
)

:: Display the IP configuration for the selected interface
netsh interface ipv4 show config %interface%

:: Set the DHCP configuration
netsh interface ipv4 set address name="%interface%" dhcp
netsh interface ipv4 set dns name="%interface%" dhcp

echo DHCP configuration applied.

timeout /t 5 > nul

:: Display the modified IP configuration for the selected interface
netsh interface ipv4 show config %interface%

pause