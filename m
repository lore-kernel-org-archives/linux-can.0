From: Martin Kozusky <mkozusky@kkmicro.cz>
Subject: Re: can4linux compilation for i.mx25 under 2.6.39
Date: Wed, 30 May 2012 14:34:39 +0200
Message-ID: <jq5452$1mv$1@dough.gmane.org>
References: <jq50tg$55u$1@dough.gmane.org> <4FC6099D.3030906@pengutronix.de> <jq52en$i2e$1@dough.gmane.org> <jq52jo$i2e$2@dough.gmane.org> <4FC61007.80802@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:53603 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753268Ab2E3MfI (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 30 May 2012 08:35:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1SZi7D-0002Ez-HD
	for linux-can@vger.kernel.org; Wed, 30 May 2012 14:35:03 +0200
Received: from 213.191.105.242 ([213.191.105.242])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 30 May 2012 14:35:03 +0200
Received: from mkozusky by 213.191.105.242 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 30 May 2012 14:35:03 +0200
In-Reply-To: <4FC61007.80802@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Dne 30.5.2012 14:18, Marc Kleine-Budde napsal(a):
> On 05/30/2012 02:08 PM, Martin Kozusky wrote:
>>>> Why do you want to use can4linux? Socketcan is the official CAN Stack
>>>> for Linux. Be sure you use the latest kernel, because the flexcan driver
>>>> has some bugs and problems prior to v3.4.
>>>>
>>>> Regards, Marc
>>>>
>>
>> And I can only use 2.6.39 kernel because there is no patch for my board
>> for kernel 3.x yet :(
>
> Ask your supplier to a) backport the fixes to your kernel or b) to
> deliver a 3.4 based BSP.

or c) backport the fixes myself :) I think that will be fastest way, if 
it's just about fixes of flexcan driver. Or are there many changes in 
many kernel files?

Martin

> Marc
>


