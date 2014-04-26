From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2014-04-24
Date: Sat, 26 Apr 2014 12:31:55 -0400 (EDT)
Message-ID: <20140426.123155.1657644162899113586.davem@davemloft.net>
References: <1398376829-6771-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:52462 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbaDZQb4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 26 Apr 2014 12:31:56 -0400
In-Reply-To: <1398376829-6771-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 25 Apr 2014 00:00:03 +0200

> this is a pull request for net/master, for the v3.15 release cycle, consisting
> of 26 patches.
> 
> Thomas Gleixner contributes 21 patches for the c_can driver, which address
> several shortcomings in the driver like hardware initialisation, concurrency,
> message ordering and poor performance. Two patches Oliver Hartkopp, one adds a
> missing lock to the sja1000_isa driver, the other one fixes the return value in
> the generic bit time configuration function. And finally a patch by Alexander
> Stein, that fixes the slcan driver to use the correct spinlock variant.

Pulled, thanks.
