From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v2] can/sja1000: add support for PEAK-System PCMCIA card
Date: Fri, 03 Feb 2012 17:44:59 +0100
Message-ID: <4F2C0F0B.5010607@hartkopp.net>
References: <1328281974-11761-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:13839 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756872Ab2BCQpP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 3 Feb 2012 11:45:15 -0500
In-Reply-To: <1328281974-11761-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

On 03.02.2012 16:12, Stephane Grosjean wrote:

> This patch adds the support of the PCAN-PC Card (PCMCIA) card from
> PEAK-System Technik (http://www.peak-system.com). The PCAN-PC Card is
> sja1000 based and exists in 1 or 2 channels.
> 
> v2 changes:
> - no particular changes except fixing some coding style issues

(..)

> +static int pcan_add_channels(struct pcan_pccard *card)
> +{
> +	struct pcmcia_device *pdev = card->pdev;
> +	int i, err;
> +	u8 ccr = PCC_CCR_INIT;
> +



drivers/net/can/sja1000/peak_pcmcia.c: In function 'pcan_add_channels':
drivers/net/can/sja1000/peak_pcmcia.c:573:2: warning: 'err' may be used uninitialized in this function [-Wuninitialized]

Will test it on Monday as i do not have the hw at home ;-)

Tnx,
Oliver
