From: Andreas Larsson <andreas@gaisler.com>
Subject: Re: [RFC: PATCH 1/5] can: sja1000_platform
Date: Tue, 09 Oct 2012 15:30:14 +0200
Message-ID: <507426E6.7070605@gaisler.com>
References: <1349447947-18451-1-git-send-email-mkl@pengutronix.de> <507299D4.9030506@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vsp-authed02.binero.net ([195.74.38.226]:36585 "HELO
	vsp-authed-02-02.binero.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753977Ab2JINaV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 9 Oct 2012 09:30:21 -0400
In-Reply-To: <507299D4.9030506@gaisler.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, wg@grandegger.com

On 10/08/2012 11:16 AM, Andreas Larsson wrote:
> On 10/05/2012 04:39 PM, Marc Kleine-Budde wrote:
>> Please test, especially on sparc, powerpc and arm.
>
> On sparc, sp_probe fails for me because there is no resource of type
> IORESOURCE_IRQ.
>
> As far as I can find out, on sparc (32 and 64 bit) IORESOURCE_IRQ
> resources are never created for the platform_device representation. The
> resources that are created are the ones created for adresses/registers
> in build_device_resources() in arch/sparc/kernel/of_device_32.c and
> arch/sparc/kernel/of_device_64.c respectively.

It is also worth mentioning that on sparc, the checks against the 
different IORESOURCE_MEM_XXBIT will never be true due to the same 
reason. This information is not in the platform_device representation on 
sparc.

In my case I have 8-bit registers, so the default 8-bit saves me. With 
the irq problem worked around, the driver works fine for me on sparc32.

Cheers,
Andreas

