From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2013-04-09
Date: Tue, 09 Apr 2013 13:25:24 -0400 (EDT)
Message-ID: <20130409.132524.1748863572087326219.davem@davemloft.net>
References: <1365495215-12081-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:36487 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932140Ab3DIRZ0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 9 Apr 2013 13:25:26 -0400
In-Reply-To: <1365495215-12081-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue,  9 Apr 2013 10:13:34 +0200

> here's a fix for the v3.9 release cycle, if not too late:
> 
> Wei Yongjun contributes a patch for the can-gw protocoll. The patch fixes the
> memory allocated with kmem_cache_alloc(), is now freed using kmem_cache_free(),
> not kfree().

Pulled, thanks Marc.
