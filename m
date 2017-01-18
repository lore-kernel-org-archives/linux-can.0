From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2017-01-18
Date: Wed, 18 Jan 2017 11:36:58 -0500 (EST)
Message-ID: <20170118.113658.1927581955737910130.davem@davemloft.net>
References: <20170118120852.6095-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:35882 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751887AbdARQhC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2017 11:37:02 -0500
In-Reply-To: <20170118120852.6095-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 18 Jan 2017 13:08:50 +0100

> this is a pull request for net/master consisting of two patches.
> 
> In the first patch Einar Jón fixes a NULL-pointer-deref in the c_can_pci
> driver. In the second patch Yegor Yefremov fixes the clock handling in the
> ti_hecc driver.

Pulled, thanks Marc.
