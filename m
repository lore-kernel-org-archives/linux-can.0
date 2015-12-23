From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: can: flexcan: Ancient Freescale Reference FlexCAN Driver and bug
 fixes so it works.
Date: Wed, 23 Dec 2015 11:53:29 +1100
Message-ID: <5679F089.9080509@optusnet.com.au>
References: <1431603215-25546-1-git-send-email-bhupesh.sharma@freescale.com>
 <1431603215-25546-6-git-send-email-bhupesh.sharma@freescale.com>
 <5554C244.80809@pengutronix.de>
 <BY1PR0301MB130358076C3A5969406DE69182D80@BY1PR0301MB1303.namprd03.prod.outlook.com>
 <BY1PR0301MB130384E91308C49A850DEC4782E90@BY1PR0301MB1303.namprd03.prod.outlook.com>
 <56696582.7020503@optusnet.com.au> <566973A4.5000703@pengutronix.de>
 <566A0267.2080809@optusnet.com.au> <56723869.5060900@optusnet.com.au>
Reply-To: tom_usenet@optusnet.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:37921 "EHLO
	mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756310AbbLWAxg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 22 Dec 2015 19:53:36 -0500
In-Reply-To: <56723869.5060900@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "arnd@arndb.de" <arnd@arndb.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 17/12/15 15:22, Tom Evans wrote:
> On 11/12/15 09:53, Tom Evans wrote:
>> On 10/12/2015 11:44 PM, Marc Kleine-Budde wrote:
 >>
>> The simplest path was to fix the simple and stupidly obvious
 >> bugs in the existing driver rather than add new complicated bugs.
>
> There seems to be no end of bugs in this driver. It is a lesson
 > in something.

The Bus Off Recovery doesn't work either. A Bus Off condition results in the 
module being soft-reset and then never woken up again, mainly because the 
calls to "mod_timer()" forget to add "jiffies", so the timer doesn't trigger. 
Then the Auto/Manual mode recovery test is probably backwards. Then it tests 
MDIS instead of HALT, so it never resets the module after the soft reset. If 
you program it in "Auto Recovery" mode it resets it anyway.

Bugs detailed here:

https://community.freescale.com/message/599099#599099

There'll probably be a link on that page to the patches to fix it after I've 
tested it some more.

Tom

