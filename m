From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v6 15/17] net: can: mscan: remove non-CCF code for
 MPC512x
Date: Sat, 7 Dec 2013 10:58:06 +0100
Message-ID: <20131207105806.58a045b7@crub>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
	<1385851897-23475-16-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:55650 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985Ab3LGJ6I (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 7 Dec 2013 04:58:08 -0500
In-Reply-To: <1385851897-23475-16-git-send-email-gsi@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Gerhard Sittig <gsi@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On Sat, 30 Nov 2013 23:51:35 +0100
Gerhard Sittig <gsi@denx.de> wrote:

> transition to the common clock framework has completed and the PPC_CLOCK
> is no longer available for the MPC512x platform, remove the now obsolete
> code path of the mpc5xxx mscan driver which accessed clock control module
> registers directly
> 
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: linux-can@vger.kernel.org
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
>  drivers/net/can/mscan/mpc5xxx_can.c |  141 -----------------------------------
>  1 file changed, 141 deletions(-)

applied to next. Thanks!

Anatolij
