From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net: sched: enable CAN Identifier to be build into
 kernel
Date: Fri, 23 Nov 2012 14:22:58 -0500 (EST)
Message-ID: <20121123.142258.816355331172102352.davem@davemloft.net>
References: <1353667497-25676-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1353667497-25676-1-git-send-email-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 23 Nov 2012 11:44:57 +0100

> This patch makes it possible to build the CAN Identifier into the kernel, even
> if the CAN support is build as a module.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Why is this so critical that you're asking me to merge this into
the 'net' tree mere days before Linus makes a release?
