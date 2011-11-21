From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net, sja1000: Don't include version.h in peak_pci.c
 when not needed
Date: Mon, 21 Nov 2011 16:44:21 -0500 (EST)
Message-ID: <20111121.164421.2285321515989917691.davem@davemloft.net>
References: <alpine.LNX.2.00.1111202204480.17195@swampdragon.chaosbits.net>
	<4ECA1F13.4080204@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:41450 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757063Ab1KUVpk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 21 Nov 2011 16:45:40 -0500
In-Reply-To: <4ECA1F13.4080204@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: jj@chaosbits.net, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, wg@grandegger.com

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 21 Nov 2011 10:51:15 +0100

> On 11/20/2011 10:07 PM, Jesper Juhl wrote:
>> It was pointed out by "make versioncheck" that we do not need to include
>> version.h in drivers/net/can/sja1000/peak_pci.c
>> This patch removes the unneeded include.
>> 
>> Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Applied, thanks everyone.
