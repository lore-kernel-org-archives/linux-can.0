From: Keith Jones <keith.rjones@yahoo.com>
Subject: Re: [Socketcan-users] Flexcan on i.mx536 Infotainment Platform
Date: Mon, 4 Jun 2012 22:00:23 -0700 (PDT)
Message-ID: <1338872423.90411.YahooMailNeo@web140803.mail.bf1.yahoo.com>
References: <1338845698.76889.YahooMailNeo@web140802.mail.bf1.yahoo.com> <4FCD2E39.3060809@pengutronix.de>
Reply-To: Keith Jones <keith.rjones@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from nm10-vm0.bullet.mail.bf1.yahoo.com ([98.139.213.147]:43330 "HELO
	nm10-vm0.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755629Ab2FEFA0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 5 Jun 2012 01:00:26 -0400
In-Reply-To: <4FCD2E39.3060809@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>



On=A0 Monday, June 4, 2012 2:52 PM, Marc Kleine-Budde wrote:

Subject: Re: [Socketcan-users] Flexcan on i.mx536 Infotainment Platform

> Hello Keith,

> please switch to the "linux-can@vger.kernel.org" mailinglist, the
> berlios list is obsolete.

> On 06/04/2012 11:34 PM, Keith Jones wrote:
>> I booted up my new Infotainment demo board after ported 2.6.39
>> flexcan (flexcan.h flexcan.c) support into my 2.6.35 linux distro.

> Use v3.4 or better, this version contains some vital fixes against er=
ror
> irq floods.

Ok moving to v3.4 kernel. I will reply with results.

>> After seeing flexcan driver register and performing the following
>> commands, I get constant interrupts and error packets visualized
>> using my Canoe CANbus sniffer. I am using 250K baud. Did not check
>> termination. No oscilloscope was used as yet. Can not receive any
>> packets. can state goes from ERROR-ACTIVE to ERROR-PASSIVE.

> Please check the Termination, do you have a second CAN member on the =
bus?

I have performed two activities: (1) just the demo board and (2) the de=
mo board and a terminated device. With both, I=A0 observed the same err=
or packet results. I have also attached a scope and observed solid CAN =
signalling on the=20
bus when the remote is sending J1939 ids. The plan is to retest again a=
fter moving to 3.4.

>> Any clues?

>> root@freescale ~$ cansend can0 123#1122334455
>> root@freescale /usr/bin$ ip -d -s link show can0
>> 2: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKN=
OWN qlen 10
>>=A0 =A0  link/can
>>=A0 =A0  can state ERROR-PASSIVE (berr-counter tx 128 rx 0) restart-m=
s 0
>>=A0 =A0  bitrate 250000 sample-point 0.875
>>=A0 =A0  tq 250 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
>>=A0 =A0  flexcan: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 1..256 brp-inc =
1
>>=A0 =A0  clock 24000000
>>=A0 =A0  re-started bus-errors arbit-lost error-warn error-pass bus-o=
ff
>>=A0 =A0  0=A0 =A0 =A0 =A0 =A0 0=A0 =A0 =A0 =A0 =A0 0=A0 =A0 =A0 =A0 =A0=
 5=A0 =A0 =A0 =A0 =A0 5=A0 =A0 =A0 =A0 =A0 0
>>=A0 =A0  RX: bytes=A0 packets=A0 errors=A0 dropped overrun mcast
>>=A0 =A0  80=A0 =A0 =A0 =A0  10=A0 =A0 =A0  0=A0 =A0 =A0  0=A0 =A0 =A0=
  0=A0 =A0 =A0  0
>>=A0 =A0  TX: bytes=A0 packets=A0 errors=A0 dropped carrier collsns
>>=A0 =A0  5=A0 =A0 =A0 =A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =A0 =A0  0=A0 =A0=
 =A0  0=A0 =A0 =A0  0

> If the tx error counter goes up, the device may be the only device on
> the CAN bus. Your sniffer is probably totally passive, which means it
> doesn't qualify as a second station.

tx error counter does go up and yes, my sniffer is passive.

> cheers, Marc
