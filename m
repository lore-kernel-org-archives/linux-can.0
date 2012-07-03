From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [Xenomai] RTDM driver for the Advantech 1680U CANbus Adapter
Date: Tue, 03 Jul 2012 22:29:31 +0200
Message-ID: <4FF3562B.7020902@grandegger.com>
References: <4FED4948.8080906@basystemes.fr> <4FED4B42.6000808@wanadoo.fr> <4FEDF65A.50401@grandegger.com> <1012208988.15650.1341343674156.JavaMail.www@wwinf1m30>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:48075 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899Ab2GCU3f (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 3 Jul 2012 16:29:35 -0400
In-Reply-To: <1012208988.15650.1341343674156.JavaMail.www@wwinf1m30>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thierry BULTEL <thierry.bultel@wanadoo.fr>
Cc: xenomai@xenomai.org, Linux-CAN <linux-can@vger.kernel.org>

Hi Thierry,

On 07/03/2012 09:27 PM, Thierry BULTEL wrote:
> Hi Wolfgang,
> 
>  
> 
> Thanks for your feedback.
> 
>  
> 
> The issue is that I did not realize that the patch would not have been accepted as such, so I will have to invest more time on than expected ...
> 
> so I will not be able to do so immediately.

No problem.

> Several comments, to your comments
> 
> 
> - I agree for the multiple devices, theoretically supported by the original Linux driver. I intentionnally removed them, since I do not have the appropriate hardware to test.

Well, your patch should just add *your* new driver. It should *not*
change unrelated things.

> - Linux code style. I really thought I had respected it, furthermore I took another (ixxat) RTDM driver as a model. Ok, I can doublecheck ...

Well, checkplatch.pl does report:

  total: 45 errors, 138 warnings, 427 lines checked

For further information please have a look to

http://lxr.linux.no/#linux+v3.4.4/Documentation/CodingStyle

> - patch high-check vs plx. I do no see what you mean. If I made something wrong it is not intentional. Can you be more specific please ?

-config XENO_DRIVERS_CAN_SJA1000_PLX_PCI
+config XENO_DRIVERS_CAN_SJA1000_ADV_PCI
 	depends on XENO_DRIVERS_CAN_SJA1000 && PCI
-	tristate "PLX90xx PCI-bridge based Cards"
+	tristate "ADVANTECH PCI 168x Card"


I mean "high-check" in the sense of "replacing".

> - Avantech specific ... not much but the classical vendor ID, and also, PCI banks mapping. Again, it is just like the ixxat one, all the driver intelligence is in the generic sja1000 code

It would be nice if the driver could also support other advantec and
non-advantec devices. This could be achieved by by a generic driver, I
believe.

> - patches inline ... Really ??? In the mail content ? But that makes huge mails. I can do so of course, but I do not see the point.

Yes, it makes reviewing the patches much easier. For further information
please read:

http://lxr.linux.no/#linux+v3.4.4/Documentation/SubmittingPatches

Wolfgang.
