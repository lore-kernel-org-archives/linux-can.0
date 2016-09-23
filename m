From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2016-09-22
Date: Fri, 23 Sep 2016 07:15:15 -0400 (EDT)
Message-ID: <20160923.071515.557465686208922935.davem@davemloft.net>
References: <20160922124222.31598-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:51124 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759305AbcIWLPS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 23 Sep 2016 07:15:18 -0400
In-Reply-To: <20160922124222.31598-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 22 Sep 2016 14:42:21 +0200

> this is a pull request of one patch for the upcoming linux-4.8 release.
> 
> The patch by Sergei Miroshnichenko fixes a potential deadlock in the generic
> CAN device code that cann occour after a bus-off.

Applied, thanks.
