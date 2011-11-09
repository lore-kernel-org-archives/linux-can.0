From: Willy Lambert <lambert.willy@gmail.com>
Subject: Fwd: Problem with so Loved interrupts
Date: Wed, 9 Nov 2011 19:28:28 +0100
Message-ID: <CAKvQZ_0XOeaEqzXvC0L7YjBpQymeEhQvDJFwG2re7VTcTXLA3Q@mail.gmail.com>
References: <CAKvQZ_1Sf8xSJ2dGC7fO+mBFPQj_rwaeuiYcpJozUD0V5P1dYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35096 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364Ab1KIS23 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 9 Nov 2011 13:28:29 -0500
Received: by wwh12 with SMTP id 12so1102152wwh.1
        for <linux-can@vger.kernel.org>; Wed, 09 Nov 2011 10:28:28 -0800 (PST)
In-Reply-To: <CAKvQZ_1Sf8xSJ2dGC7fO+mBFPQj_rwaeuiYcpJozUD0V5P1dYA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

---------- Forwarded message ----------
=46rom: Willy Lambert <lambert.willy@gmail.com>
Date: 2011/11/9
Subject: Problem with so Loved interrupts
To: linux-can <linux-can@vger.kernel.org>


Hi all,
I am having interruption problems again.
The symptom is a /proc/interrupt or /proc/xenomia/irq not rising.
I am sure of my Hardware because I used an archive of a working linux
system and it works. So the wired are Ok, device is responding, BIOS
is well configured.
I check this :=A0http://comments.gmane.org/gmane.network.socketcan.user=
/813,
and I am sure it is not the case since it worked with the old system
and it has been electrically protected.
I also recheck this
http://old.nabble.com/Re%3A-Trying-to-use-socketCan-on-an-Ixxat-PC-I-04=
-104-p30752686.html
but once again, everything is ok with old software.
So what did I changed ? I was updating many of my dependencies on my
target and even tried 64b, so the road have been very long. What I
accuse much is my new kernel. Before it was a 2.6.35.7, now it is a
2.6.38.8 with xenomai patches. I may have forgot to select a kernel
option for interrupts...

=46or completeness :
my boot up script :
#choose driver under xenomai or gnulinux
BAUDRATE=3D1000000
#notice that we can only set one IRQ for both can, this is an hardware
limitation
CAN_OPTS=3D"irq=3D10,10 mem=3D0xD0000,0xD0200 ocr=3D0x5e,0x5e cdr=3D0,0=
"
if [ $OROCOS_TARGET =3D=3D "xenomai" ]
then
modprobe xeno_can_mem $CAN_OPTS
rtcanconfig rtcan0 -b $BAUDRATE -v start
rtcanconfig rtcan1 -b $BAUDRATE -v start
else
modprobe sja1000_isa $CAN_OPTS
#chargement de l'interface dans ifconfig
ip link set can0 type can bitrate $BAUDRATE restart-ms 1000
ip link set can1 type can bitrate $BAUDRATE restart-ms 1000
#demarrage de l'interface
ifconfig can0 up
ifconfig can1 up
fi
The load seems to be OK there is no error.

/proc/xenomai/interrupt :
IRQ =A0 =A0 =A0 =A0 CPU0
=A0 0: =A0 =A0 =A0 88694 =A0 =A0 =A0 =A0 [timer]
=A010: =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 SJA1000 SJA1000
=A034: =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 [virtual]

/proc/iomem :
root@beta(8.2):~# cat /proc/iomem
00000000-0000ffff : reserved
00010000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
=A0 000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d0000-000dffff : PCI Bus 0000:00
=A0 000d0000-000d007f : sja1000-mem
=A0 000d0200-000d027f : sja1000-mem
000e0000-000fffff : reserved
=A0 000f0000-000fffff : System ROM
00100000-7f69ffff : System RAM
=A0 01000000-01282733 : Kernel code
=A0 01282734-013f163f : Kernel data
=2E...

I am sorry I don't have the dmesg yet, I'll provide it as soon as possi=
ble
