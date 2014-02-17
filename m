From: Matthias Fuchs <matthias.fuchs@esd.eu>
Subject: Re: Can't start ESD CAN-USB/2
Date: Mon, 17 Feb 2014 14:14:34 +0100
Message-ID: <53020B3A.1090906@esd.eu>
References: <52EBCACD.9080906@iit.it> <52EBCBFA.2090205@pengutronix.de> <52EBD794.3020503@iit.it> <52EBDCD2.6000301@pengutronix.de>,<52EBDD1D.4060503@pengutronix.de> <B83FB8757830C3428B64299F968D0F68034C56FE@IITMXWGE012.iit.local> <52EBE0D4.2060907@pengutronix.de> <52EBE25E.40707@iit.it> <52EBE3EA.6030706@pengutronix.de> <52EBF7C5.9050309@iit.it> <52ECE6BB.7000602@pengutronix.de> <52ECEE3D.4000701@iit.it> <52ED0438.2060100@pengutronix.de> <5301FF2B.4020701@iit.it> <5301FF62.4090800@iit.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mxu02.htp-tel.de ([81.14.242.9]:59095 "EHLO mxuout02.htp-tel.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752348AbaBQNea (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 17 Feb 2014 08:34:30 -0500
In-Reply-To: <5301FF62.4090800@iit.it>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Francesco Giovannini <francesco.giovannini@iit.it>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, esd - Support <support@esd.eu>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Francesco,

I forwarded this issue to our support. We will try to reproduce
the issue here with your setup (Suse 12.2) and will come back to you
later.

We will keep the list on cc as far this has to do with linux-can.

Matthias

On 02/17/2014 01:24 PM, Francesco Giovannini wrote:
>=20
> On 02/17/2014 08:29 AM, Matthias Fuchs wrote:
>> Hi Francesco,
>>
>> I just saw your posting to the linux-can list about our CAN-USB/2.
>>
>> Did you solve your problems?
>>
>> Matthias
>>
>=20
> On 02/01/2014 03:27 PM, Marc Kleine-Budde wrote:
>>>>> Any chance you might have a last minute inspiration? ;)
>>>> Can you make a firmware update of the USB adapter? Does the adapte=
r work
>>>> under windows?
>>> So yesterday I tried the same esd device on my Debian machine runni=
ng
>>> Wheezy and kernel 3.2.0 (so an older kernel than the OpenSuse one) =
and
>>> everything worked fine. I was able to set the bitrate and dump data=
 from
>>> the device. And yes the device works flawlessly under windows.
>> Okay, the device is working. Even under Linux :)
>>
>>> With Suse I also tried switching esd devices and cables without any=
 luck.
>> But the Suse is a different machine, so different USB
>> controller/hardware and different USB driver.
>>
>>> Do you think this behaviour might be due caused by problems on the
>>> driver side or on the canutils side? As in: should I raise this iss=
ue
>>> with the ESD driver developers?
>> It's not the canutils, they just send the parameters into the kernel=
=2E
>> The kernel driver hasn't changed much. Feel free to contact the driv=
er
>> developer Matthias Fuchs<matthias.fuchs@esd.eu>, keep the mailinglis=
t
>> on Cc, if possible.
>>
>> regards,
>> Marc
>>
>=20
> Hi Matthias,
>=20
> I was told to keep the linux-can mailing list in the loop.
>=20
> I did not solve the problem. I believe it might be due to a USB=20
> controller problem as Marc suggested. For information sake here are t=
he=20
> output of dmesg, lsusb and lspci as I plug in the device:
>=20
>     oSuseBox-IIT:/home/fgiovannini # dmesg | tail
>     [ 1126.850018] usb 1-10: new high-speed USB device number 8 using
>     ehci_hcd
>     [ 1126.965630] usb 1-10: New USB device found, idVendor=3D0ab4,
>     idProduct=3D0010
>     [ 1126.965634] usb 1-10: New USB device strings: Mfr=3D1, Product=
=3D2,
>     SerialNumber=3D3
>     [ 1126.965637] usb 1-10: Product: USB2292
>     [ 1126.965640] usb 1-10: Manufacturer: esd electronic system desi=
gn
>     gmbh (www.esd-electronics.com)
>     [ 1126.965642] usb 1-10: SerialNumber: GM001950
>     [ 1126.968027] esd_usb2 1-10:1.0: can0: device can0 registered
>=20
>=20
>     oSuseBox-IIT:/home/fgiovannini # lsusb
>     Bus 002 Device 002: ID 413c:3016 Dell Computer Corp. Optical
>     5-Button Wheel Mouse
>     Bus 001 Device 008: ID 0ab4:0010
>     Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>     Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
>=20
>=20
>     oSuseBox-IIT:/home/fgiovannini # lspci
>     00:00.0 Host bridge: NVIDIA Corporation MCP73 Host Bridge (rev a2=
)
>     00:00.1 RAM memory: NVIDIA Corporation nForce 630i memory control=
ler
>     (rev a2)
>     00:01.0 RAM memory: NVIDIA Corporation nForce 630i memory control=
ler
>     (rev a1)
>     00:01.1 RAM memory: NVIDIA Corporation nForce 630i memory control=
ler
>     (rev a1)
>     00:01.2 RAM memory: NVIDIA Corporation nForce 630i memory control=
ler
>     (rev a1)
>     00:01.3 RAM memory: NVIDIA Corporation nForce 630i memory control=
ler
>     (rev a1)
>     00:01.4 RAM memory: NVIDIA Corporation nForce 630i memory control=
ler
>     (rev a1)
>     00:01.5 RAM memory: NVIDIA Corporation nForce 630i memory control=
ler
>     (rev a1)
>     00:01.6 RAM memory: NVIDIA Corporation nForce 630i memory control=
ler
>     (rev a1)
>     00:02.0 RAM memory: NVIDIA Corporation nForce 630i memory control=
ler
>     (rev a1)
>     00:03.0 ISA bridge: NVIDIA Corporation MCP73 LPC Bridge (rev a2)
>     00:03.1 SMBus: NVIDIA Corporation MCP73 SMBus (rev a1)
>     00:03.2 RAM memory: NVIDIA Corporation MCP73 Memory Controller (r=
ev a1)
>     00:03.3 Co-processor: NVIDIA Corporation MCP73 Co-processor (rev =
a2)
>     00:03.4 RAM memory: NVIDIA Corporation MCP73 Memory Controller (r=
ev a1)
>     00:04.0 USB controller: NVIDIA Corporation GeForce 7100/nForce 63=
0i
>     USB (rev a1)
>     00:04.1 USB controller: NVIDIA Corporation MCP73 [nForce 630i] US=
B
>     2.0 Controller (EHCI) (rev a1)
>     00:08.0 IDE interface: NVIDIA Corporation MCP73 IDE (rev a1)
>     00:09.0 Audio device: NVIDIA Corporation MCP73 High Definition Au=
dio
>     (rev a1)
>     00:0a.0 PCI bridge: NVIDIA Corporation MCP73 PCI Express bridge (=
rev a1)
>     00:0b.0 PCI bridge: NVIDIA Corporation MCP73 PCI Express bridge (=
rev a1)
>     00:0c.0 PCI bridge: NVIDIA Corporation MCP73 PCI Express bridge (=
rev a1)
>     00:0d.0 PCI bridge: NVIDIA Corporation MCP73 PCI Express bridge (=
rev a1)
>     00:0e.0 SATA controller: NVIDIA Corporation GeForce 7100/nForce 6=
30i
>     SATA (rev a2)
>     00:0f.0 Ethernet controller: NVIDIA Corporation MCP73 Ethernet (r=
ev a2)
>     02:00.0 VGA compatible controller: Advanced Micro Devices [AMD] n=
ee
>     ATI RV710 [Radeon HD 4350]
>     02:00.1 Audio device: Advanced Micro Devices [AMD] nee ATI RV710/=
730
>     HDMI Audio [Radeon HD 4000 series]
>=20
>=20
> Francesco
>=20


--=20
-----------------------------------------------------------------------=
-
Dipl.-Ing. Matthias Fuchs
Head of System Design

esd electronic system design gmbh
Vahrenwalder Str. 207 - 30165 Hannover - GERMANY
Phone: +49-511-37298-0 - Fax: +49-511-37298-68
Please visit our homepage http://www.esd.eu
Quality Products - Made in Germany
-----------------------------------------------------------------------=
--
Gesch=C3=A4ftsf=C3=BChrer: Klaus Detering
Amtsgericht Hannover HRB 51373 - VAT-ID DE 115672832
-----------------------------------------------------------------------=
--
