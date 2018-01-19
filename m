From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can-next 2018-01-16,pull-request: can-next
 2018-01-16
Date: Fri, 19 Jan 2018 10:31:30 -0500 (EST)
Message-ID: <20180119.103130.2135879917945543615.davem@davemloft.net>
References: <b75aff2f-96a5-8bce-b4a8-cf1e9b1df8ad@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:42406 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754951AbeASPbd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Jan 2018 10:31:33 -0500
In-Reply-To: <b75aff2f-96a5-8bce-b4a8-cf1e9b1df8ad@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 19 Jan 2018 10:48:11 +0100

> this is a pull request for net-next/master consisting of 1 patch.
> 
> This patch by Arnd Bergmann for the m_can driver silences a compiler
> warning if CONFIG_PM is not selected.

Pulled, thanks Marc.
