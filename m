From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can: 2012-06-15
Date: Fri, 15 Jun 2012 15:26:39 -0700 (PDT)
Message-ID: <20120615.152639.47079140471634524.davem@davemloft.net>
References: <1339755644-6686-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:51756 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758197Ab2FOW0k (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 15 Jun 2012 18:26:40 -0400
In-Reply-To: <1339755644-6686-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 15 Jun 2012 12:20:43 +0200

> Hello David,
> 
> here is a patch intended for v3.5, targeting net/master.
> 
> Dan Carpenter found a precedence error in c_can_chip_config() function
> in the c_can driver, preventing that listen only + loop back mode can be
> activated.

It's not a pull request if you don't give me a GIT url to pull from.
:-)
