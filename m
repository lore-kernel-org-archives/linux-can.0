From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: Testing peak_pci v6.1 / peak_usb v6 / peak_pcmcia v4.1
Date: Thu, 23 Feb 2012 16:00:31 +0100
Message-ID: <4F46548F.7050300@peak-system.com>
References: <4F44AE8F.4070505@peak-system.com> <4F4511DC.60708@hartkopp.net>
 <4F4642AA.9060103@volkswagen.de>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:41595 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755969Ab2BWPAl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 Feb 2012 10:00:41 -0500
In-Reply-To: <4F4642AA.9060103@volkswagen.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver,

Le 23/02/2012 14:44, Oliver Hartkopp a =E9crit :
> Hello Stephane,
>
> you can add to all these drivers
>
> - peak_pci v6.1 (http://marc.info/?l=3Dlinux-can&m=3D132973636320107&=
w=3D2)
> - peak_usb v6 (http://marc.info/?l=3Dlinux-can&m=3D132998590401560&w=3D=
2)
> - peak_pcmcia v4.1 (http://marc.info/?l=3Dlinux-pcmcia&m=3D1329387213=
24159&w=3D2)
>
> my
>
> Tested-by: Oliver Hartkopp<socketcan@hartkopp.net>

Thanks for all of your precious time.

> Just two nitpicks:
>
> When having traffic the LEDs from the PCIeC are flashing faster than =
the PCMCIA LEDs.
> With no traffic and interface is up, they are flashing with the same =
frequency.

=2E.. I should check whether the two boards use the same chip to contro=
l=20
the LEDs... But I think that the word "nitpicks" was especially invente=
d=20
for that particular issue ;-)

> The other one:
>
> usb 2-2: new high-speed USB device number 4 using ehci_hcd
> usb 2-2: config 1 interface 0 altsetting 0 bulk endpoint 0x83 has inv=
alid maxpacket 64
> usb 2-2: config 1 interface 1 altsetting 0 bulk endpoint 0x86 has inv=
alid maxpacket 64
> peak_usb 2-2:1.0: PEAK-System PCAN-USB Pro hwrev 0 serial FFFFFFFF.00=
000001 (2 channels)
> peak_usb 2-2:1.0: can4: attached to PCAN-USB Pro channel 0 (device 1)
> peak_usb 2-2:1.0: can5: attached to PCAN-USB Pro channel 1 (device 0)
> usbcore: registered new interface driver peak_usb
>
> Do you have any idea what
>
> "altsetting 0 bulk endpoint 0x83 has invalid maxpacket 64"
>
> means?
>
> Is this something that's caused by your driver or it is caused by the
> hardware configuration of the USBpro adapter? I assume it's the latte=
r.

Yes you're right. These msgs are printed by the usb-core, before the=20
_probe() function of the driver is called. It is something I will send=20
back to our hw team...

> Regards,
> Oliver
>


Best regards,

St=E9phane

--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
