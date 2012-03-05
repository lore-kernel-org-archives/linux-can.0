From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 0/6] can: remove double include, add support for
 various PEAK hardare
Date: Sun, 04 Mar 2012 22:02:45 -0500 (EST)
Message-ID: <20120304.220245.232415488930711083.davem@davemloft.net>
References: <1330794015-14930-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:47963 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755004Ab2CEDDz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 4 Mar 2012 22:03:55 -0500
In-Reply-To: <1330794015-14930-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat,  3 Mar 2012 18:00:09 +0100

> this patch series targets net-next. The first patch by Danny Kukawka
> removes a double include from the cc770 driver. The 5 remaining patches by
> Stephane Grosjean add support for various PEAK hardware:
> - PCAN-PCIeC (PCI-ExpressCard)
> - PCAN-mminiPCI (mini-PCI)
> - PCAN-PCI (PCI next-gen)
> - PCAN-PC Card (PCMCIA)
> - PCAN-USB
> - PCAN-USB Pro

Pulled, thanks a lot.
