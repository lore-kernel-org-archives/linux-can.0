From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH net-next] can: replace the dev_dbg/info/err/... with the
 new netdev_xxx macros
Date: Wed, 01 Feb 2012 11:12:06 +0100
Message-ID: <4F290FF6.4090107@grandegger.com>
References: <4EE61D71.90401@grandegger.com> <4F2864FD.8010909@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:56332 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819Ab2BAKMP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Feb 2012 05:12:15 -0500
In-Reply-To: <4F2864FD.8010909@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Anant Gole <anantgole@ti.com>, Chris Elston <celston@katalix.com>, Sebastian Haas <haas@ems-wuensche.com>, Matthias Fuchs <matthias.fuchs@esd.eu>, Mike Frysinger <vapier@gentoo.org>

On 01/31/2012 11:02 PM, Marc Kleine-Budde wrote:
> On 12/12/2011 04:27 PM, Wolfgang Grandegger wrote:
>> CC: Barry Song <barry.song@analog.com>
>> CC: Anant Gole <anantgole@ti.com>
>> CC: Chris Elston <celston@katalix.com>
>> CC: Sebastian Haas <haas@ems-wuensche.com>
>> CC: Matthias Fuchs <matthias.fuchs@esd.eu>
>> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> 
> ...removed Barry Song <barry.song@analog.com> from Cc, the address in
> unknown.

Is there somebody else we should inform about patches for the bfin_can
driver. Maybe Mike (now on CC)?

Wolfgang.
