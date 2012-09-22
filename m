From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can-next 2012-09-22
Date: Sat, 22 Sep 2012 15:26:41 -0400 (EDT)
Message-ID: <20120922.152641.232413793871445214.davem@davemloft.net>
References: <505CE91C.1070504@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:34641 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527Ab2IVT0m (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 22 Sep 2012 15:26:42 -0400
In-Reply-To: <505CE91C.1070504@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 22 Sep 2012 00:24:28 +0200

> this pull request is intended for net-next (v3.7 cycle), it consist of
> 5 patches by AnilKumar bringing device tree support, runtime PM, suspend
> resume and pinctrl support to the c_can/d_can driver.
> 
> Andreas Larsson improves the sja1000 driver (one-shot, listen only).
> Randy Dunlap fixes a function name conflict in the peak driver.
> Wei Yongjun fixes a return value check in the mscan-mpc5xxx driver.

Pulled, thanks Marc.
