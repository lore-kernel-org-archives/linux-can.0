From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: flexcan driver: tx_bytes counter never incremented when CAN_RAW_LOOPBACK
 removed?
Date: Mon, 29 Apr 2013 14:55:34 +0200
Message-ID: <517E6DC6.1050709@grandegger.com>
References: <CAJW3KNWxa_a727sgi_EO7nMBVbyVrCz0V3wCJBfvhz0ubbqCfA@mail.gmail.com> <517A968D.20508@pengutronix.de> <CAJW3KNWrdhvXyEA3jmkx+eobH34_g5noykZpyL0YaWjrm1qbLA@mail.gmail.com> <20130426205150.GA28450@thinkoso.home> <517E26E4.8010003@pengutronix.de> <517E4E01.3080705@peak-system.com> <517E5120.70600@pengutronix.de> <517E69A0.8050701@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:40338 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758206Ab3D2Mzh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 29 Apr 2013 08:55:37 -0400
In-Reply-To: <517E69A0.8050701@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 04/29/2013 02:37 PM, Stephane Grosjean wrote:
>=20
> Le 29/04/2013 12:53, Marc Kleine-Budde a =E9crit :
>> On 04/29/2013 12:40 PM, Stephane Grosjean wrote:
>>> Hi Marc,
>>>
>>> Playing with the flexcan driver, I've seen that the tx_bytes counte=
r
>>> always equals 0 while tx_packets increases.
>>> I simply removed the CAN_RAW_LOOPBACK option from my CAN socket, so=
 I
>>> suppose that:
>>>
>>> stats->tx_bytes +=3D can_get_echo_skb(dev, 0);
>>>
>>> doesn't do what it should.
>>> Am I wrong?
>> Let me see. Yes you're right. can_put_echo_skb() only queues the CAN
>> frame if CAN_RAW_LOOPBACK is set.
>>
>> We either can change that can_put_echo_skb() always queues the CAN f=
rame
>> or that can_get_echo_skb() returns the correct number of bytes even =
if
>> the CAN frame is not queued or put the mechanism in each driver.

Or we read it from "regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl".

>>
>> Marc
>>
>=20
> Why not handling tx_bytes and tx_packets in "flexcan_start_xmit()"
> instead? Easier and faster change, wouldn't be it?

Ony messages going really out to the bus sould be counted, if possible.

> I also have seen that the flexcan ctrlr (iMx25) behaves oddly when rx
> overrun occurs: each time I get such an OVR INT., I also get some

OVR INT? What error do you mean?

> spurious TX INT. too, while I never sent anything on the CAN. So, for
> me, handling tx_bytes/tx_packets stats when sending the data would fi=
x
> everything!

See above. What has the handling of tx_bytes/tx_packets stats to do wit=
h
spurious TX INT or the OVR INT?

Wolfgang.

