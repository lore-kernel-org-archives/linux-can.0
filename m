From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2015-01-15
Date: Thu, 15 Jan 2015 19:39:34 -0500 (EST)
Message-ID: <20150115.193934.1775213621006010351.davem@davemloft.net>
References: <1421338283-12417-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:56095 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753674AbbAPAjg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 15 Jan 2015 19:39:36 -0500
In-Reply-To: <1421338283-12417-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 15 Jan 2015 17:11:15 +0100

> this is a pull request of 8 patches.
> 
> Ahmed S. Darwish contributes 4 fixes for the kvaser_usb driver. The two patches
> by Oliver Hartkopp mark the m_can driver as non-ISO, as the CANFD standard was
> updated. Roger Quadros's patch for the c_can driver fixes the register access
> during RAMINIT. And one patch by my, which updates the MAINTAINERS file, as we
> moved the git repos to the kernel.org infrastructure.

Pulled, thank you Marc.
