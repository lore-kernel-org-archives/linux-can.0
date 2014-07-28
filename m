From: Matthias Klein <matthias.klein@optimeas.de>
Subject: Re: can: flexcan: problems with bus error reporting om i.MX53
Date: Mon, 28 Jul 2014 08:34:37 +0200
Message-ID: <53D5EEFD.7020908@optimeas.de>
References: <53D29F02.8010708@optimeas.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from obi-wan.optimeas.de ([82.165.198.204]:40276 "EHLO
	obi-wan.optimeas.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbaG1Gep (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 28 Jul 2014 02:34:45 -0400
In-Reply-To: <53D29F02.8010708@optimeas.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org, support@karo-electronics.de
Cc: Sebastian Siewior <bigeasy@linutronix.de>

For the sake of completeness I have reworked the patch based on:

b1aa1c7 can: flexcan: fix transition from and to freeze mode
                           in chip_{,un}freeze


If I find some spare time will have a look into the "can: berr_limit 
support" series [1].

[1] http://comments.gmane.org/gmane.linux.can/4070


Best regards,
Matthias Klein


Am 25.07.2014 20:16, schrieb Matthias Klein:
> Hi all,
>
> we had the following problems when we enabled bus error reporting on 
> an i.MX537 (Ka-Ro TX53-8130):
> - interrupt flooding when sending a packet on an open bus
> - bus state change notifications did not work properly
> - second bus state change after bus recovery was not properly notified
>
> The patches in the next mails fix all these problems and are tested 
> against mainline linux 3.12.24-rt38 with PREEMPT_RT patch.
>
> Best regards,
> Matthias Klein
>

