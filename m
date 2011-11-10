From: Willy Lambert <lambert.willy@gmail.com>
Subject: Re: Problem with so Loved interrupts
Date: Thu, 10 Nov 2011 09:56:18 +0100
Message-ID: <CAKvQZ_0RhjE3+OBLposEBoU8UL66_3JfV237bWnL5pR0HrRMVQ@mail.gmail.com>
References: <CAKvQZ_1Sf8xSJ2dGC7fO+mBFPQj_rwaeuiYcpJozUD0V5P1dYA@mail.gmail.com>
	<CAKvQZ_0XOeaEqzXvC0L7YjBpQymeEhQvDJFwG2re7VTcTXLA3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33865 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933811Ab1KJI4U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 10 Nov 2011 03:56:20 -0500
Received: by wyh15 with SMTP id 15so2438224wyh.19
        for <linux-can@vger.kernel.org>; Thu, 10 Nov 2011 00:56:18 -0800 (PST)
In-Reply-To: <CAKvQZ_0XOeaEqzXvC0L7YjBpQymeEhQvDJFwG2re7VTcTXLA3Q@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

2011/11/9 Willy Lambert <lambert.willy@gmail.com>:
> ---------- Forwarded message ----------
> From: Willy Lambert <lambert.willy@gmail.com>
> Date: 2011/11/9
> Subject: Problem with so Loved interrupts
> To: linux-can <linux-can@vger.kernel.org>
>
>
> Hi all,
> I am having interruption problems again.
> The symptom is a /proc/interrupt or /proc/xenomia/irq not rising.
> I am sure of my Hardware because I used an archive of a working linux
> system and it works. So the wired are Ok, device is responding, BIOS
> is well configured.
> I check this :=A0http://comments.gmane.org/gmane.network.socketcan.us=
er/813,
> and I am sure it is not the case since it worked with the old system
> and it has been electrically protected.
> I also recheck this
> http://old.nabble.com/Re%3A-Trying-to-use-socketCan-on-an-Ixxat-PC-I-=
04-104-p30752686.html
> but once again, everything is ok with old software.
> So what did I changed ? I was updating many of my dependencies on my
> target and even tried 64b, so the road have been very long. What I
> accuse much is my new kernel. Before it was a 2.6.35.7, now it is a
> 2.6.38.8 with xenomai patches. I may have forgot to select a kernel
> option for interrupts...
>
> For completeness :
> my boot up script :
> #choose driver under xenomai or gnulinux
> BAUDRATE=3D1000000
> #notice that we can only set one IRQ for both can, this is an hardwar=
e
> limitation
> CAN_OPTS=3D"irq=3D10,10 mem=3D0xD0000,0xD0200 ocr=3D0x5e,0x5e cdr=3D0=
,0"
> if [ $OROCOS_TARGET =3D=3D "xenomai" ]
> then
> modprobe xeno_can_mem $CAN_OPTS
> rtcanconfig rtcan0 -b $BAUDRATE -v start
> rtcanconfig rtcan1 -b $BAUDRATE -v start
> else
> modprobe sja1000_isa $CAN_OPTS
> #chargement de l'interface dans ifconfig
> ip link set can0 type can bitrate $BAUDRATE restart-ms 1000
> ip link set can1 type can bitrate $BAUDRATE restart-ms 1000
> #demarrage de l'interface
> ifconfig can0 up
> ifconfig can1 up
> fi
> The load seems to be OK there is no error.
>

RTCAN DRIVER :
********************

> /proc/xenomai/interrupt :
> IRQ =A0 =A0 =A0 =A0 CPU0
> =A0 0: =A0 =A0 =A0 88694 =A0 =A0 =A0 =A0 [timer]
> =A010: =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 SJA1000 SJA1000
> =A034: =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 [virtual]
>
> /proc/iomem :
> root@beta(8.2):~# cat /proc/iomem
> 00000000-0000ffff : reserved
> 00010000-0009fbff : System RAM
> 0009fc00-0009ffff : reserved
> 000a0000-000bffff : PCI Bus 0000:00
> =A0 000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000d0000-000dffff : PCI Bus 0000:00
> =A0 000d0000-000d007f : sja1000-mem
> =A0 000d0200-000d027f : sja1000-mem
> 000e0000-000fffff : reserved
> =A0 000f0000-000fffff : System ROM
> 00100000-7f69ffff : System RAM
> =A0 01000000-01282733 : Kernel code
> =A0 01282734-013f163f : Kernel data
> ....
>
> I am sorry I don't have the dmesg yet, I'll provide it as soon as pos=
sible
>

[ 3037.567570] RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Developmen=
t Team
[ 3037.571859] RTCAN SJA1000 driver initialized
[ 3037.574343] rtcan: registered rtcan0
[ 3037.574365] rtcan: registered rtcan1



SJA1000 DRIVER :
************************

Here is the dmesg when loading the sja1000_isa driver :
[ 1966.225513] CAN device driver interface
[ 1966.231935] sja1000 CAN netdevice driver
[ 1966.237265] sja1000_isa sja1000_isa.0: sja1000_isa device
registered (reg_base=3D0xc00d0000, irq=3D10)
[ 1966.239329] sja1000_isa sja1000_isa.1: sja1000_isa device
registered (reg_base=3D0xc00d0200, irq=3D10)
[ 1966.242129] Legacy sja1000_isa driver for max. 8 devices registered
[ 1966.258488] sja1000_isa sja1000_isa.0: setting BTR0=3D0x00 BTR1=3D0x=
14
[ 1966.265427] sja1000_isa sja1000_isa.1: setting BTR0=3D0x00 BTR1=3D0x=
14
(so everything seems ok)

Here is the /proc/interrupts
root@beta(8.2):/opt/ard/arp_hml/script/linux# cat /proc/interrupts
           CPU0
  0:     192360    XT-PIC-XT-PIC    timer
  1:          2    XT-PIC-XT-PIC    i8042
  2:          0    XT-PIC-XT-PIC    cascade
  5:        101    XT-PIC-XT-PIC    uhci_hcd:usb3
  6:       2526    XT-PIC-XT-PIC    ehci_hcd:usb1, uhci_hcd:usb2, eth0
  8:          0    XT-PIC-XT-PIC    rtc0
  9:          0    XT-PIC-XT-PIC    acpi
 10:          0    XT-PIC-XT-PIC    can0, can1
 12:          4    XT-PIC-XT-PIC    i8042
 14:          0    XT-PIC-XT-PIC    ata_piix
 15:       4081    XT-PIC-XT-PIC    ata_piix
NMI:          0   Non-maskable interrupts
MCE:          0   Machine check exceptions
MCP:          8   Machine check polls
ERR:          0

/proc/iomem :
000d0000-000dffff : PCI Bus 0000:00
  000d0000-000d007f : sja1000-mem
  000d0200-000d027f : sja1000-mem
