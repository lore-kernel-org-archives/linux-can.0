From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2016-03-04
Date: Fri, 04 Mar 2016 14:33:35 -0500 (EST)
Message-ID: <20160304.143335.1222077020877144032.davem@davemloft.net>
References: <1457078155-8479-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:35125 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757486AbcCDTdh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 4 Mar 2016 14:33:37 -0500
In-Reply-To: <1457078155-8479-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri,  4 Mar 2016 08:55:54 +0100

> Hello David,
> 
> this is a pull request for net/master.
> 
> There is one patch from Ed Spiridonov, which increases the performance of the
> mcp251x SPI CAN driver, by avoiding to write to error flag register if it's
> unnecessary.

Pulled, thanks.
