From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: flexcan_poll_error_state(struct net_device *dev, u32 reg_esr)
Date: Mon, 11 Jun 2012 16:45:49 +0200
Message-ID: <4FD6049D.4020004@grandegger.com>
References: <1338849280.43608.YahooMailNeo@web140802.mail.bf1.yahoo.com> <1338849547.86575.YahooMailNeo@web140805.mail.bf1.yahoo.com> <1338852261.93934.YahooMailNeo@web140802.mail.bf1.yahoo.com> <4FCDB93D.5030007@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:40477 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755274Ab2FKOqA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 11 Jun 2012 10:46:00 -0400
In-Reply-To: <4FCDB93D.5030007@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Keith Jones <keith.rjones@yahoo.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 06/05/2012 09:46 AM, Marc Kleine-Budde wrote:
> On 06/05/2012 01:24 AM, Keith Jones wrote:
>> My kernel does not have "flexcan_poll_error_state" function in its
>> flexcan.c file.  Is the following patch still valid?
>>
>> [RFC PATCH 07/14] can: flexcan: consolidate error state handling.=20
>=20
> This patch series hasn't been applied yet.

Right, it's probably from my private gitorious can-next tree... which i=
s
not up-to-date any more. I'm going to delete it... The important patch
fixing the IRQ flooding is:

commit 6e9d554fa6e481a848358c215f129432262123c0
Author: Wolfgang Grandegger <wg@grandegger.com>
Date:   Mon Dec 12 16:09:28 2011 +0100

    can: flexcan: fix irq flooding by clearing all interrupt sources

    As pointed out by Reuben Dowle and Lothar Wa=DFmann, the TWRN_INT,
    RWRN_INT, BOFF_INT interrupt sources need to be cleared as well
    to avoid interrupt flooding, at least for the Flexcan on i.MX28
    SOCs. Furthermore, the interrupts are only cleared, if really one
    of those interrupt sources are pending (which is not the case for
    rx and tx done).

    Cc: Reuben Dowle <Reuben.Dowle@navico.com>
    Cc: Lothar Wa=DFmann <LW@KARO-electronics.de>
    Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
    Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Anyway, on a slow system, bus errors can still result in high system
load. But I do not consider the mx53 a slow system.

>> What would a good linux version to obtain a functioning flexcan
>> driver for imx536?  My demo board is shipped with 2.6.35. I am able
>> migrate to any version with appropriate patches.
>=20
> Use v3.4. Your v2.6.35 is probably a freescale kernel, with a freesca=
le
> flexcan driver. The mainline driver should work with mx53.

I agree.

Wolfgang.

