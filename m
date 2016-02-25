From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] can: ems_usb: Fix possible tx overflow
Date: Thu, 25 Feb 2016 15:06:21 -0500 (EST)
Message-ID: <20160225.150621.702895604868235717.davem@davemloft.net>
References: <1456068458-14271-2-git-send-email-mkl@pengutronix.de>
	<56CAFAEE.2020602@cogentembedded.com>
	<56CAFC9E.7050306@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:45213 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933573AbcBYUG3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 25 Feb 2016 15:06:29 -0500
In-Reply-To: <56CAFC9E.7050306@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: sergei.shtylyov@cogentembedded.com, netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de, uttenthaler@ems-wuensche.com, stable@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 22 Feb 2016 13:18:38 +0100

> David, I can send a patch to clean up the coding style. Do you want it
> for net or via net-next?

net-next is fine.
