From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can-next 2017-03-03,pull-request: can-next
 2017-03-03
Date: Wed, 05 Apr 2017 09:57:45 -0700 (PDT)
Message-ID: <20170405.095745.194991019740613194.davem@davemloft.net>
References: <f4c403dd-50c0-be1a-90eb-1d45d3bc1afd@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:43900 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755969AbdDEQ55 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Apr 2017 12:57:57 -0400
In-Reply-To: <f4c403dd-50c0-be1a-90eb-1d45d3bc1afd@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 4 Apr 2017 17:47:28 +0200

> this is a pull request of 5 patches for net-next/master.
> 
> There are two patches by Yegor Yefremov which convert the ti_hecc
> driver into a DT only driver, as there is no in-tree user of the old
> platform driver interface anymore. The next patch by Mario Kicherer
> adds network namespace support to the can subsystem. The last two
> patches by Akshay Bhat add support for the holt_hi311x SPI CAN driver.

Pulled, thanks Marc.
