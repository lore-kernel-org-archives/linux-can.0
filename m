From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] can: dev: fix nlmsg size calculation in can_get_size()
Date: Mon, 07 Oct 2013 15:56:10 -0400 (EDT)
Message-ID: <20131007.155610.1175248330541668920.davem@davemloft.net>
References: <1381001117-19624-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:35779 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266Ab3JGT4N (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Oct 2013 15:56:13 -0400
In-Reply-To: <1381001117-19624-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de, wg@grandegger.com

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat,  5 Oct 2013 21:25:17 +0200

> This patch fixes the calculation of the nlmsg size, by adding the missing
> nla_total_size().
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Applied and queued up for -stable, thanks.
