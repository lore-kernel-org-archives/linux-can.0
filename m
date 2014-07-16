From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can-next 2014-07-15
Date: Tue, 15 Jul 2014 17:40:27 -0700 (PDT)
Message-ID: <20140715.174027.1724741587245396612.davem@davemloft.net>
References: <53C4DBD2.8010309@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:46123 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbaGPAk2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 Jul 2014 20:40:28 -0400
In-Reply-To: <53C4DBD2.8010309@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 15 Jul 2014 09:44:18 +0200

> this is a pull request of 4 patches for net-next/master.
> 
> Prabhakar Lad contributes a patch that converts the c_can driver to use
> the devm api. The remaining four patches by Nikita Edward Baruzdin
> improve the SJA1000 driver with loopback testing support and introduce
> a new testing mode presume ack, for successful transmission even if no
> ACK is received.

Pulled, thanks Marc.
