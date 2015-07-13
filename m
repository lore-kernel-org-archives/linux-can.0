From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2015-07-12
Date: Sun, 12 Jul 2015 22:24:29 -0700 (PDT)
Message-ID: <20150712.222429.1727959876058548308.davem@davemloft.net>
References: <1436728691-1145-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:39288 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbbGMFYc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Jul 2015 01:24:32 -0400
In-Reply-To: <1436728691-1145-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 12 Jul 2015 21:18:03 +0200

> this is a pull request of 8 patchs for net/master.
> 
> Sergei Shtylyov contributes 5 patches for the rcar_can driver, fixing the IRQ
> check and several info and error messages. There are two patches by J.D.
> Schroeder and Roger Quadros for the c_can driver and dra7x-evm device tree,
> which precent a glitch in the DCAN1 pinmux. Oliver Hartkopp provides a better
> approach to make the CAN skbs unique, the timestamp is replaced by a counter.

Pulled, thanks Marc.
