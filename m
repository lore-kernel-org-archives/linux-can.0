From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v6 14/17] net: can: mscan: adjust to common clock
 support for mpc512x
Date: Sat, 7 Dec 2013 10:57:40 +0100
Message-ID: <20131207105740.3ed4460d@crub>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
	<1385851897-23475-15-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:44940 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754038Ab3LGJ5m (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 7 Dec 2013 04:57:42 -0500
In-Reply-To: <1385851897-23475-15-git-send-email-gsi@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Gerhard Sittig <gsi@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On Sat, 30 Nov 2013 23:51:34 +0100
Gerhard Sittig <gsi@denx.de> wrote:

> implement a .get_clock() callback for the MPC512x platform which uses
> the common clock infrastructure (eliminating direct access to the clock
> control registers from within the CAN network driver), and provide the
> corresponding .put_clock() callback to release resources after use
> 
> acquire both the clock items for register access ("ipg") as well as for
> wire communication ("can")
> 
> keep the previous implementation of MPC512x support in place during
> migration, this results in a readable diff of the change
> 
> this change is neutral to the MPC5200 platform
> 
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: linux-can@vger.kernel.org
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
>  drivers/net/can/mscan/mpc5xxx_can.c |  179 +++++++++++++++++++++++++++++++++++
>  1 file changed, 179 insertions(+)

applied to next. Thanks!

Anatolij
