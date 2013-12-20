From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2] can: ti_hecc: Replace platform dependency with ARM
 dependency
Date: Sat, 21 Dec 2013 00:17:27 +0300
Message-ID: <52B4B3E7.8050601@cogentembedded.com>
References: <1387570460-18409-1-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:57876 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201Ab3LTURU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Dec 2013 15:17:20 -0500
Received: by mail-la0-f54.google.com with SMTP id b8so1344362lan.27
        for <linux-can@vger.kernel.org>; Fri, 20 Dec 2013 12:17:19 -0800 (PST)
In-Reply-To: <1387570460-18409-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

Hello.

On 12/20/2013 11:14 PM, Ezequiel Garcia wrote:

> OMAP's ti_hecc driver is used to support the CAN controller on many omap2plus
> SoCs (OMAP2430, OMAP3, OMAP4, OMAP5 and AM335x), so it's wrong to make this
> depend on OMAP3 only. Take an extra step, to get wider build coverage, and make
> the driver depend on ARM.

    To have a real wide coverage, it's probably worth adding '|| COMIPLE_TEXT' 
to 'depends on ARCH_OMAP2PLUS'?

> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

WBR, Sergei


