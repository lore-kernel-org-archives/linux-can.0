From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2014-08-21
Date: Thu, 21 Aug 2014 21:53:39 -0700 (PDT)
Message-ID: <20140821.215339.1016944928830108729.davem@davemloft.net>
References: <1408613002-29693-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:46338 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbaHVExk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 22 Aug 2014 00:53:40 -0400
In-Reply-To: <1408613002-29693-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 21 Aug 2014 11:23:18 +0200

> The first patch is from Mirza Krak, it fixes the initialization of the hardware
> in the sja1000 driver. The next patch is contributed by Dan Carpenter, it fixes
> the error handling in the c_can's probe function. Then there are two patches
> for the flexcan driver, one by Alexander Stein, which fixes the resetting of
> the bus error interrupt mask, the other one by Sebastian Andrzej Siewior which
> adds an additional error state transition message.

Pulled, thanks Marc.
