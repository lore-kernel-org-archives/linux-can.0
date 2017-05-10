From: Patrick Menschel <menschel.p@posteo.de>
Subject: Re: J1939 kernel for Raspberry Pi
Date: Wed, 10 May 2017 17:03:25 +0200
Message-ID: <aa1bd3ba-96e7-e155-958f-1581d3bca008@posteo.de>
References: <CAGJdXcFRUB=xLSdFkwadTkdd=OAvgkGgrOYRAxy0RkjpHGoCDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms000002020309000704040403"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.66]:46783 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751829AbdEJPD0 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 10 May 2017 11:03:26 -0400
Received: from submission (posteo.de [89.146.220.130])
        by mout02.posteo.de (Postfix) with ESMTPS id 0CEBE20B3C
        for <linux-can@vger.kernel.org>; Wed, 10 May 2017 17:03:24 +0200 (CEST)
In-Reply-To: <CAGJdXcFRUB=xLSdFkwadTkdd=OAvgkGgrOYRAxy0RkjpHGoCDQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Paul Bongaerts <pauluzs@gmail.com>
Cc: linux-can <linux-can@vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms000002020309000704040403
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Hello Paul,

just for the record, socketcan itself works on your pi, yes?

Further question would be if the file can-j1939.ko really is in the
modules folder.

If yes, my first try would be "depmod -A" . See if the module is found th=
en.

Regards,

Patrick


Am 10.05.2017 um 13:50 schrieb Paul Bongaerts:
> After struggling for the last 5 days i keep failing in building a
> working custom  jessie lite based j1939 arm kernel. for a raspberrypi
> (b.t.w. i'm certainly no expert on kernel building)
>
> Tried  local and  crosscompiled builds with different setting
>
> Goal is to build a kernel according to the Raspberrypi kernel building =
guide
> https://www.raspberrypi.org/documentation/linux/kernel/building.md
>
> And merge this with a J1939 kernel according to this elinux j1939 guide=
=2E
> http://elinux.org/J1939
>
> Because this takes several hours per build and over a day on the pi i
> could use some help in the right direction
>
>
>
> Br, Paul
>
>
>
>
> Failed attempts summary :
>
> Compile a working kernel with no j1939 support on rpi locally
> (modprobe can-j1939 Fails)
> Crosscompile unbootable kernels with j1939 support on ubuntu (Fails to =
boot)
>
>
> #######################################################################=
##
> Native compile
> rapsberry pi zero w    16 GB SD Card
> #######################################################################=
##
>
>
> Setup the build environment
>
> sudo apt-get install git bc
> git clone --depth=3D1 https://github.com/raspberrypi/linux
> cd linux
>     git remote add j1939 git://github.com/kurt-vd/linux
>     git remote update j1939 |& tee -a ~/j1939update.log
>
>
> Merge j1939-v4.7 with rpi-master takes several hours
>
>     git merge j1939/j1939d-v4.7 |& tee -a ~/j1939merge.log
>     (jessie image uses uname -r 4.9.24+  so 4.7 is closest lower versio=
n)
>
> cd ~/linux
> KERNEL=3Dkernel
> make bcmrpi_defconfig
>
> Build the kernel, modules and devicetree overlays.  time ~ 24h
>
> make zImage modules dtbs
>
> Install the modules
>
> sudo make modules_install
>
> Copy the files to the right locations
>
> sudo cp arch/arm/boot/dts/*.dtb /boot/
> sudo cp arch/arm/boot/dts/overlays/*.dtb* /boot/overlays/
> sudo cp arch/arm/boot/dts/overlays/README /boot/overlays/
> sudo cp arch/arm/boot/zImage /boot/$KERNEL.img
> sudo reboot
> sudo modprobe can-j1939
> modprobe: FATAL: Module can-j1939 not found.
>
>
> #######################################################################=
##
> Crosscompile j1939-v4.7 > rpi kernel
> ubuntu-16.04.2-server-amd64.iso
> #######################################################################=
##
>
> cd /usr/src
>
> Get crosscompile Toolchain
>
> git clone git://github.com/raspberrypi/tools.git --depth=3D1
>
> Get j1939-v4.7 branch kernel sources
>
> git clone -b j1939d-v4.7 git://github.com/kurt-vd/linux --depth=3D1
>
> cd /usr/src/linux
>
> export PATH
>
> export PATH=3D$PATH:/usr/src/tools/arm-bcm2708/gcc-linaro-arm-linux-gnu=
eabihf-raspbian-x64/bin
>
> Clean the kernel source
>
> make mrproper
>
>
>
> Now login to a running rpi (Clean raspbian-jessie-lite, uname -a r 4.9.=
24+ )
>
> Create config.gz
>
> pi@raspberrypi:~ $ sudo modprobe configs
>
> Copy the config.gz to build server
>
> pi@raspberrypi:~ $ scp /proc/config.gz user@server.local:/usr/src/linux=

>
>
>
> Back on Server
>
> gunzip -c config.gz > .config
>
> Set kernel varialble
>
> KERNEL=3Dkernel
>
>
> Build Kernel Image, Modules and Devicetreeoverlays (select: SAE J1939
> as module, debug SAE J1939 yes, CAN_IFI_CANFD as module)
>
> make ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- zImage modules dtb=
s
>
>
> copy files to SD according to raspberry's kernelbuildingguide and boot
> (fails to boot)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in=

> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--------------ms000002020309000704040403
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
CfcwggSvMIIDl6ADAgECAhEA4CPLFRKDU4mtYW56VGdrITANBgkqhkiG9w0BAQsFADBvMQsw
CQYDVQQGEwJTRTEUMBIGA1UEChMLQWRkVHJ1c3QgQUIxJjAkBgNVBAsTHUFkZFRydXN0IEV4
dGVybmFsIFRUUCBOZXR3b3JrMSIwIAYDVQQDExlBZGRUcnVzdCBFeHRlcm5hbCBDQSBSb290
MB4XDTE0MTIyMjAwMDAwMFoXDTIwMDUzMDEwNDgzOFowgZsxCzAJBgNVBAYTAkdCMRswGQYD
VQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNP
TU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBAImxDdp6UxlOcFIdvFamBia3uEngludRq/HwWhNJFaO0jBtgvHpRQqd5jKQi3xdh
TpHVdiMKFNNKAn+2HQmAbqUEPdm6uxb+oYepLkNSQxZ8rzJQyKZPWukI2M+TJZx7iOgwZOak
+FaA/SokFDMXmaxE5WmLo0YGS8Iz1OlAnwawsayTQLm1CJM6nCpToxDbPSBhPFUDjtlOdiUC
ISn6o3xxdk/u4V+B6ftUgNvDezVSt4TeIj0sMC0xf1m9UjewM2ktQ+v61qXxl3dnUYzZ7ifr
vKUHOHaMpKk4/9+M9QOsSb7K93OZOg8yq5yVOhM9DkY6V3RhUL7GQD/L5OKfoiECAwEAAaOC
ARcwggETMB8GA1UdIwQYMBaAFK29mHo0tCb3+sQmVO8DveAky1QaMB0GA1UdDgQWBBSSYWuC
4aKgqk/sZ/HCo/e0gADB7DAOBgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADAd
BgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEQYDVR0gBAowCDAGBgRVHSAAMEQGA1Ud
HwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9BZGRUcnVzdEV4dGVybmFs
Q0FSb290LmNybDA1BggrBgEFBQcBAQQpMCcwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVz
ZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQELBQADggEBABsqbqxVwTqriMXY7c1V86prYSvACRAj
mQ/FZmpvsfW0tXdeDwJhAN99Bf4Ss6SAgAD8+x1banICCkG8BbrBWNUmwurVTYT7/oKYz1gb
4yJjnFL4uwU2q31Ypd6rO2Pl2tVz7+zg+3vio//wQiOcyraNTT7kSxgDsqgt1Ni7QkuQaYUQ
26Y3NOh74AEQpZzKOsefT4g0bopl0BqKu6ncyso20fT8wmQpNa/WsadxEdIDQ7GPPprsnjJT
9HaSyoY0B7ksyuYcStiZDcGG4pCS+1pCaiMhEOllx/XVu37qjIUgAmLq0ToHLFnFmTPyOInl
tukWeh95FPZKEBom+nyK+5swggVAMIIEKKADAgECAhEAvREavCLRTrKKuEIsseliUTANBgkq
hkiG9w0BAQsFADCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
cjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/BgNV
BAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBMB4XDTE2MDYwNDAwMDAwMFoXDTE3MDYwNDIzNTk1OVowJTEjMCEGCSqGSIb3DQEJ
ARYUbWVuc2NoZWwucEBwb3N0ZW8uZGUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
AQDhF/cULHYMLK+xHh/HbwO1aY3M+56GI9uRfRLAJWEEpdSFWvW8whRizlAZ0t9eHDzzCI1l
wi7xDKBfwJt3VNxVjqHs3JjpcxSln/22AF3t8BKy3ACUtw6COlAk7bbwxr29qf7R4wFjumdS
AS4uc6vDEBqlLrpdQCICwgOne97Dvi849VmbCBTCLTDpMxgrOXkiveGmQ2wBqLEPU/9o5ZH8
jcCbenY5GZTh7u4gvigPfgIu79jE3dS6he+c64SWgcD7bI/zA9KMCkRuvLrFnN+bu8TeH9jy
FpdsFuJ4+7mjoYsalR7S/wm0M7pbcZEDw2fJp4XogbLFmpjIlJjA8QM1AgMBAAGjggHyMIIB
7jAfBgNVHSMEGDAWgBSSYWuC4aKgqk/sZ/HCo/e0gADB7DAdBgNVHQ4EFgQUsac6ykMiqHZ3
OqhHkkcxeF9NoW8wDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwIAYDVR0lBBkwFwYI
KwYBBQUHAwQGCysGAQQBsjEBAwUCMBEGCWCGSAGG+EIBAQQEAwIFIDBGBgNVHSAEPzA9MDsG
DCsGAQQBsjEBAgEBATArMCkGCCsGAQUFBwIBFh1odHRwczovL3NlY3VyZS5jb21vZG8ubmV0
L0NQUzBdBgNVHR8EVjBUMFKgUKBOhkxodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9T
SEEyNTZDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3JsMIGQBggrBgEF
BQcBAQSBgzCBgDBYBggrBgEFBQcwAoZMaHR0cDovL2NydC5jb21vZG9jYS5jb20vQ09NT0RP
U0hBMjU2Q2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAkBggrBgEF
BQcwAYYYaHR0cDovL29jc3AuY29tb2RvY2EuY29tMB8GA1UdEQQYMBaBFG1lbnNjaGVsLnBA
cG9zdGVvLmRlMA0GCSqGSIb3DQEBCwUAA4IBAQBSqnMFVFL1I7Hr3/FWhV3r0cHCSYrAAJu0
lpgUJcvf6TOGuWNTksdyxbRFWyB6uc6trI9VrQHXbUhHHaUOPyDYBT50Xv4BrgIFYpQe7JI1
IYPyE5PAR4323CeOTADK4S7KyerSRm7ZnqRCOHp6NTC/2cehFgkfCuO01AeRmzyA8arANiZf
TS2rPtd31PjpBQ0OpngLxn2qWEIf90Ibq+XxSuiXaLg4l2PI/975QLi0nn466Ql7U2nUeawn
R34LMZk1c2ImpKZUX+cpz17btGWyohXSdXLQnrruWvO2dx4F5AjuJ/F8JHbIm17I/mlzh883
4e16eovJEoiXCNVlmxZ3MYIERDCCBEACAQEwgbEwgZsxCzAJBgNVBAYTAkdCMRswGQYDVQQI
ExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9E
TyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGlj
YXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAL0RGrwi0U6yirhCLLHpYlEwDQYJYIZIAWUD
BAIBBQCgggJjMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE3
MDUxMDE1MDMyNVowLwYJKoZIhvcNAQkEMSIEIE7wygtKRd19RJTkwGt0QN6+hpT5fhhkaNOm
u+MJ6kdTMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggq
hkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZI
hvcNAwICASgwgcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgT
EkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RP
IENBIExpbWl0ZWQxQTA/BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNh
dGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAvREavCLRTrKKuEIsseliUTCBxAYLKoZIhvcN
AQkQAgsxgbSggbEwgZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0
ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYD
VQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBF
bWFpbCBDQQIRAL0RGrwi0U6yirhCLLHpYlEwDQYJKoZIhvcNAQEBBQAEggEAVDiVSXzU5Abp
kHEBiF+u2ZKvk1YKnDadp3JgL2YjbVP1m3GuDtELFeiUZNiG5WrLt8L/AvJ1ys3JOYTTaemD
RWptUFaWiFd9cgv4d2u3MXKzQG6qubuz5gxQA8D8eoTALrTR+1jbHD62UI8pOC4Wb2ZEX6D2
/aoQ+WQ2lAWDzsttrPt8Ef/zU9GizSNYA8YDprzLFrob4C4o9bmt2afKbdfGWU/O575/l1C6
QAIFbKCf8YVffA6Kgj8IO5CAXC6iW756uSU9BEd8mY3WGQ4ZkMnA4gBZbm4zajaVOejMbEMk
Nk8DJqO5OvB/4Wa7Le/UAj4NwlPwLN/XC9i6NfVklQAAAAAAAA==
--------------ms000002020309000704040403--
