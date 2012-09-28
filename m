From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can-next 2012-09-27
Date: Fri, 28 Sep 2012 18:47:22 -0400 (EDT)
Message-ID: <20120928.184722.207332759072223029.davem@davemloft.net>
References: <5064661E.1000000@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:45687 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932167Ab2I1WrY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 28 Sep 2012 18:47:24 -0400
In-Reply-To: <5064661E.1000000@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 27 Sep 2012 16:43:42 +0200

> Hello David,
> 
> this pull request is for net-next, for the v3.7 release cycle.
> AnilKumar Ch contributed a fix for a segfault in the c_can driver,
> which is triggered by an earlier commit [1] in net-next (so no backport
> is needed).
> 
> Marc
> 
> [1] 4cdd34b can: c_can: Add runtime PM support to Bosch C_CAN/D_CAN controller

Pulled, thanks.
