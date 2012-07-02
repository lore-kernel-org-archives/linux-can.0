From: Rostislav Lisovy <lisovy@gmail.com>
Subject: Re: [PATCH net-next] em_canid: Ematch rule to match CAN frames
 according to their identifiers
Date: Mon, 02 Jul 2012 16:12:55 +0200
Message-ID: <1341238375.11881.16.camel@lolumad>
References: <1340903231-9561-1-git-send-email-lisovy@gmail.com>
	 <4FEDCD42.8010203@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50245 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687Ab2GBONa (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 2 Jul 2012 10:13:30 -0400
In-Reply-To: <4FEDCD42.8010203@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, lartc@vger.kernel.org, pisa@cmp.felk.cvut.cz, sojkam1@fel.cvut.cz

Hello Oliver;

On Fri, 2012-06-29 at 17:44 +0200, Oliver Hartkopp wrote: 
> What about a zero length check here?
> 
> 	if (!len)
> 		return -EINVAL;
> 

> 
> The length could alternatively be checked here too
> 
> http://lxr.linux.no/#linux+v3.4.4/net/sched/ematch.c#L235
> 
> if em->ops->datalen is set.
> 
> But here's no
> 
> 	.datalen = sizeof(struct can_filter),
> 
> defined, right?
> 

The main reason I didn't define the tcf_ematch_ops.datalen field is
because the documentation says it is "length of expected configuration
data" (not "minimal").
For the sake of possible future changes of the built-in length checking,
I will do the check by myself -- I will add the zero-length check (at
least all checks will be at the same place).

Regards;
Rostislav


