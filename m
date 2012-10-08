From: Andreas Larsson <andreas@gaisler.com>
Subject: Re: [RFC: PATCH 1/5] can: sja1000_platform
Date: Mon, 08 Oct 2012 11:16:04 +0200
Message-ID: <507299D4.9030506@gaisler.com>
References: <1349447947-18451-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vsp-authed02.binero.net ([195.74.38.226]:11641 "HELO
	vsp-authed-01-02.binero.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751026Ab2JHJQl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 8 Oct 2012 05:16:41 -0400
In-Reply-To: <1349447947-18451-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, wg@grandegger.com

On 10/05/2012 04:39 PM, Marc Kleine-Budde wrote:
> Hello,
>
> this series ports the device tree bindings from the existing
> sja1000_of_platform driver to the sja1000_platform driver. It has been compile
> time tested only. I've written the patches to get rid of the
> sja1000_of_platform once this in the kernel.
>
> Please test, especially on sparc, powerpc and arm.

On sparc, sp_probe fails for me because there is no resource of type 
IORESOURCE_IRQ.

As far as I can find out, on sparc (32 and 64 bit) IORESOURCE_IRQ 
resources are never created for the platform_device representation. The 
resources that are created are the ones created for adresses/registers 
in build_device_resources() in arch/sparc/kernel/of_device_32.c and 
arch/sparc/kernel/of_device_64.c respectively.

Cheers,
Andreas

