From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: flexcan driver: tx_bytes counter never incremented when CAN_RAW_LOOPBACK
 removed?
Date: Tue, 30 Apr 2013 12:19:00 +0200
Message-ID: <517F9A94.8080308@grandegger.com>
References: <CAJW3KNWxa_a727sgi_EO7nMBVbyVrCz0V3wCJBfvhz0ubbqCfA@mail.gmail.com> <517A968D.20508@pengutronix.de> <CAJW3KNWrdhvXyEA3jmkx+eobH34_g5noykZpyL0YaWjrm1qbLA@mail.gmail.com> <20130426205150.GA28450@thinkoso.home> <517E26E4.8010003@pengutronix.de> <517E4E01.3080705@peak-system.com> <517E5120.70600@pengutronix.de> <517E69A0.8050701@peak-system.com> <517E6DC6.1050709@grandegger.com> <517F6900.2080404@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:56637 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758972Ab3D3KTN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 30 Apr 2013 06:19:13 -0400
In-Reply-To: <517F6900.2080404@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 04/30/2013 08:47 AM, Stephane Grosjean wrote:
> Le 29/04/2013 14:55, Wolfgang Grandegger a =E9crit :
>>> I also have seen that the flexcan ctrlr (iMx25) behaves oddly when =
rx
>>> overrun occurs: each time I get such an OVR INT., I also get some
>> OVR INT? What error do you mean?
>=20
>         /* FIFO overflow */
>         if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_OVERFLOW) {

OK... and there is no good reason for a FIFO overflow, right? I mean th=
e
reception rate is not really high.

>>> spurious TX INT. too, while I never sent anything on the CAN. So, f=
or
>>> me, handling tx_bytes/tx_packets stats when sending the data would =
fix
>>> everything!
>> See above. What has the handling of tx_bytes/tx_packets stats to do =
with
>> spurious TX INT or the OVR INT?
>=20
>         /* transmission complete interrupt */
>         if (reg_iflag1 & (1 << FLEXCAN_TX_BUF_ID)) {
>                 stats->tx_bytes +=3D can_get_echo_skb(dev, 0);
>                 stats->tx_packets++;
>=20
>=20
> I don't even know the reason for the moment but when any
> RX_FIFO_OVERFLOW interrupts occur, some (spurious) TX_BUF_ID follow t=
oo
> (to be more precise: FLEXCAN_TX_BUF_ID bit is sometimes set too in
> iflag1), which leads "tx_packets" to increase while no CAN frames hav=
e
> been sent at all! Didn't find any documentation nor errata about this=
,
> but it's a fact.

Hm, looks like a bug on this FLexcan variant, which is a very early one=
,
I think. Could you please printk "reg_iflag1",  "reg_iflag2" and
"reg_esr" at the beginning of "flexcan_irq" and show us the dmesg outpu=
t
when such an error shows up?

> My proposal was only a quick 'n secure workaround for both issues:
> "tx_bytes always 0 when LOOPBACK not set" AND "wrong tx_packets (and
> tx_bytes) management on spurious TX INTerrupts".

Well, still two separate issues which needs to be addressed separately.

Wolfgang.

