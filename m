From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/2] flexcan: Use a regulator to control the CAN
 transceiver
Date: Wed, 12 Jun 2013 19:42:00 +0800
Message-ID: <20130612114159.GD13274@S2101-09.ap.freescale.net>
References: <1370460445-15386-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from co1ehsobe002.messaging.microsoft.com ([216.32.180.185]:12112
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753022Ab3FLLla (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 12 Jun 2013 07:41:30 -0400
Content-Disposition: inline
In-Reply-To: <1370460445-15386-1-git-send-email-festevam@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: mkl@pengutronix.de, linux-can@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On Wed, Jun 05, 2013 at 04:27:24PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Instead of using a GPIO to turn on/off the CAN transceiver, it is better to
> use a regulator as some systems may use a PMIC to power the CAN transceiver.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  .../devicetree/bindings/net/can/fsl-flexcan.txt    |  2 +
>  arch/arm/boot/dts/imx28-evk.dts                    | 11 +++++
>  arch/arm/mach-mxs/mach-mxs.c                       | 54 ++--------------------

Acked-by: Shawn Guo <shawn.guo@linaro.org>

>  drivers/net/can/flexcan.c                          | 24 +++++-----
>  4 files changed, 29 insertions(+), 62 deletions(-)

