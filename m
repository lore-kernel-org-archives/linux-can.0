From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2017-12-08
Date: Fri, 08 Dec 2017 14:54:41 -0500 (EST)
Message-ID: <20171208.145441.2138340722800309858.davem@davemloft.net>
References: <20171208155817.9364-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:58272 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752338AbdLHTym (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Dec 2017 14:54:42 -0500
In-Reply-To: <20171208155817.9364-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri,  8 Dec 2017 16:58:11 +0100

> this is a pull request of 6 patches for net/master.
> 
> Martin Kelly provides 5 patches for various USB based CAN drivers, that
> properly cancel the URBs on adapter unplug, so that the driver doesn't
> end up in an endless loop. Stephane Grosjean provides a patch to restart
> the tx queue if zero length packages are transmitted.

Pulled, thanks Marc.
