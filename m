From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 0/3 v5] can/usb: Add PEAK-System PCAN USB adapters driver
Date: Wed, 22 Feb 2012 17:01:37 +0100
Message-ID: <4F451161.3020803@hartkopp.net>
References: <1329481458-2586-1-git-send-email-s.grosjean@peak-system.com> <4F44939D.9050703@hartkopp.net> <4F44998B.3040302@hartkopp.net> <4F450777.3010301@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:46035 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042Ab2BVQBv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 22 Feb 2012 11:01:51 -0500
In-Reply-To: <4F450777.3010301@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

On 22.02.2012 16:19, Stephane Grosjean wrote:

> Le 22/02/2012 08:30, Oliver Hartkopp a =E9crit :
>> On 22.02.2012 08:05, Oliver Hartkopp wrote:
>>
>>
>> Just printing this status and continue with business as usual
>> (netif_wake_queue!) is probably not the right approach 8-)
>>
>> Please check if it makes sense to check (urb->status !=3D 0) earlier=
 in this
>> callback function.
>>
>=20
> Hi Oliver,
>=20
> I took time to have a look to how things are done in other (net+usb) =
drivers
> and it's not easy to conclude to anything: some are testing that stat=
us (but
> with some other errno values) while others are always waking up the n=
etdev
> queues... So, I tried to do a "mixed-of", cleaned up the code and tes=
ted it in
> (something like) your conditions, that is:
>=20
> PC1:
> can0 -> usb-pro ch1 -+
> can1 -> usb-pro ch2  |
> can2 -> usb ---------+
>                      | 1Mpbs
> PC2:                 |
> can0 -> pcmcia ch1 --+
>=20
> PC1:
> cangen -g0 -i can0
> cangen -g0 -i can2
> candump any
>=20
> I did the two following tests:
>=20
> - removing the peak_usb driver while sending/reading data:
>=20
> [ 4354.534576] peak_usb 1-1:1.0: can0: attached to PCAN-USB Pro chann=
el 0
> (device 1898240)
> [ 4354.535574] peak_usb 1-1:1.0: can1: attached to PCAN-USB Pro chann=
el 1
> (device 2)
> [ 4360.388020] usb 4-1: new full speed USB device number 7 using uhci=
_hcd
> [ 4360.588035] peak_usb 4-1:1.0: PEAK-System PCAN-USB adapter hwrev 2=
8 serial
> FFFFFFFF (1 channel)
> [ 4360.592034] peak_usb 4-1:1.0: can2: attached to PCAN-USB channel 0=
 (device
> 255)
> [ 4363.753037] peak_usb 1-1:1.0: can0: setting ccbt=3D0x00140006
> [ 4363.770637] peak_usb 1-1:1.0: can1: setting ccbt=3D0x00140006
> [ 4363.787775] peak_usb 4-1:1.0: can2: setting BTR0=3D0x00 BTR1=3D0x1=
4
> [ 4385.878968] usbcore: deregistering interface driver peak_usb
> [ 4385.920049] peak_usb 4-1:1.0: can2 removed
> [ 4385.948036] peak_usb 1-1:1.0: can1 removed
> [ 4385.964042] peak_usb 1-1:1.0: can0 removed
> [ 4385.964076] peak_usb: PCAN-USB interfaces driver unloaded
>=20
> =3D> ok


Hm - i didn't test that so far.

But nice it works :-)

>=20
> - unplug the usb then usb-pro adapters while sending/reading data:
>=20
> [ 5043.008127] peak_usb 4-1:1.0: PEAK-System PCAN-USB adapter hwrev 2=
8 serial
> FFFFFFFF (1 channel)
> [ 5043.012133] peak_usb 4-1:1.0: can0: attached to PCAN-USB channel 0=
 (device
> 255)
> [ 5048.029973] peak_usb 1-1:1.0: PEAK-System PCAN-USB Pro hwrev 0 ser=
ial
> FFFFFFFF.00000001 (2 channels)
> [ 5048.030596] peak_usb 1-1:1.0: can1: attached to PCAN-USB Pro chann=
el 0
> (device 1898240)
> [ 5048.031717] peak_usb 1-1:1.0: can2: attached to PCAN-USB Pro chann=
el 1
> (device 2)
> [ 5053.795570] peak_usb 4-1:1.0: can0: setting BTR0=3D0x00 BTR1=3D0x1=
4
> [ 5053.825418] peak_usb 1-1:1.0: can1: setting ccbt=3D0x00140006
> [ 5053.844272] peak_usb 1-1:1.0: can2: setting ccbt=3D0x00140006
> [ 5081.440039] usb 4-1: USB disconnect, device number 8
> [ 5081.468028] peak_usb 4-1:1.0: can0 removed
> [ 5096.856274] usb 1-1: USB disconnect, device number 16
> [ 5096.876038] peak_usb 1-1:1.0: can2 removed
> [ 5096.896051] peak_usb 1-1:1.0: can1 removed


Doesn't fit to your described setup ... anyway ...

>=20
> (then rmmod):
>=20
> [ 6489.510730] usbcore: deregistering interface driver peak_usb
> [ 6489.510756] peak_usb: PCAN-USB interfaces driver unloaded
>=20
> =3D> Ok
>=20
> (I definitively prefer my logs to yours ;-)


i can imagine that :-)

Pls try the following:

PC1:
can0 -> usb-pro ch1 ----+
can1 -> usb-pro ch2 -+  |
can2 -> usb ---------+  |
                     |  | 1Mpbs
PC2:                 |  |
can0 -> pcmcia ch1 --+  |
can1 -> pcmcia ch2 -----+

PC1:
cangen -g0 -i can0
cangen -g0 -i can1
candump any

PC2:
cangen -g0 -i can0
cangen -g0 -i can1
candump any

and then pull the usb-pro from PC1 ...

That's really unfriendly 8-)

> In my opinion, the Kernel hangs you got don't come from the netif_wak=
e_queue()
> wrong usage, but these tests lead to run some failure cases in the dr=
iver with
> potential bad memory usage... So I did a pass on (I hope) all of thes=
e cases
> too. Anyway, this should be better now.

>

> So, if you don't have any other comments or any other (not very frien=
dly)
> tests, I'm ready to send a new version of the peak_usb.


Please check this use-case above. And when it works with your fixed dri=
ver you
can probalby check the 'old' v5 version to see if you can follow my bug=
 report
on your setup.

Best regards,
Oliver
