From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can-next 2012-11-29
Date: Fri, 30 Nov 2012 12:12:26 -0500 (EST)
Message-ID: <20121130.121226.536653832968112405.davem@davemloft.net>
References: <50B76815.8010907@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:44555 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031316Ab2K3RM1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 30 Nov 2012 12:12:27 -0500
In-Reply-To: <50B76815.8010907@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 29 Nov 2012 14:50:13 +0100

> this pull request is for net-next/master. There is a patch by Alexander
> Stein fixing a reference counter problem which can make driver
> unloading impossible (stable Cc'ed). And several patches by me which
> remove an obsolete mechanism from several drivers, which is already
> handled at the infrastructure level.

Applied thanks.
