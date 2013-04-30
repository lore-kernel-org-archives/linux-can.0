From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: flexcan driver: tx_bytes counter never incremented when
 CAN_RAW_LOOPBACK removed?
Date: Tue, 30 Apr 2013 08:47:28 +0200
Message-ID: <517F6900.2080404@peak-system.com>
References: <CAJW3KNWxa_a727sgi_EO7nMBVbyVrCz0V3wCJBfvhz0ubbqCfA@mail.gmail.com>
 <517A968D.20508@pengutronix.de>
 <CAJW3KNWrdhvXyEA3jmkx+eobH34_g5noykZpyL0YaWjrm1qbLA@mail.gmail.com>
 <20130426205150.GA28450@thinkoso.home> <517E26E4.8010003@pengutronix.de>
 <517E4E01.3080705@peak-system.com> <517E5120.70600@pengutronix.de>
 <517E69A0.8050701@peak-system.com> <517E6DC6.1050709@grandegger.com>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:44542 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459Ab3D3Grq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 30 Apr 2013 02:47:46 -0400
In-Reply-To: <517E6DC6.1050709@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Le 29/04/2013 14:55, Wolfgang Grandegger a =E9crit :
>> I also have seen that the flexcan ctrlr (iMx25) behaves oddly when r=
x
>> overrun occurs: each time I get such an OVR INT., I also get some
> OVR INT? What error do you mean?

         /* FIFO overflow */
         if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_OVERFLOW) {


>> spurious TX INT. too, while I never sent anything on the CAN. So, fo=
r
>> me, handling tx_bytes/tx_packets stats when sending the data would f=
ix
>> everything!
> See above. What has the handling of tx_bytes/tx_packets stats to do w=
ith
> spurious TX INT or the OVR INT?

         /* transmission complete interrupt */
         if (reg_iflag1 & (1 << FLEXCAN_TX_BUF_ID)) {
                 stats->tx_bytes +=3D can_get_echo_skb(dev, 0);
                 stats->tx_packets++;


I don't even know the reason for the moment but when any=20
RX_FIFO_OVERFLOW interrupts occur, some (spurious) TX_BUF_ID follow too=
=20
(to be more precise: FLEXCAN_TX_BUF_ID bit is sometimes set too in=20
iflag1), which leads "tx_packets" to increase while no CAN frames have=20
been sent at all! Didn't find any documentation nor errata about this,=20
but it's a fact.

My proposal was only a quick 'n secure workaround for both issues:=20
"tx_bytes always 0 when LOOPBACK not set" AND "wrong tx_packets (and=20
tx_bytes) management on spurious TX INTerrupts".

St=E9phane

--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
