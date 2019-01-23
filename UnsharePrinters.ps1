<#
Name: UnsharePrinters.ps1
Author: Austin Vargason
Description: Unshares print queues on the print server specified

THIS SCRIPT SHOULD BE RUN REMOTELY VIA WINRM.

Date Modified: 1/23/19
#>

#function to unshare a single printer
function Set-UnsharedPrinter {

    # we take in the printer name as the parameter
    param (
        [Parameter(Mandatory=$true)]
        [String]$PrinterName
    )
    
    try {

        #get the printer and store the object in a variable
        $printer = Get-Printer -Name $PrinterName

        #set the printer property to unshared and then apply
    }
    catch {
        Write-Host "An error occured making the property change for printer: $PrinterName"
    }
}

#get the list of printers to unshare
$printerList = Get-Content -Path .\printerList.txt


#set a counter for the progress bar
$i = 0
$count = $printerList.Count

#loop through the list and unshare the printers
foreach ($printer in $printerList) {

    #set the printer to be not shared anymore
    Set-UnsharedPrinter -PrinterName $printer

    #write to the progress bar
    Write-Progress -Activity "Unsharing Printers" -Status "Unshared Printer: $printer" -PercentComplete (($i / $count) * 100)

}
