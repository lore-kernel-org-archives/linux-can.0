From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can-next 2013-01-26
Date: Mon, 28 Jan 2013 00:24:55 -0500 (EST)
Message-ID: <20130128.002455.638752456075920210.davem@davemloft.net>
References: <5103FFA3.5020507@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:39153 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130Ab3A1FY5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 28 Jan 2013 00:24:57 -0500
In-Reply-To: <5103FFA3.5020507@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 26 Jan 2013 17:09:07 +0100

> this is a pull-request for net-next/master. There is are 9 patches by 
> Fabio Baltieri and Kurt Van Dijck which add LED infrastructure and
> support for CAN devices. Bernd Krumboeck adds a driver for the USB CAN
> adapter from 8 devices. Oliver Hartkopp improves the CAN gateway
> functionality. There are 4 patches by me, which clean up the CAN's
> Kconfig.

Pulled, although:

1) You need to create an accessor helper for that can_skb_priv
   thing, every access to it is that horrible cast expression.

2) There is no reason to accomodate out of tree stuff, and for that
   reason I see no reason why you should need that headroom size
   check at all.

   Either the driver uses alloc_can_skb() or it does it's own SKB
   allocation and in-tree you've fixed that.

   You're just asking for trouble by trying to accomodate out of
   tree guys anyways, why if they create a headroom that happens
   to be the size of can_skb_priv.  See what a joke that test is?
   It's not really protecting fully against anything.

Thanks.
