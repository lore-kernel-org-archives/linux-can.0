From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: flexcan driver: tx_bytes counter never incremented when
 CAN_RAW_LOOPBACK removed?
Date: Mon, 29 Apr 2013 14:37:52 +0200
Message-ID: <517E69A0.8050701@peak-system.com>
References: <CAJW3KNWxa_a727sgi_EO7nMBVbyVrCz0V3wCJBfvhz0ubbqCfA@mail.gmail.com>
 <517A968D.20508@pengutronix.de>
 <CAJW3KNWrdhvXyEA3jmkx+eobH34_g5noykZpyL0YaWjrm1qbLA@mail.gmail.com>
 <20130426205150.GA28450@thinkoso.home> <517E26E4.8010003@pengutronix.de>
 <517E4E01.3080705@peak-system.com> <517E5120.70600@pengutronix.de>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:43478 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044Ab3D2MiC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 29 Apr 2013 08:38:02 -0400
In-Reply-To: <517E5120.70600@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org


Le 29/04/2013 12:53, Marc Kleine-Budde a =E9crit :
> On 04/29/2013 12:40 PM, Stephane Grosjean wrote:
>> Hi Marc,
>>
>> Playing with the flexcan driver, I've seen that the tx_bytes counter
>> always equals 0 while tx_packets increases.
>> I simply removed the CAN_RAW_LOOPBACK option from my CAN socket, so =
I
>> suppose that:
>>
>> stats->tx_bytes +=3D can_get_echo_skb(dev, 0);
>>
>> doesn't do what it should.
>> Am I wrong?
> Let me see. Yes you're right. can_put_echo_skb() only queues the CAN
> frame if CAN_RAW_LOOPBACK is set.
>
> We either can change that can_put_echo_skb() always queues the CAN fr=
ame
> or that can_get_echo_skb() returns the correct number of bytes even i=
f
> the CAN frame is not queued or put the mechanism in each driver.
>
> Marc
>

Why not handling tx_bytes and tx_packets in "flexcan_start_xmit()"=20
instead? Easier and faster change, wouldn't be it?
I also have seen that the flexcan ctrlr (iMx25) behaves oddly when rx=20
overrun occurs: each time I get such an OVR INT., I also get some=20
spurious TX INT. too, while I never sent anything on the CAN. So, for=20
me, handling tx_bytes/tx_packets stats when sending the data would fix=20
everything!

St=E9phane
--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
