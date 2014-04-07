From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH] c_can: Add support for eg20t (pch_can)
Date: Mon, 07 Apr 2014 11:47:06 +0200
Message-ID: <9040333.kfdMrH1CV1@ws-stein>
References: <1396534451-9654-1-git-send-email-alexander.stein@systec-electronic.com> <533DAB54.8010008@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:46792 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754523AbaDGJsT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Apr 2014 05:48:19 -0400
In-Reply-To: <533DAB54.8010008@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Hello Wolfgang,

On Thursday 03 April 2014 20:41:24, Wolfgang Grandegger wrote:
> On 04/03/2014 04:14 PM, Alexander Stein wrote:
> > Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> 
> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
> 
> In my patch stack I have also th patch below. Could you please give it
> I try before I re-submit it. Thanks.

With this patch the driver still works, at least MSI is working. The other problems still exist.

Regards,
Alexander

> From 8cc3c5fde12d0dc36b658483433d5b12be693492 Mon Sep 17 00:00:00 2001
> From: Wolfgang Grandegger <wg@grandegger.com>
> Date: Sat, 4 May 2013 22:28:43 +0200
> Subject: [PATCH 07/12] c_can_pci: enable PCI bus master only for MSI
> 
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> ---
>  c_can_pci.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/c_can_pci.c b/c_can_pci.c
> index 3a2ac45..98562c2 100644
> --- a/c_can_pci.c
> +++ b/c_can_pci.c
> @@ -86,8 +86,11 @@ static int c_can_pci_probe(struct pci_dev *pdev,
>  		goto out_disable_device;
>  	}
>  
> -	pci_set_master(pdev);
> -	pci_enable_msi(pdev);
> +	ret = pci_enable_msi(pdev);
> +	if (!ret) {
> +		dev_info(&pdev->dev, "MSI enabled\n");
> +		pci_set_master(pdev);
> +	}
>  
>  	addr = pci_iomap(pdev, c_can_pci_data->bar, 0);
>  	if (!addr) {
> 

-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
Am Windrad 2
08468 Heinsdorfergrund
Tel.: 03765 38600-1156
Fax: 03765 38600-4100
Email: alexander.stein@systec-electronic.com
Website: www.systec-electronic.com
 
Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Chemnitz, HRB 28082
