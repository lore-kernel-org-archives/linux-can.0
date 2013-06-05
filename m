From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can-next 2013-06-03
Date: Tue, 04 Jun 2013 17:16:16 -0700 (PDT)
Message-ID: <20130604.171616.705313489046333404.davem@davemloft.net>
References: <51AC8C62.5010905@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:60534 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233Ab3FEAQQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Jun 2013 20:16:16 -0400
In-Reply-To: <51AC8C62.5010905@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 03 Jun 2013 14:30:26 +0200

> this is a pull-request for net-next/master. It consists of two patches
> by Fabio Estevam, cleaning up the flexcan driver (remove default
> pinctrl and switch to SIMPLE_DEV_PM_OPS). A patch by me to simplify the
> Kconfig [1] handling for flexcan. And a patch by Jingoo Han that
> converts the can drivers to use platform_{get,set}_drvdata().
> 
> [1] My patch touches arch/{arm,powerpc}, so I collected Acked-bys from
> Arnd Bergmann, Shawn Guo and Benjamin Herrenschmidt.
 ...
>   git://gitorious.org/linux-can/linux-can-next.git for-davem

Pulled, thanks.
