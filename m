From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: flexcan driver: tx_bytes counter never incremented when CAN_RAW_LOOPBACK
 removed?
Date: Tue, 30 Apr 2013 13:37:27 +0200
Message-ID: <517FACF7.8050000@grandegger.com>
References: <CAJW3KNWxa_a727sgi_EO7nMBVbyVrCz0V3wCJBfvhz0ubbqCfA@mail.gmail.com> <517A968D.20508@pengutronix.de> <CAJW3KNWrdhvXyEA3jmkx+eobH34_g5noykZpyL0YaWjrm1qbLA@mail.gmail.com> <20130426205150.GA28450@thinkoso.home> <517E26E4.8010003@pengutronix.de> <517E4E01.3080705@peak-system.com> <517E5120.70600@pengutronix.de> <517E69A0.8050701@peak-system.com> <517E6DC6.1050709@grandegger.com> <517F6900.2080404@peak-system.com> <517F9A94.8080308@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:35096 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759520Ab3D3Lhb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 30 Apr 2013 07:37:31 -0400
In-Reply-To: <517F9A94.8080308@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 04/30/2013 12:19 PM, Wolfgang Grandegger wrote:
> On 04/30/2013 08:47 AM, Stephane Grosjean wrote:
>> Le 29/04/2013 14:55, Wolfgang Grandegger a =E9crit :
>>>> I also have seen that the flexcan ctrlr (iMx25) behaves oddly when=
 rx
>>>> overrun occurs: each time I get such an OVR INT., I also get some
>>> OVR INT? What error do you mean?
>>
>>         /* FIFO overflow */
>>         if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_OVERFLOW) {
>=20
> OK... and there is no good reason for a FIFO overflow, right? I mean =
the
> reception rate is not really high.
>=20
>>>> spurious TX INT. too, while I never sent anything on the CAN. So, =
for
>>>> me, handling tx_bytes/tx_packets stats when sending the data would=
 fix
>>>> everything!
>>> See above. What has the handling of tx_bytes/tx_packets stats to do=
 with
>>> spurious TX INT or the OVR INT?
>>
>>         /* transmission complete interrupt */
>>         if (reg_iflag1 & (1 << FLEXCAN_TX_BUF_ID)) {
>>                 stats->tx_bytes +=3D can_get_echo_skb(dev, 0);
>>                 stats->tx_packets++;
>>
>>
>> I don't even know the reason for the moment but when any
>> RX_FIFO_OVERFLOW interrupts occur, some (spurious) TX_BUF_ID follow =
too
>> (to be more precise: FLEXCAN_TX_BUF_ID bit is sometimes set too in
>> iflag1), which leads "tx_packets" to increase while no CAN frames ha=
ve
>> been sent at all! Didn't find any documentation nor errata about thi=
s,
>> but it's a fact.
>=20
> Hm, looks like a bug on this FLexcan variant, which is a very early o=
ne,
> I think. Could you please printk "reg_iflag1",  "reg_iflag2" and
> "reg_esr" at the beginning of "flexcan_irq" and show us the dmesg out=
put
> when such an error shows up?
>=20
>> My proposal was only a quick 'n secure workaround for both issues:
>> "tx_bytes always 0 when LOOPBACK not set" AND "wrong tx_packets (and
>> tx_bytes) management on spurious TX INTerrupts".
>=20
> Well, still two separate issues which needs to be addressed separatel=
y.

In 2012 a similar issue has been discussed on this list with the subjec=
ts:

 "CAN messages being lost on i.MX25 with flexcan"
 "can4linux compilation for i.mx25 under 2.6.39"

Eventually the interrupts on your system are also block for too long
resulting in FIFO overflows. Do you realize message losses?

Wolfgang.
