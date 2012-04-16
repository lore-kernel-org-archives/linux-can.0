From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/3] net/can: use module_pci_driver
Date: Mon, 16 Apr 2012 14:57:04 -0400 (EDT)
Message-ID: <20120416.145704.2027920609142940267.davem@davemloft.net>
References: <1334378323.2862.1.camel@phoenix>
	<4F8C6AFC.30601@hartkopp.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:46881 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951Ab2DPTAR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 16 Apr 2012 15:00:17 -0400
In-Reply-To: <4F8C6AFC.30601@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: socketcan@hartkopp.net
Cc: mkl@pengutronix.de, axel.lin@gmail.com, netdev@vger.kernel.org, wg@grandegger.com, linux-can@vger.kernel.org

From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Mon, 16 Apr 2012 20:54:52 +0200

> Hello Dave,
> 
> i've seen that you applied the two pci simplifications from Axel Lin to the
> net-next tree
> 
> http://patchwork.ozlabs.org/patch/152473/
> http://patchwork.ozlabs.org/patch/152474/
> 
> ... but only this one is marked 'awaiting upstream' ?
> 
> http://patchwork.ozlabs.org/patch/152472/
> 
> What does this mean? Should Marc process this patch separately via his
> can-next tree?

Yes.
