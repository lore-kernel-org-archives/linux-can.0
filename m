From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v3] peak_pci: add support for PEAK-System PCIe/PCIeC/miniPCI
 boards
Date: Wed, 01 Feb 2012 13:02:21 +0100
Message-ID: <4F2929CD.90604@grandegger.com>
References: <1328094132-20738-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:59737 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688Ab2BAMC3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Feb 2012 07:02:29 -0500
In-Reply-To: <1328094132-20738-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can Mailing List <linux-can@vger.kernel.org>

On 02/01/2012 12:02 PM, Stephane Grosjean wrote:
> This patch adds the support for the following 3x sja1000 based PCI boards
> from PEAK-System Technik (www.peak-system.com):
> 
> PCAN-PCI Express (1 or 2 channels)
> PCAN-ExpressCard (1 or 2 channels)
> PCAN-miniPCI (1 or 2 channels)
> 
> This version also updates Kconfig.
> 
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
>  drivers/net/can/sja1000/Kconfig    |    7 +-
>  drivers/net/can/sja1000/peak_pci.c |  510 +++++++++++++++++++++++++++++++++--
>  2 files changed, 484 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/Kconfig
> index 36e9d59..d178e01 100644
> --- a/drivers/net/can/sja1000/Kconfig
> +++ b/drivers/net/can/sja1000/Kconfig
> @@ -44,11 +44,12 @@ config CAN_EMS_PCI
>  	  (http://www.ems-wuensche.de).
>  
>  config CAN_PEAK_PCI
> -	tristate "PEAK PCAN PCI/PCIe Cards"
> +	tristate "PEAK PCAN-PCI/PCIe/PCIeC/miniPCI Cards"
>  	depends on PCI

It now also depends on I2C.

Wolfgang.
