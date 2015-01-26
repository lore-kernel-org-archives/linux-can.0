From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can-next 2015-21-01
Date: Mon, 26 Jan 2015 15:42:21 -0800 (PST)
Message-ID: <20150126.154221.279714396115089488.davem@davemloft.net>
References: <54C02F0B.7030509@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:46189 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756442AbbA0ATB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Jan 2015 19:19:01 -0500
In-Reply-To: <54C02F0B.7030509@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 21 Jan 2015 23:58:19 +0100

> this is a pull request of 4 patches for net-next/master.
> 
> Andri Yngvason contributes one patch to further consolidate the CAN
> state change handling. The next patch is by kbuild test robot/Fengguang
> Wu which fixes a coccinelle warning in the CAN infrastructure. The two
> last patches are by me, they remove a unused variable from the flexcan
> and at91_can driver.

Pulled, thanks Marc.
