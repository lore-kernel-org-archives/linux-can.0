From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v3] can: fix sja1000 pre_irq/post_irq handling
Date: Mon, 18 Nov 2013 20:38:56 +0100
Message-ID: <528A6CD0.4090507@grandegger.com>
References: <528A0F9A.6070305@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:59350 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420Ab3KRTi6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Nov 2013 14:38:58 -0500
In-Reply-To: <528A0F9A.6070305@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 11/18/2013 02:01 PM, Oliver Hartkopp wrote:
> The SJA1000 driver provides optional function pointers to handle specific
> hardware setups at interrupt time.
> 
> This patch fixes the issue that the sja1000_interrupt() function may have
> returned IRQ_NONE without processing the post_irq function. Additionally
> an introduced and documented return value from the pre_irq function is
> checked to skip the entire interrupt handling on pre_irq function errors.
> 
> Reported-by: Wolfgang Grandegger <wg@grandegger.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Acked-by: Wolfgang Grandegger <wg@grandegger.com>

Thanks,

Wolfgang.
