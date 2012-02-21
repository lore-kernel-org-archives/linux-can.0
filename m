From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v2] can: sja1000 fix isr hang when hw is unplugged under
 load
Date: Tue, 21 Feb 2012 09:07:23 +0100
Message-ID: <4F4350BB.4090408@hartkopp.net>
References: <1318506157-10329-1-git-send-email-mkl@pengutronix.de> <4F3BE2AC.9020108@hartkopp.net> <4F3EB82C.7080905@pengutronix.de> <4F3FB389.7050104@hartkopp.net> <4F422841.3070901@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:8537 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053Ab2BUIH1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Feb 2012 03:07:27 -0500
In-Reply-To: <4F422841.3070901@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On 20.02.2012 12:02, Marc Kleine-Budde wrote:

> On 02/18/2012 03:19 PM, Oliver Hartkopp wrote:
>>>> In the case of hotplug enabled devices (PCMCIA/PCIeC) the removal of the
>>>> hardware can cause an infinite loop in the common sja1000 isr.
>>>>
>>>> Use the already retrieved status register to indicate a possible hardware
>>>> removal and double check by reading the mode register in sja1000_is_absent.
>>>>
>>>> v2: Create a new function to not print information in irq context.
>>>>
>>>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
>> Indeed it should go into stable 3.2 too, as it was the first kernel, where the
>> EMS PCMCIA driver was integrated.
> 
> I just send it to David, including Cc to stable and Wolfgang's Acked-by.


Are you sure you sent it CC to stable?

Didn't see that in the mail.

Regards,
Oliver

