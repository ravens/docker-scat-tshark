# docker-scat-tshark
A self contained GSMTAP logger using [Scat](https://github.com/fgsect/scat) with wireshark. 

This project is useful to collect quickly in a command line/ headless environment the diagnostic logs from a Android phone (like the nexus5x) through its USB port.

This is an alternative to my (quick and dirty) [diag-logger](https://github.com/ravens/diag-logger/) that was using hardcoded initialization sentences for the DIAG mode and pycrate as a LTE parser. In this project I use wireshark parsers using the GSMTAP output of scat. wireshark has a JSON output that can be piped to something else for building a larger concept from this.

There might be some problems at the initialization of the diag mode, right now I added a poor patch to ignore the exception raised by the USB writes timeouts and to continue with the initialization process. In my environement (nexus5x) this is working better between two following execution of scat, but YMMV.

## build

```
docker-compose build
```

## run 

Adjust the USB device to use in docker-compose.yml (refer to [Scat](https://github.com/fgsect/scat) comments on the matter), but basically you need to hunt down the raw usb interface to use, and then run :

```
docker-compose up
```

The output should look like : 
```
tshark    |   115 10:55:21.507904560 192.168.32.3 → 192.168.32.2 GSMTAP/NAS-EPS 83 Attach complete, Activate default EPS bearer context accept
tshark    |   116 10:55:21.508129064 192.168.32.3 → 192.168.32.2 GSMTAP/NAS-EPS 83 Attach complete, Activate default EPS bearer context accept
tshark    |   117 10:55:21.508379068 192.168.32.3 → 192.168.32.2 LTE RRC UL_DCCH/NAS-EPS 86 ULInformationTransfer, Attach complete, Activate default EPS bearer context accept
tshark    |   118 10:55:21.704221321 192.168.32.3 → 192.168.32.2 LTE RRC DL_DCCH/NAS-EPS 116 DLInformationTransfer, EMM information
tshark    |   119 10:55:21.705682790 192.168.32.3 → 192.168.32.2 GSMTAP/NAS-EPS 113 EMM information
tshark    |   120 10:55:21.706009275 192.168.32.3 → 192.168.32.2 GSMTAP/NAS-EPS 107 EMM information
tshark    |   175 10:55:22.573473212 192.168.32.3 → 192.168.32.2 LTE RRC UL_DCCH 74 MeasurementReport
tshark    |   190 10:55:22.825286218 192.168.32.3 → 192.168.32.2 LTE RRC DL_SCH 88 SystemInformationBlockType1
tshark    |   191 10:55:23.016169564 192.168.32.3 → 192.168.32.2 LTE RRC BCCH_BCH 73 MasterInformationBlock (SFN=0)
tshark    |   192 10:55:23.016547734 192.168.32.3 → 192.168.32.2 LTE RRC BCCH_BCH 73 MasterInformationBlock (SFN=128)
```
