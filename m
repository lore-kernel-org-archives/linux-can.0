From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2017-03-03
Date: Fri, 03 Mar 2017 09:58:58 -0800 (PST)
Message-ID: <20170303.095858.360854645699504106.davem@davemloft.net>
References: <20170303135535.22937-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:51730 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbdCCR7O (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 3 Mar 2017 12:59:14 -0500
In-Reply-To: <20170303135535.22937-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri,  3 Mar 2017 14:55:31 +0100

> this is a pull request for the upcoming v4.11 release.
> 
> There are two patches by Ethan Zonca for the gs_usb driver, the first one fixes
> the memory used for USB transfers, the second one the coding style.
> 
> The last two patches are by me, one fixing a memory leak in the usb_8dev driver
> the other a typo in the flexcan driver.

Pulled, thanks.
