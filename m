From: Keith Jones <keith.rjones@yahoo.com>
Subject: Re: Flexcan on imx536 Infotainment
Date: Mon, 4 Jun 2012 15:39:07 -0700 (PDT)
Message-ID: <1338849547.86575.YahooMailNeo@web140805.mail.bf1.yahoo.com>
References: <1338849280.43608.YahooMailNeo@web140802.mail.bf1.yahoo.com>
Reply-To: Keith Jones <keith.rjones@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from nm38-vm5.bullet.mail.bf1.yahoo.com ([72.30.239.21]:41373 "HELO
	nm38-vm5.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1761104Ab2FDWpJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 4 Jun 2012 18:45:09 -0400
In-Reply-To: <1338849280.43608.YahooMailNeo@web140802.mail.bf1.yahoo.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>





Hello,

I must be missing a few patches...


I booted up my new Infotainment=20
demo board after ported 2.6.39 flexcan (flexcan.h flexcan.c) support=20
into my 2.6.35 linux distro.=20

After seeing the flexcan driver register and performing the following c=
ommands, I get constant interrupts and error packets visualized using m=
y Canoe=20
CANbus sniffer. I am using 250K baud. Did not check termination. No=20
oscilloscope was used as yet. Can not receive any packets. Can state=20
goes from ERROR-ACTIVE to ERROR-PASSIVE.


Any clues?


--------------------------------------------------

=2E
=2E

vcan: Virtual CAN interface driver
CAN device driver interface
flexcan netdevice driver
flexcan flexcan.0: device registered (reg_base=3De09f0000, irq=3D82)
flexcan flexcan.1: device registered (reg_base=3De09f8000, irq=3D83)
=2E
=2E
=2E
----------------------------------------------------------------
root@freescale ~$ cat /proc/net/can/version
rev 20090105 abi 8

root@freescale ~$=A0 ip link set can0 up type can bitrate 250000
root@freescale /usr/bin$ ip -d -s link show can0
2: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN=
 qlen 10
=A0=A0=A0 link/can
=A0=A0=A0 can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
=A0=A0=A0 bitrate 250000 sample-point 0.875
=A0=A0=A0 tq 250 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
=A0=A0=A0 flexcan: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 1..256 brp-inc 1
=A0=A0=A0 clock 24000000
=A0=A0=A0 re-started bus-errors arbit-lost error-warn error-pass bus-of=
f
=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0
0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4=A0=A0=A0=A0=
=A0=A0=A0=A0=A0
4=A0=A0=A0=A0=A0=A0=A0=A0=A0 0
=A0=A0=A0 RX: bytes=A0 packets=A0 errors=A0 dropped overrun mcast
=A0=A0=A0 64=A0=A0=A0=A0=A0=A0=A0=A0 8=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0 0
=A0=A0=A0 TX: bytes=A0 packets=A0 errors=A0 dropped carrier collsns
=A0=A0=A0 4=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0 0

root@freescale ~$ cansend can0 123#1122334455
root@freescale /usr/bin$ ip -d -s link show can0
2: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state
UNKNOWN qlen 10
=A0=A0=A0 link/can
=A0=A0=A0 can state ERROR-PASSIVE (berr-counter tx 128 rx 0) restart-ms=
 0
=A0=A0=A0 bitrate 250000 sample-point
0.875
=A0=A0=A0 tq 250 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
=A0=A0=A0 flexcan: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 1..256 brp-inc 1
=A0=A0=A0 clock 24000000
=A0=A0=A0 re-started bus-errors arbit-lost error-warn error-pass bus-of=
f
=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 5=A0=A0=A0=A0=A0=A0=A0=A0=A0 5=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 0
=A0=A0=A0 RX: bytes=A0 packets=A0 errors=A0 dropped overrun mcast
=A0=A0=A0 80=A0=A0=A0=A0=A0=A0=A0=A0 10=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0 0
=A0=A0=A0 TX: bytes=A0 packets=A0 errors=A0
dropped carrier collsns
=A0=A0=A0 5=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0 0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0 0
root@freescale /usr/bin$ cat /proc/interrupts
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CPU0
=A0 1:=A0=A0=A0=A0=A0=A0 1491=A0=A0=A0 MXC_TZIC=A0 mxsdhci
=A0 2:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 MXC_TZIC=A0 mxsdhci
=A0 6:=A0=A0=A0=A0=A0=A0=A0=A0=A0 1=A0=A0=A0 MXC_TZIC=A0 mxc_sdma
=A0 8:=A0=A0=A0=A0=A0=A0=A0=A0=A0 2=A0=A0=A0 MXC_TZIC=A0 mxc_nd
=A0 9:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 MXC_TZIC=A0
VPU_CODEC_IRQ
=A010:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 MXC_TZIC=A0 mxc_ipu
=A011:=A0=A0=A0=A0=A0=A0=A0=A0=A0 2=A0=A0=A0 MXC_TZIC=A0 mxc_ipu
=A012:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 MXC_TZIC=A0 ydx
=A014:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 MXC_TZIC=A0 usb_wakeup, eh=
ci_hcd:usb2
=A016:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 MXC_TZIC=A0 usb_wakeup, eh=
ci_hcd:usb3
=A018:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 MXC_TZIC=A0 usb_wakeup, fs=
l-usb2-otg, ehci_hcd:usb1, fsl-usb2-udc
=A024:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 MXC_TZIC=A0 mxc_rtc
=A028:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 MXC_TZIC=A0
ahci
=A031:=A0=A0=A0=A0=A0=A0 4093=A0=A0=A0 MXC_TZIC=A0 mxcintuart
=A036:=A0=A0=A0=A0=A0=A0=A0=A0=A0 1=A0=A0=A0 MXC_TZIC=A0 CSPI_IRQ
=A039:=A0=A0=A0=A0=A0 69290=A0=A0=A0 MXC_TZIC=A0 i.MX Timer Tick
=A063:=A0=A0=A0=A0=A0=A0=A0 198=A0=A0=A0 MXC_TZIC=A0 imx-i2c
=A064:=A0=A0=A0=A0=A0=A0=A0=A0 60=A0=A0=A0 MXC_TZIC=A0 imx-i2c
=A066:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 MXC_TZIC=A0 asrc
=A069:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 MXC_TZIC=A0 mxc_iim
=A073:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 MXC_TZIC=A0 dvfs
=A082:=A0=A0=A0 1283596=A0=A0=A0 MXC_TZIC=A0
can0
=A084:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 MXC_TZIC=A0 g12
129:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -=A0 mx=
sdhci
132:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -=A0 mx=
sdhci
191:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -=A0 et=
h0
Err:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0
root@freescale /usr/bin$
