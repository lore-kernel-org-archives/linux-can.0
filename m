From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can-next 2018-01-16,pull-request: can-next
 2018-01-16
Date: Wed, 17 Jan 2018 16:08:43 -0500 (EST)
Message-ID: <20180117.160843.201643557390707149.davem@davemloft.net>
References: <335207aa-3313-a981-ee39-ce5c861470c8@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <335207aa-3313-a981-ee39-ce5c861470c8@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 16 Jan 2018 15:28:46 +0100

> this is a pull request for net-next/master consisting of 9 patches.
> 
> This is a series of patches, some of them initially by Franklin S Cooper
> Jr, which was picked up by Faiz Abbas. Faiz Abbas added some patches
> while working on this series, I contributed one as well.
> 
> The first two patches add support to CAN device infrastructure to limit
> the bitrate of a CAN adapter if the used CAN-transceiver has a certain
> maximum bitrate.
> 
> The remaining patches improve the m_can driver. They add support for
> bitrate limiting to the driver, clean up the driver and add support for
> runtime PM.

Pulled.
