From: Michael Walle <michael@walle.cc>
Subject: Re: [PATCH linux-can-next/flexcan] can: flexcan: fix TDC feature
Date: Mon, 29 Jun 2020 18:23:07 +0200
Message-ID: <9dc13a697c246a5c7c53bdd89df7d3c7@walle.cc>
References: <20200416093126.15242-1-qiangqing.zhang@nxp.com>
 <20200416093126.15242-2-qiangqing.zhang@nxp.com>
 <DB8PR04MB6795F7E28A9964A121A06140E6D80@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <d5579883c7e9ab3489ec08a73c407982@walle.cc>
 <39b5d77bda519c4d836f44a554890bae@walle.cc>
 <e38cf40b-ead3-81de-0be7-18cca5ca1a0c@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <e38cf40b-ead3-81de-0be7-18cca5ca1a0c@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Joakim Zhang <qiangqing.zhang@nxp.com>, linux-can@vger.kernel.org, dl-linux-imx <linux-imx@nxp.com>, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hi Marc,

> I've cleaned up the patches a bit, can you test this branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/?h=flexcan

This is working, but as Joakim already said, CAN-FD ISO mode is missing.
It defaults to non-ISO mode, which is even worse, IMHO.

But I've also noticed a difference between the original patch and the
one in that branch. When FD mode is enabled the original patch checks
the priv->can.controlmode [1], the patch in the branch looks at
priv->can.ctrlmode_supported instead [2], is that correct?

-michael

[1] 
https://lore.kernel.org/netdev/20190712075926.7357-4-qiangqing.zhang@nxp.com/
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/tree/drivers/net/can/flexcan.c?h=flexcan&id=5f097cd65cb2b42b88e6e1eb186f6a8f0c90559b#n1341
