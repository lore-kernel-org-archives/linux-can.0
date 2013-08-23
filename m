From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can-next 2013-08-22
Date: Thu, 22 Aug 2013 20:50:33 -0700 (PDT)
Message-ID: <20130822.205033.998664661789407121.davem@davemloft.net>
References: <5215C274.1090200@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:56544 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985Ab3HWDue (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Aug 2013 23:50:34 -0400
In-Reply-To: <5215C274.1090200@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 22 Aug 2013 09:49:08 +0200

> another pull-request for net-next. It consists of two patches by Libo
> Chen, the at91 and flexcan driver make use of platform_set_drvdata()
> rather than open coding it. Chen Gang improves the error checking in
> the c_can_platform driver's probe function.

Pulled, thanks.
