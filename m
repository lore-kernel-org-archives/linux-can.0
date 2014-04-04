From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 10/10] can: c_can : Disable rx split as workaround
Date: Fri, 4 Apr 2014 18:43:58 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1404041838460.14882@ionos.tec.linutronix.de>
References: <20140404134816.751883017@linutronix.de> <20140404134858.173427806@linutronix.de> <533EDB36.6060404@del-llc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:42145 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986AbaDDQnr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 4 Apr 2014 12:43:47 -0400
In-Reply-To: <533EDB36.6060404@del-llc.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mark <mark5@del-llc.com>
Cc: linux-can <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Alexander Stein <alexander.stein@systec-electronic.com>

On Fri, 4 Apr 2014, Mark wrote:
> The change you describe below (clearing newdat as you go) was one of my major
> changes -- and yes, it allows for potential packet re-ordering.  But I was
> happy to live with that in my application -- as opposed to dropping packets.

We could avoid the re-ordering by reading out newdat/irqpnd status
between packet reads. That's not a too slow operation as it's a direct
read without interface interaction. And we can avoid that extra read
for single packets which is the normal operation mode anyway.

For the TI chips I rather prefer to utilize the DMA provided by IF3
which will get rid of the whole issue and make the RX path a gazillion
times faster as you don't have to interact with IFx at all.

Thanks,

	tglx


