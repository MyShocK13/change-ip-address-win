@echo off

:: Set default values for IP address, subnet mask, default gateway, and DNS servers
set ipaddress=192.168.0.65
set subnetmask=255.255.255.0
set gateway=192.168.0.1
set dnsserver=8.8.8.8

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

:: Prompt the user to enter a new IP address, if desired
set /p newip=Enter the new IP address [%ipaddress%]: 
if not "%newip%" == "" set ipaddress=%newip%

:: Prompt the user to enter a new subnet mask, if desired
set /p newsubnet=Enter the subnet mask [%subnetmask%]: 
if not "%newsubnet%" == "" set subnetmask=%newsubnet%

:: Prompt the user to enter a new default gateway, if desired
set /p newgateway=Enter the default gateway [%gateway%]: 
if not "%newgateway%" == "" set gateway=%newgateway%

:: Prompt the user to enter one or more DNS server addresses, separated by commas
set /p newdns=Enter DNS server addresses [%dnsserver%]: 
if not "%newdns%" == "" set dnsservers=%newdns%

:: Use netsh to configure the network interface with the new settings, including DNS servers
netsh interface ipv4 set address name="%interface%" static %ipaddress% %subnetmask% %gateway% 1
netsh interface ipv4 set dns name="%interface%" static %dnsserver% validate=no

echo Static configuration applied.

timeout /t 5 > nul

:: Display the modified IP configuration for the selected interface
netsh interface ipv4 show config %interface%

pause