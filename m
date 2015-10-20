From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [Rfi] Cyclone V CAN errors when application pinned to CPU1
Date: Tue, 20 Oct 2015 09:18:07 +0200
Message-ID: <20151020071807.GH20879@pengutronix.de>
References: <562155B7.7020504@vsis.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:42300 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbbJTHlI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 20 Oct 2015 03:41:08 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <mkl@pengutronix.de>)
	id 1ZoRXf-0001yc-Eh
	for linux-can@vger.kernel.org; Tue, 20 Oct 2015 09:41:07 +0200
Received: from [IPv6:2001:6f8:105b:1122:29c9:2eb6:516b:527e] (dyn-2001-06f8-105b-1122-29c9-2eb6-516b-527e.pool.blackshift.org [IPv6:2001:6f8:105b:1122:29c9:2eb6:516b:527e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: mkl@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3DF23AF6B1
	for <linux-can@vger.kernel.org>; Tue, 20 Oct 2015 07:41:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <562155B7.7020504@vsis.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Vlastimil Setka <setka@vsis.cz>
Cc: rfi@lists.rocketboards.org, Marc Kleine-Budde <mkl@pengutronix.de>

Hi,


Adding Marc to Cc:.

On Fri, Oct 16, 2015 at 09:53:27PM +0200, Vlastimil Setka wrote:
> We discovered very weird behaviour of CAN controller in Cyclone V SoC
> with Linux socketcan stack. The problem was first seen on 3.10-ltsi a
> few months ago, and now again on 3.18 from altera github (with rt
> preempt patch applied).

Could you try if the issue happens with a recent mainline kernel as
well? RT is available for 4.1, so that would be a good choice.
 
> We have a linux application which sends data periodically (1 to 20 ms
> period) out over the can0 socketcan interface. Sometimes the first
> data byte in the CAN frame is zero on the wire, but non-zero in the
> data sent! When running with this period, this happens at random
> times, but during a few minutes it can be allways replicated.
> 
> The problem only appears when the application is pinned to CPU1 by
> linux process afinity mechanism. When pinned to default CPU0, there is
> no problem.
> 
> Anyone seen this issue? Any idea how to debug it and what can be a
> reason? What version (git repo / tag) of Linux should I use?
> 
> We plan to do some in-deep evaluation and testing, but I want to share
> the experience now.

Is your test program available somewhere?

Regards,
Robert Schwebel
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

