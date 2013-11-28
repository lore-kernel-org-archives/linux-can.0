From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2013-11-27
Date: Thu, 28 Nov 2013 18:42:03 -0500 (EST)
Message-ID: <20131128.184203.1814210379631673420.davem@davemloft.net>
References: <1385586695-11134-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:47462 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab3K1XmE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Nov 2013 18:42:04 -0500
In-Reply-To: <1385586695-11134-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 27 Nov 2013 22:11:31 +0100

> this is an extention of my pull request from 2013-11-25, it includes an
> additional patch.
> 
> This series consists of a patch by Oliver Hartkopp which fixes some corner
> cases in the interrupt handler of the sja1000 driver. Then there are two
> patches for the c_can dirver. One by me, which fixes a runtime pm related
> "scheduling while atomic" error and patch by Holger Bechtold that fixes the
> calculation of the transmitted bytes.
> 
> The fourth patch (the additional one) is by me, it corrects the clock usage in
> the flexcan driver.

Pulled, thanks Marc.
