From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 08/12] can: c_can: Makethe code readable
Date: Tue, 18 Mar 2014 19:23:06 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1403181922100.18573@ionos.tec.linutronix.de>
References: <20140318171007.528610837@linutronix.de>  <20140318171127.430027680@linutronix.de> <1395164220.2812.59.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56337 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756818AbaCRSW6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Mar 2014 14:22:58 -0400
In-Reply-To: <1395164220.2812.59.camel@joe-AO722>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Markus Pargmann <mpa@pengutronix.de>, Benedikt Spranger <b.spranger@linutronix.de>, linux-can@vger.kernel.org, netdev@vger.kernel.org



On Tue, 18 Mar 2014, Joe Perches wrote:

> On Tue, 2014-03-18 at 17:19 +0000, Thomas Gleixner wrote:
> 
> [patch]
> 
> Hi
> 
> The multi-while loop
> 
> 	while ((obj = ffs(pend)) && quota > 0) {
> 		...
> 	} while ((obj = ffs(pend)) && quota > 0);
> 
> looks, umm, unusual.

Indeed. That's a leftover of a previous variant. I'll sent out a
corrected one.

Thanks

	tglx

