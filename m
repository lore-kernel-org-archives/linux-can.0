From: Martin Kozusky <mkozusky@kkmicro.cz>
Subject: Re: can4linux compilation for i.mx25 under 2.6.39
Date: Wed, 30 May 2012 14:05:42 +0200
Message-ID: <jq52en$i2e$1@dough.gmane.org>
References: <jq50tg$55u$1@dough.gmane.org> <4FC6099D.3030906@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:50592 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752993Ab2E3MGH (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 30 May 2012 08:06:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1SZhfA-00007j-Km
	for linux-can@vger.kernel.org; Wed, 30 May 2012 14:06:04 +0200
Received: from 213.191.105.242 ([213.191.105.242])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 30 May 2012 14:06:04 +0200
Received: from mkozusky by 213.191.105.242 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 30 May 2012 14:06:04 +0200
In-Reply-To: <4FC6099D.3030906@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Dne 30.5.2012 13:50, Marc Kleine-Budde napsal(a):
> Hello Martin,
>
> On 05/30/2012 01:39 PM, Martin Kozusky wrote:
>> Hello,
>> I downloaded latest sources of can4linux from svn and I'm trying to
>> compile it for 2.6.39 kernel (i.mx25 driver).
>> I edit cross-imx25 with proper compiler settings etc then ".
>> cross-imx25" and "make"
>>
>> There are some errors like
>> core.c:441:12: error: 'CAN1_BASE_ADDR' undeclared
>> core.c:452:11: error: 'MXC_INT_CAN1' undeclared
>>
>> I can change CAN1_BASE_ADDR to MX25_CAN1_BASE_ADDR and MXC_INT_CAN1 to
>> MX25_INT_CAN1, but there is error
>>
>> imx35.c:18:26: fatal error: mach/mxc_can.h: No such file or directory
>
> It comes from a Karo patch:
>
> http://git.openpandora.org/cgi-bin/gitweb.cgi?p=openembedded.git;a=commitdiff_plain;h=58d6c0ace0c9fe2a3ed9fa845bec9a89583e2fd5
>
>> Does anybody have idea where do I get this file? When I comment this
>> line, compilation continues and stops at
>>
>> imx35.c:113:18: error: dereferencing pointer to incomplete type
>>
>> Does it have anything to do with Karo tx25 board? (which I'm not using)
>> I already have CAN running using SocketCAN, but I also wanted to try
>> can4linux.
>
> Why do you want to use can4linux? Socketcan is the official CAN Stack
> for Linux. Be sure you use the latest kernel, because the flexcan driver
> has some bugs and problems prior to v3.4.
>
> Regards, Marc
>
>

Hello Marc,
I wanted to try if it will be faster than socketcan (which is dropping 
some CAN frames on my HW under heavy load). I need the closest way to 
the controller, and I thought that when can4linux is not using sockets 
layer it could be faster. I also wanted to try LinCAN (which is compared 
to SocketCAN here: 
http://dce.felk.cvut.cz/hanzalek/publications/Hanzalek10_168894.pdf  ) 
but I think it doesn't support Flexcan

Martin

