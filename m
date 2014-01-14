From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can-next 2014-01-11
Date: Tue, 14 Jan 2014 15:30:03 -0800 (PST)
Message-ID: <20140114.153003.940577644503719850.davem@davemloft.net>
References: <52D191E2.8040703@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:53411 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbaANXaE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 14 Jan 2014 18:30:04 -0500
In-Reply-To: <52D191E2.8040703@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 11 Jan 2014 19:48:02 +0100

> this is a pull request of three patches for net-next/master.
> 
> Oleg Moroz added support for a new PCI card to the generic SJA1000 PCI
> driver, Guenter Roeck's patch limits the flexcan driver to little
> endian arm (and powerpc) and I fixed a sparse warning found by the
> kbuild robot in the ti_hecc driver.

Pulled, thanks Marc.
