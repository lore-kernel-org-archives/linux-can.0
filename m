From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2012-11-26
Date: Mon, 26 Nov 2012 17:16:15 -0500 (EST)
Message-ID: <20121126.171615.1221230498234225479.davem@davemloft.net>
References: <1353966430-12601-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:54854 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756712Ab2KZWQT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Nov 2012 17:16:19 -0500
In-Reply-To: <1353966430-12601-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 26 Nov 2012 22:47:08 +0100

> two late fixes for v3.7 from Oliver Hartkopp, he found and fixed a problem in
> the peak usb driver, a hardware timestamp is assigned wrong. In the second
> patch he fixed a problem in the broadcast manager, in case of a timeout the
> rx_ifindex is not set properly.

Pulled, but I cannot guarentee these will make it into 3.7 as
this is very late and I am also travelling.

Worst case is they end up in net-next and you can submit them
to -stable if you wish.
