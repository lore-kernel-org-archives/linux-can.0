From: "mirza@hostmobility.com" <mirza@hostmobility.com>
Subject: Re: Dual SJA1000 can controllers on SMP system.
Date: Sun, 16 Jun 2013 13:20:24 +0200
Message-ID: <c2744427f1624d26950ca030d4dff1c6@s75.digisrv.net>
Reply-To: mirza@hostmobility.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vsp02.crystone.se ([83.168.225.21]:29998 "EHLO
	vsp02.crystone.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755324Ab3FPRZM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 16 Jun 2013 13:25:12 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com
Cc: linux-can@vger.kernel.org

=0D
=0D
-------- Ursprungligt meddelande --------=0D
> Fr=E5n: Wolfgang Grandegger <wg@grandegger.com>=0D
> Skickat: den 16 juni 2013 11:19=0D
> Till: Mirza Krak <mirza.krak@hostmobility.com>=0D
> =C4mne: Re: Dual SJA1000 can controllers on SMP system.=0D
> =0D
> On 06/13/2013 02:47 PM, Mirza Krak wrote:=0D
> > Dear Sirs.=0D
> > =0D
> > I am running a 3.1.10 kernel on Nvidia Tegra 2 CPU (Dual Core). Not=
=0D
> > vanilla kernel (Linux4Tegra).=0D
> > =0D
> > We are using dual can controllers connected on th external data bus=
 on=0D
> > our custom hardware. The can controllers are SJA1000.=0D
> =0D
> What external data bus is the CAN controller connected to?=0D
> And which CAN controller board/card?=0D
=0D
As I mentioned the CAN controllers are SJA1000 and the SJA1000 chip is =
integrated in our board. No external card/board for SJA1000 chip.=0D
=0D
It is connected to the Nvidia Tegra 2 externa data bus (a.k.a SNOR). =0D
=0D
> > Driver that is used is vanilla sja1000 driver (sja1000.c)=0D
> =0D
> Which bus driver is used and how do you load the module?=0D
=0D
The bus driver is tegra_snor and is linked in statically in the kernel.=
  =0D
=0D
> =0D
> > Now to the issue at hand. Will try my best to explain our scenario =
and=0D
> > issue:=0D
> >     1. The two can controllers are connected with each other with a=
=0D
> > loop-back.=0D
> >     2. What we are attempting is to send data on both controllers i=
n two=0D
> > separate processes. We are using following command "cansequence can=
0 -p=0D
> > &" and "cansequence can1 -p &". With a bit-rate configured to 1 Mbi=
t/s.=0D
> >     3. What we see when we attempt the above is that one of the=0D
> > controllers stop sending and the software buffer gets filled up. Wh=
en it=0D
> > stops varies but usually after a few packets are sent.=0D
> > =0D
> > After some digging we came to this conclusion. The two cansequence=0D
> > processes end up on different CPU cores. The process that ends up i=
n=0D
> > CPU1 is the one that always stops transmitting.=0D
> > =0D
> > Workarounds that we have seen that works is=0D
> >     1. Disable dual core with kernel argument "maxcpus=3D1".=0D
> >     2. Forcing the cansequence processes to CPU0 with "taskset" com=
mand.=0D
> > =0D
> > My question to you is if anyone has tested the SJA1000 driver on an=
 SMP=0D
> > system or anything similar.=0D
> =0D
> Well, sending from two processes concurrently is not really a typical=
=0D
> use case. ftrace is your friend. A function trace may help to find th=
e=0D
> root of the problem. Let me know if you need further help on that.=0D
=0D
I agree that this is not the typical use case but I still don=B4t see w=
hy this would not work. Any tip on where to start tracing?=0D
=0D
> =0D
> Wolfgang.=0D
> =0D
> --=0D
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in=0D
> the body of a message to majordomo@vger.kernel.org=0D
> More majordomo info at  http://vger.kernel.org/majordomo-info.html=20


