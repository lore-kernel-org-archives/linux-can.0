From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2017-06-09
Date: Fri, 09 Jun 2017 15:42:17 -0400 (EDT)
Message-ID: <20170609.154217.1768446080709146205.davem@davemloft.net>
References: <20170609125513.24436-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:38154 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751584AbdFITmT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Jun 2017 15:42:19 -0400
In-Reply-To: <20170609125513.24436-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri,  9 Jun 2017 14:55:07 +0200

> this is a pull request of 6 patches for net/master.
> 
> There's a patch by Stephane Grosjean that fixes an uninitialized symbol warning
> in the peak_canfd driver. A patch by Johan Hovold to fix the product-id
> endianness in an error message in the the peak_usb driver. A patch by Oliver
> Hartkopp to enable CAN FD for virtual CAN devices by default. Three patches by
> me, one makes the helper function can_change_state() robust to be called with
> cf == NULL. The next patch fixes a memory leak in the gs_usb driver. And the
> last one fixes a lockdep splat by properly initialize the per-net
> can_rcvlists_lock spin_lock.

Pulled, thank you Marc.
