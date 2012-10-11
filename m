From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v3] can: flexcan: disable bus error interrupts for the
 i.MX6q
Date: Thu, 11 Oct 2012 17:18:36 +0200
Message-ID: <5076E34C.3090404@grandegger.com>
References: <1349962762-24500-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:35812 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106Ab2JKPSr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 11 Oct 2012 11:18:47 -0400
In-Reply-To: <1349962762-24500-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Hui Wang <jason77.wang@gmail.com>, Shawn Guo <shawn.guo@linaro.org>

Hi Marc,

On 10/11/2012 03:39 PM, Marc Kleine-Budde wrote:
> From: Wolfgang Grandegger <wg@grandegger.com>
> 
> Due to a bug in most Flexcan cores, the bus error interrupt needs
> to be enabled. Otherwise we don't get any error warning or passive
> interrupts. This is _not_ necessary for the i.MX6q and this patch
> disables bus error interrupts if "berr-reporting" is not requested.
> This avoids bus error flooding, which might harm, especially on
> low-end systems.

Should be something like:

This patch adds some Flexcan version info and removes the feature flag
FLEXCAN_HAS_BROKEN_ERR_STATE for the i.MX6Q. It also has the line
[TR]WRN_INT properly connected.

> Cc: Hui Wang <jason77.wang@gmail.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> [mkl: convert to incremental patch]
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Changes since v3:
> - convert to incremental patch
> - update mx6 glitch filter information
> ---
> Hello Wolfgang,
> 
> I've converted your patch so that it can be applied to current net, where David
> already accepted your v1 version of the patch.

Thanks, I will not have time before this evening. Looks good, apart from
the commit message. Feel free to go ahead.

Thanks,

Wolfgang.
