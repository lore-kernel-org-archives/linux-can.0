From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can-next 2015-09-17
Date: Wed, 14 Oct 2015 18:37:47 -0700 (PDT)
Message-ID: <20151014.183747.1747923782970607848.davem@davemloft.net>
References: <561D2C61.1050201@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:37962 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098AbbJOBVm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 14 Oct 2015 21:21:42 -0400
In-Reply-To: <561D2C61.1050201@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 13 Oct 2015 18:08:01 +0200

> this is a pull request of 4 patches for net-next/master.
> 
> Two patches are by Gerhard Bertelsmann, fixing some problems in the
> sun4i driver. The patch by Arnd Bergmann stops using timeval for the
> CAN broadcast manager. The last patch by Alexandre Belloni removes the
> otherwise unused struct at91_can_data from the driver.

Pulled, thank you.
