From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2013-07-19
Date: Sat, 20 Jul 2013 17:01:05 -0700 (PDT)
Message-ID: <20130720.170105.2265427662607648022.davem@davemloft.net>
References: <1374239869-27085-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:37405 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753597Ab3GUABH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 20 Jul 2013 20:01:07 -0400
In-Reply-To: <1374239869-27085-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 19 Jul 2013 15:17:47 +0200

> here are two fixes for the v3.11 release cycle:
> 
> Maximilian Schneider contributes a patch for the esd_usb2 CAN driver. It adds
> sanity checking to the data coming from the USB CAN adapter before using it.
> Alexey Khoroshilov from the Linux Driver Verification project fixes an urb leak
> in the error handling of the USB 8dev's usb_8dev_start() function.

Pulled, thanks Marc.
