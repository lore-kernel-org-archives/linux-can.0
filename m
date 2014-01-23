From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 1/2] can: Decrease default size of CAN_RAW socket
 send queue
Date: Thu, 23 Jan 2014 12:41:08 -0800 (PST)
Message-ID: <20140123.124108.891860564230946746.davem@davemloft.net>
References: <1390379257-9040-1-git-send-email-sojkam1@fel.cvut.cz>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:59966 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbaAWUlL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 Jan 2014 15:41:11 -0500
In-Reply-To: <1390379257-9040-1-git-send-email-sojkam1@fel.cvut.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: sojkam1@fel.cvut.cz
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, mkl@pengutronix.de

From: Michal Sojka <sojkam1@fel.cvut.cz>
Date: Wed, 22 Jan 2014 09:27:36 +0100

> Since the length of the qdisc queue was set by default to 10
> packets, this is exactly what was happening.

This is your bug, set the qdisc limit to something more reasonable.

Something large enough to absorb the traffic wrt. the speed at which
the CAN device can sink the data.

These two patches are something I am not willing to apply to my
tree, this is not how you solve this problem, sorry.
