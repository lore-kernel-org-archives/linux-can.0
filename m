From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] c_can: Add support for eg20t (pch_can)
Date: Tue, 8 Apr 2014 16:20:41 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1404081619590.14882@ionos.tec.linutronix.de>
References: <"<533DB663.3030408@hartkopp.net>"> <1396853523-14941-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57944 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757086AbaDHOUd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Apr 2014 10:20:33 -0400
In-Reply-To: <1396853523-14941-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Mon, 7 Apr 2014, Alexander Stein wrote:
> -	addr = pci_iomap(pdev, 0, pci_resource_len(pdev, 0));
> +	addr = pci_iomap(pdev, c_can_pci_data->bar, pci_resource_len(pdev, 0));

Shouldn't that be pci_resource_len(pdev, bar) ????

Thanks,

	tglx
