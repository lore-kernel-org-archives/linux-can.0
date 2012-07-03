From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 1/2] arm: imx: enable flexcan on imx25, imx35, imx53,
 imx6q
Date: Tue, 3 Jul 2012 10:36:47 +0800
Message-ID: <20120703023644.GB22106@S2101-09.ap.freescale.net>
References: <1341219781-26107-1-git-send-email-mkl@pengutronix.de>
 <1341219781-26107-2-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50166 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753781Ab2GCCgE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 2 Jul 2012 22:36:04 -0400
Received: by yenl2 with SMTP id l2so4786319yen.19
        for <linux-can@vger.kernel.org>; Mon, 02 Jul 2012 19:36:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1341219781-26107-2-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, Sascha Hauer <sha@pengutronix.de>, kernel@pengutronix.de, linux-can@vger.kernel.org

On Mon, Jul 02, 2012 at 11:03:00AM +0200, Marc Kleine-Budde wrote:
> Aas the flexcan driver has DT binding for some time now. This patch makes
> the flexcan driver available in the can drivers menu if a SOC with flexcan
> is enabled.
> 
> Cc: Sascha Hauer <sha@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Applied with subject prefix changed to "ARM: imx: ..."

Regards,
Shawn
