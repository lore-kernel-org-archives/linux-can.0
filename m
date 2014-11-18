From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can-next 2014-11-17
Date: Tue, 18 Nov 2014 15:54:55 -0500 (EST)
Message-ID: <20141118.155455.615422092489591255.davem@davemloft.net>
References: <546A0920.4060706@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:56812 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755210AbaKRUy5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Nov 2014 15:54:57 -0500
In-Reply-To: <546A0920.4060706@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 17 Nov 2014 15:41:36 +0100

> this is a pull request of 9 patches for net-next/master.
> 
> All 9 patches are by Roger Quadros and update the c_can platform
> driver. First by improving the initialization sequence of the message
> RAM, making use of syscon/regmap. In the later patches support for
> various TI SoCs is added.

Pulled, thanks Marc.
