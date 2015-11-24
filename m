From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2015-11-23
Date: Tue, 24 Nov 2015 14:22:07 -0500 (EST)
Message-ID: <20151124.142207.646576865230879413.davem@davemloft.net>
References: <1448268414-18583-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:44704 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430AbbKXTWJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Nov 2015 14:22:09 -0500
In-Reply-To: <1448268414-18583-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 23 Nov 2015 09:46:51 +0100

> this is a pull request of three patches for the upcoming v4.4 release.
> 
> The first patch is by Mirza Krak, it fixes a problem with the sja1000 driver
> after resuming from suspend to disk, by clearing all outstanding interrupts.
> Oliver Hartkopp contributes two patches targeting almost all driver, they fix
> the assignment of the error location in CAN error messages.

Pulled, thanks Marc.
