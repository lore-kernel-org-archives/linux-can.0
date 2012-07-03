From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 2/2] arm: mxs: enable flexcan on imx28
Date: Tue, 3 Jul 2012 10:41:05 +0800
Message-ID: <20120703024104.GC22106@S2101-09.ap.freescale.net>
References: <1341219781-26107-1-git-send-email-mkl@pengutronix.de>
 <1341219781-26107-3-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51958 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478Ab2GCCkX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 2 Jul 2012 22:40:23 -0400
Received: by pbbrp8 with SMTP id rp8so8442836pbb.19
        for <linux-can@vger.kernel.org>; Mon, 02 Jul 2012 19:40:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1341219781-26107-3-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-can@vger.kernel.org

On Mon, Jul 02, 2012 at 11:03:01AM +0200, Marc Kleine-Budde wrote:
> As the flexcan driver has DT binding for some time now. This patch makes
> the flexcan driver available in the can drivers menu if a SOC with flexcan
> is enabled.
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Applied with subject prefix changed to "ARM: mxs: ..."

-- 
Regards,
Shawn
