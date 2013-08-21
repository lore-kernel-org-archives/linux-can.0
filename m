From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH next] drivers: net: can: c_can: add type cast from 'unsigned
 int' to 'int'
Date: Wed, 21 Aug 2013 18:04:17 +0800
Message-ID: <521490A1.7030908@asianux.com>
References: <521483CD.8050907@asianux.com> <52148C1E.3020709@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:18894 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640Ab3HUKFd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 Aug 2013 06:05:33 -0400
In-Reply-To: <52148C1E.3020709@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: wg@grandegger.com, anilkumar@ti.com, Tony Lindgren <tony@atomide.com>, jg1.han@samsung.com, David Miller <davem@davemloft.net>, linux-can@vger.kernel.org, netdev <netdev@vger.kernel.org>

On 08/21/2013 05:45 PM, Marc Kleine-Budde wrote:
> On 08/21/2013 11:09 AM, Chen Gang wrote:
>> 'priv->instance' may less than zero, so need a type cast, the related
>> warnings (allmodconfig, "EXTRA_CFLAGS=-W"):
>>
>>   drivers/net/can/c_can/c_can_platform.c:198:3: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> 
> Tnx, I've tweaked the commit message a bit, will send a v2.
> 

OK, thanks.

> Marc
> 


-- 
Chen Gang
