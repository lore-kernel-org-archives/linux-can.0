From: =?iso-8859-1?Q?=22Bernd_Krumb=F6ck=22?= <krumboeck@universalnet.at>
Subject: Re: [PATCH v9] usb_8dev: Add support for USB2CAN interface from 8  
 devices
Date: Fri, 18 Jan 2013 15:31:48 +0100
Message-ID: <a510e42c40b7b068b63bdefd7d7fb290.squirrel@webmail.universalnet.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp.xy24.at ([85.126.109.136]:36011 "EHLO renate.xy24.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753657Ab3AROcD (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 18 Jan 2013 09:32:03 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, linux-usb@vger.kernel.org, info@gerhard-bertelsmann.de, gediminas@8devices.com

> On 16.01.2013 09:07, "Bernd Krumb=F6ck" wrote:
>
>> Hi Oliver!
>>
>>> When detaching the device from the CAN bus when sending/receiving C=
AN
traffic
>>> i got these dmesg infos:
>>>
>>> [  960.047130] usb_8dev 2-1.4:1.0 can2: Unknown status/error messag=
e (0)
>>> [  976.544343] usb_8dev 2-1.4:1.0 can2: Unknown status/error messag=
e (0)
>>>
>>
>> Sorry, I can't do this sort of tests myself, because my second can d=
evice
>> is an expensive device, without developer/test mode. ;-)
>>
>> Gerd helped me with the can tests so far. (Thank you!)
>>
>> The messages you see mean "Normal condition" and shouldn't be
displayed. I'll fix them in the next version.
>>
>
>
> Here some more dmesg outputs:
>
> [  308.198354] ems_pcmcia 0.0 can0: setting BTR0=3D0x00 BTR1=3D0x14
> [  315.208555] can: raw protocol (rev 20120528)
> [  328.579107] usb 2-1.2: new full-speed USB device number 6 using eh=
ci-pci
> [  328.673540] usb 2-1.2: New USB device found, idVendor=3D0483,
> idProduct=3D1234
> [  328.673548] usb 2-1.2: New USB device strings: Mfr=3D1, Product=3D=
2,
SerialNumber=3D3
> [  328.673553] usb 2-1.2: Product: USB2CAN converter
> [  328.673557] usb 2-1.2: Manufacturer: edevices
> [  328.673561] usb 2-1.2: SerialNumber: ED000212
> [  328.708127] usb_8dev 2-1.2:1.0 can2: firmware: 1.4, hardware: 255.=
255
[  328.708209] usbcore: registered new interface driver usb_8dev [=20
432.319047] usb_8dev 2-1.2:1.0 can2: Unknown status/error message (0) [=
=20
439.522380] usb_8dev 2-1.2:1.0 can2: Unknown status/error message (0) [=
=20
449.324727] usb_8dev 2-1.2:1.0 can2: Unknown status/error message (0) [=
=20
574.442663] usb_8dev 2-1.2:1.0 can2: Unknown status/error message (0) [=
=20
639.810998] usb_8dev 2-1.2:1.0 can2: Unknown status/error message (39)
<------------- CAN plug out / plug in ?
>
> I correctly get an error message frame which is displayed by candump
can2,0~0,#FFFFFFFF -e
> Very nice.
>
> But i think there's no additional kernel message needed for that.

It's a bug. Will be fixed in the next version.

>
> [  640.066949] usb_8dev 2-1.2:1.0 can2: Unknown status/error message =
(0)
[  643.669320] usb_8dev 2-1.2:1.0 can2: Unknown status/error message (0=
)
[  645.703327] usb_8dev 2-1.2:1.0 can2: Unknown status/error message (0=
)
[  659.652396] usb_8dev 2-1.2:1.0 can2: Unknown status/error message (0=
)
[  667.130633] usb_8dev 2-1.2:1.0 can2: Unknown status/error message (0=
)
[  682.904587] usb_8dev 2-1.2:1.0 can2: Unknown status/error message
(39) <------------- CAN plug out / plug in ?
> [  683.115139] usb_8dev 2-1.2:1.0 can2: Unknown status/error message =
(0)
[  692.402507] usb_8dev 2-1.2:1.0 can2: Unknown status/error message (0=
)
[  754.103247] usb_8dev 2-1.2:1.0 can2: Unknown status/error message (0=
)
[  813.887344] usb 2-1.4: new full-speed USB device number 7 using
ehci-pci <------------- USB plug in of PEAK adapter
> [  813.985254] usb 2-1.4: New USB device found, idVendor=3D0c72,
> idProduct=3D000c
> [  813.985258] usb 2-1.4: New USB device strings: Mfr=3D0, Product=3D=
3,
SerialNumber=3D0
> [  813.985261] usb 2-1.4: Product: VER1:PEAK
> [  813.985261] VER2:02.8.01
> [  813.985261] DAT :06.05.2004
> [  813.985261] TIME:09:35:37
> [  813.985261]                              ...
> [  814.007847] peak_usb 2-1.4:1.0: PEAK-System PCAN-USB adapter hwrev=
 28
serial FFFFFFFF (1 channel)
> [  814.008347] peak_usb 2-1.4:1.0 can3: attached to PCAN-USB channel =
0
(device 37)
> [  814.008400] usbcore: registered new interface driver peak_usb [=20
836.196103] peak_usb 2-1.4:1.0 can3: setting BTR0=3D0x00 BTR1=3D0x14 [=20
858.676730] usb_8dev 2-1.2:1.0 can2: couldn't find free context
<------------- some 100% load tests
> [  900.211646] usb_8dev 2-1.2:1.0 can2: Unknown status/error message =
(0)
[ 1007.075674] usb_8dev 2-1.2:1.0 can2: Unknown status/error message (0=
)
[ 1007.083660] usb_8dev 2-1.2:1.0 can2: Unknown status/error message (0=
)
[ 1012.947678] usb_8dev 2-1.2:1.0 can2: Unknown status/error message (0=
)
[ 1012.947684] usb_8dev 2-1.2:1.0 can2: Unknown status/error message (0=
)
[ 3542.360315] usb_8dev 2-1.2:1.0 can2: couldn't find free context [
3775.350727] usb_8dev 2-1.2:1.0 can2: Unknown status/error message (0) =
[
4019.272711] usb_8dev 2-1.2:1.0 can2: Unknown status/error message (0) =
[
4019.276510] usb_8dev 2-1.2:1.0 can2: Unknown status/error message (0) =
[
4034.787824] usb_8dev 2-1.2:1.0 can2: Unknown status/error message (0) =
[
4036.305381] usb_8dev 2-1.2:1.0 can2: Unknown status/error message (0) =
[
4043.180064] usb_8dev 2-1.2:1.0 can2: Unknown status/error message (39)
<------------- CAN plug out / plug in ?
> [ 4063.727159] usb_8dev 2-1.2:1.0 can2: Unknown status/error message =
(0)
[ 4063.730771] usb_8dev 2-1.2:1.0 can2: Unknown status/error message (0=
)
[ 4084.564526] usb_8dev 2-1.2:1.0 can2: Unknown status/error message (0=
)
[ 4084.566509] usb_8dev 2-1.2:1.0 can2: Unknown status/error message (0=
)
[ 4090.721503] usb_8dev 2-1.2:1.0 can2: Unknown status/error message (0=
)
[ 4090.730468] usb_8dev 2-1.2:1.0 can2: Unknown status/error message (0=
)
[ 4135.224318] usb_8dev 2-1.2:1.0 can2: Rx URB aborted (-32)
> <------------- USB plug out
> [ 4135.224560] usb_8dev 2-1.2:1.0 can2: Rx URB aborted (-32)
> [ 4135.224780] usb_8dev 2-1.2:1.0 can2: Rx URB aborted (-32)
> [ 4135.225035] usb_8dev 2-1.2:1.0 can2: Rx URB aborted (-32)
> [ 4135.225281] usb_8dev 2-1.2:1.0 can2: Rx URB aborted (-32)
> [ 4135.225530] usb_8dev 2-1.2:1.0 can2: Rx URB aborted (-32)
>
> (..)
>
> [ 4135.449143] usb_8dev 2-1.2:1.0 can2: Rx URB aborted (-32)
> [ 4135.449163] usb 2-1.2: USB disconnect, device number 6
> [ 4135.449406] usb_8dev 2-1.2:1.0 can2: Rx URB aborted (-32)
> [ 4135.450149] usb_8dev 2-1.2:1.0 can2: device disconnected
> [ 4135.450223] usb_8dev 2-1.2:1.0 can2: sending command message faile=
d [
4135.450226] usb_8dev 2-1.2:1.0 can2: couldn't stop device
> [ 4509.018148] usb 2-1.2: new full-speed USB device number 8 using
ehci-pci <------------- USB plug in
> [ 4509.090027] usb 2-1.2: device descriptor read/64, error -32
> [ 4509.265758] usb 2-1.2: device descriptor read/64, error -32
> [ 4509.441420] usb 2-1.2: new full-speed USB device number 9 using eh=
ci-pci
> [ 4509.535892] usb 2-1.2: New USB device found, idVendor=3D0483,
> idProduct=3D1234
> [ 4509.535900] usb 2-1.2: New USB device strings: Mfr=3D1, Product=3D=
2,
SerialNumber=3D3
> [ 4509.535905] usb 2-1.2: Product: USB2CAN converter
> [ 4509.535909] usb 2-1.2: Manufacturer: edevices
> [ 4509.535913] usb 2-1.2: SerialNumber: ED000212
> [ 4509.538736] usb_8dev 2-1.2:1.0 can2: firmware: 1.4, hardware: 255.=
255
[ 5043.232674] usb_8dev 2-1.2:1.0 can2: Rx URB aborted (-32)
> <------------- USB plug out
> [ 5043.232920] usb_8dev 2-1.2:1.0 can2: Rx URB aborted (-32)
> [ 5043.233168] usb_8dev 2-1.2:1.0 can2: Rx URB aborted (-32)
> [ 5043.233422] usb_8dev 2-1.2:1.0 can2: Rx URB aborted (-32)
> [ 5043.233672] usb_8dev 2-1.2:1.0 can2: Rx URB aborted (-32)
>
> (..)
>
> [ 5043.450557] usb_8dev 2-1.2:1.0 can2: Rx URB aborted (-32)
> [ 5043.450820] usb_8dev 2-1.2:1.0 can2: Rx URB aborted (-32)
> [ 5043.451067] usb_8dev 2-1.2:1.0 can2: Rx URB aborted (-32)
> [ 5043.451331] usb_8dev 2-1.2:1.0 can2: Rx URB aborted (-32)
> [ 5043.451562] usb_8dev 2-1.2:1.0 can2: Rx URB aborted (-32)
> [ 5043.451958] usb_8dev 2-1.2:1.0 can2: Rx URB aborted (-32)
> [ 5043.452068] usb 2-1.2: USB disconnect, device number 9 <----------=
---
ha ha ha - correct but pretty late %-]
> [ 5043.452166] usb_8dev 2-1.2:1.0 can2: Rx URB aborted (-32)
> [ 5043.452368] usb_8dev 2-1.2:1.0 can2: device disconnected
> [ 5043.452388] usb_8dev 2-1.2:1.0 can2: sending command message faile=
d [
5043.452391] usb_8dev 2-1.2:1.0 can2: couldn't stop device
> [ 5045.693712] usb 2-1.2: new full-speed USB device number 10 using
ehci-pci <------------- USB plug in - fast reconnect
> [ 5045.765625] usb 2-1.2: device descriptor read/64, error -32
> [ 5045.941158] usb 2-1.2: device descriptor read/64, error -32
> [ 5046.116888] usb 2-1.2: new full-speed USB device number 11 using
ehci-pci
> [ 5046.211472] usb 2-1.2: New USB device found, idVendor=3D0483,
> idProduct=3D1234
> [ 5046.211480] usb 2-1.2: New USB device strings: Mfr=3D1, Product=3D=
2,
SerialNumber=3D3
> [ 5046.211485] usb 2-1.2: Product: USB2CAN converter
> [ 5046.211489] usb 2-1.2: Manufacturer: edevices
> [ 5046.211493] usb 2-1.2: SerialNumber: ED000212
> [ 5046.214561] usb_8dev 2-1.2:1.0 can2: firmware: 1.4, hardware: 255.=
255
[ 5079.471265] usb_8dev 2-1.2:1.0 can2: Unknown status/error message (0=
)
[ 5094.652853] usb_8dev 2-1.2:1.0 can2: Unknown status/error message (0=
)
[ 5188.280220] usb_8dev 2-1.2:1.0 can2: couldn't find free context
<------------- some 100% load tests
> [ 5349.301144] usb_8dev 2-1.2:1.0 can2: couldn't find free context [
5508.561402] usb_8dev 2-1.2:1.0 can2: couldn't find free context [
5755.661129] usb_8dev 2-1.2:1.0 can2: couldn't find free context [
5786.781054] usb_8dev 2-1.2:1.0 can2: couldn't find free context
<------------- (..)
> [ 5822.180928] usb_8dev 2-1.2:1.0 can2: couldn't find free context [
5827.850885] usb_8dev 2-1.2:1.0 can2: couldn't find free context [
5891.685618] usb_8dev 2-1.2:1.0 can2: couldn't find free context [
5930.230438] usb_8dev 2-1.2:1.0 can2: couldn't find free context
<------------- some 100% load tests
> [ 5941.577933] peak_usb 2-1.4:1.0 can3: Rx urb aborted (-32)
> [ 5941.743693] usb 2-1.2: USB disconnect, device number 11
> [ 5941.744096] usb_8dev 2-1.2:1.0 can2: device disconnected
> [ 5941.744121] usb_8dev 2-1.2:1.0 can2: sending command message faile=
d [
5941.744124] usb_8dev 2-1.2:1.0 can2: couldn't stop device

How did you do this test?

>
> Finally disconnecting the USB and the CAN bus - even under moderate C=
AN
traffic conditions genereates this output.
>
> FYI: My laptop never crashed during these tests :-)

I will try a newer kernel next time.

> I forgot to check the other USB CAN adapters for comparison.
> Will do tomorrow.
>
> Regards,
> Oliver
>



