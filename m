From: Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: API to support hardware priorities
Date: Mon, 9 Nov 2015 17:36:36 +0100
Message-ID: <20151109173636.1f98f861@mitra>
References: <20151109123618.41ad1bae@mitra>
	<5640A065.2000401@pengutronix.de>
	<5640A4E4.6020005@pengutronix.de>
	<20151109162703.3fd6d4fc@mitra>
	<5640BDE1.7060508@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:40401 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbbKIQgk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Nov 2015 11:36:40 -0500
In-Reply-To: <5640BDE1.7060508@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, linux-can <linux-can@vger.kernel.org>

Am Mon, 9 Nov 2015 16:38:09 +0100
schrieb Marc Kleine-Budde <mkl@pengutronix.de>:

> OK, I was not aware of that feature. I'll have a look to the
> datasheets. What's the benefit of associating a mailbox to a specific
> ID in the hardware?
A "stop all engines. NOW!"-message would not blocked by 1001 bulk
messages telling about air pressure, temperature and sunshine.
Look at it from a "classic" microcontroller POV.

> ...one serving the bulk hardware FIFO and one serving the high prio HW
"tree/net/sched/em_canid.c" and multiple queues look promising.

Will have a deeper look at it.

Regards
    Bene
