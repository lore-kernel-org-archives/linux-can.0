From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2014-01-29
Date: Thu, 30 Jan 2014 16:49:16 -0800 (PST)
Message-ID: <20140130.164916.449452740498509673.davem@davemloft.net>
References: <1391029863-23099-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:32917 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983AbaAaAtR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 30 Jan 2014 19:49:17 -0500
In-Reply-To: <1391029863-23099-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 29 Jan 2014 22:11:00 +0100

> this is a pull request with three fixes for net/master, for the current release
> cycle.
> 
> Arnd Bergmann provides a fix for the flexcan driver, enabling compilation on
> all combinations of big and little endian on ARM and PowerPc. A patch by Ira W.
> Snyder fixes uninitialized variable warnings in the janz-ican3 driver.
> Rostislav Lisovy contributes a patch to propagate the SO_PRIORITY of raw
> sockets to skbs.

Pulled, thanks Marc.
