From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH 0/3 v5] can/usb: Add PEAK-System PCAN USB adapters driver
Date: Wed, 22 Feb 2012 16:19:19 +0100
Message-ID: <4F450777.3010301@peak-system.com>
References: <1329481458-2586-1-git-send-email-s.grosjean@peak-system.com>
 <4F44939D.9050703@hartkopp.net> <4F44998B.3040302@hartkopp.net>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:33741 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753259Ab2BVPT2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 22 Feb 2012 10:19:28 -0500
In-Reply-To: <4F44998B.3040302@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

Le 22/02/2012 08:30, Oliver Hartkopp a =E9crit :
> On 22.02.2012 08:05, Oliver Hartkopp wrote:
>
>
> Just printing this status and continue with business as usual (netif_=
wake_queue!) is probably not the right approach 8-)
>
> Please check if it makes sense to check (urb->status !=3D 0) earlier =
in this callback function.
>

Hi Oliver,

I took time to have a look to how things are done in other (net+usb)=20
drivers and it's not easy to conclude to anything: some are testing tha=
t=20
status (but with some other errno values) while others are always wakin=
g=20
up the netdev queues... So, I tried to do a "mixed-of", cleaned up the=20
code and tested it in (something like) your conditions, that is:

PC1:
can0 -> usb-pro ch1 -+
can1 -> usb-pro ch2  |
can2 -> usb ---------+
                      | 1Mpbs
PC2:                 |
can0 -> pcmcia ch1 --+

PC1:
cangen -g0 -i can0
cangen -g0 -i can2
candump any

I did the two following tests:

- removing the peak_usb driver while sending/reading data:

[ 4354.534576] peak_usb 1-1:1.0: can0: attached to PCAN-USB Pro channel=
=20
0 (device 1898240)
[ 4354.535574] peak_usb 1-1:1.0: can1: attached to PCAN-USB Pro channel=
=20
1 (device 2)
[ 4360.388020] usb 4-1: new full speed USB device number 7 using uhci_h=
cd
[ 4360.588035] peak_usb 4-1:1.0: PEAK-System PCAN-USB adapter hwrev 28=20
serial FFFFFFFF (1 channel)
[ 4360.592034] peak_usb 4-1:1.0: can2: attached to PCAN-USB channel 0=20
(device 255)
[ 4363.753037] peak_usb 1-1:1.0: can0: setting ccbt=3D0x00140006
[ 4363.770637] peak_usb 1-1:1.0: can1: setting ccbt=3D0x00140006
[ 4363.787775] peak_usb 4-1:1.0: can2: setting BTR0=3D0x00 BTR1=3D0x14
[ 4385.878968] usbcore: deregistering interface driver peak_usb
[ 4385.920049] peak_usb 4-1:1.0: can2 removed
[ 4385.948036] peak_usb 1-1:1.0: can1 removed
[ 4385.964042] peak_usb 1-1:1.0: can0 removed
[ 4385.964076] peak_usb: PCAN-USB interfaces driver unloaded

=3D> ok

- unplug the usb then usb-pro adapters while sending/reading data:

[ 5043.008127] peak_usb 4-1:1.0: PEAK-System PCAN-USB adapter hwrev 28=20
serial FFFFFFFF (1 channel)
[ 5043.012133] peak_usb 4-1:1.0: can0: attached to PCAN-USB channel 0=20
(device 255)
[ 5048.029973] peak_usb 1-1:1.0: PEAK-System PCAN-USB Pro hwrev 0 seria=
l=20
=46FFFFFFF.00000001 (2 channels)
[ 5048.030596] peak_usb 1-1:1.0: can1: attached to PCAN-USB Pro channel=
=20
0 (device 1898240)
[ 5048.031717] peak_usb 1-1:1.0: can2: attached to PCAN-USB Pro channel=
=20
1 (device 2)
[ 5053.795570] peak_usb 4-1:1.0: can0: setting BTR0=3D0x00 BTR1=3D0x14
[ 5053.825418] peak_usb 1-1:1.0: can1: setting ccbt=3D0x00140006
[ 5053.844272] peak_usb 1-1:1.0: can2: setting ccbt=3D0x00140006
[ 5081.440039] usb 4-1: USB disconnect, device number 8
[ 5081.468028] peak_usb 4-1:1.0: can0 removed
[ 5096.856274] usb 1-1: USB disconnect, device number 16
[ 5096.876038] peak_usb 1-1:1.0: can2 removed
[ 5096.896051] peak_usb 1-1:1.0: can1 removed

(then rmmod):

[ 6489.510730] usbcore: deregistering interface driver peak_usb
[ 6489.510756] peak_usb: PCAN-USB interfaces driver unloaded

=3D> Ok

(I definitively prefer my logs to yours ;-)

In my opinion, the Kernel hangs you got don't come from the=20
netif_wake_queue() wrong usage, but these tests lead to run some failur=
e=20
cases in the driver with potential bad memory usage... So I did a pass=20
on (I hope) all of these cases too. Anyway, this should be better now.

So, if you don't have any other comments or any other (not very=20
friendly) tests, I'm ready to send a new version of the peak_usb.

Once again, thanks for your time.

St=E9phane



--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
