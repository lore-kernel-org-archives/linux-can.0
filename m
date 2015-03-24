From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2015-03-22
Date: Mon, 23 Mar 2015 22:36:58 -0400 (EDT)
Message-ID: <20150323.223658.1410554039834160226.davem@davemloft.net>
References: <1427051618-28318-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:60095 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214AbbCXChA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 23 Mar 2015 22:37:00 -0400
In-Reply-To: <1427051618-28318-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 22 Mar 2015 20:13:31 +0100

> this is a pull-request of 7 patches for net/master.
> 
> Ahmed S. Darwish fixes another two problems in the kvaser_usb driver. A patch
> by Colin Ian King for the gs_usb driver adds a missing check for kzalloc
> allocation failures. Two patches by Stephane Grosjean for the peak_usb driver
> add missing support for ISO / non-ISO mode switching. Andri Yngvason
> contributes a patch to fix the state handling in the flexcan driver. The last
> patch by Andreas Werner for the flexcan driver add missing EPROBE_DEFER
> handling for the transceiver regulator.

Pulled, thanks Marc.
