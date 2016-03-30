From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v5] can: fix handling of unmodifiable configuration
 options
Date: Wed, 30 Mar 2016 14:24:27 +0200
Message-ID: <56FBC57B.3060204@hartkopp.net>
References: <1458587901-7565-1-git-send-email-socketcan@hartkopp.net>
 <56F80231.1010005@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:22903 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643AbcC3MYf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 30 Mar 2016 08:24:35 -0400
In-Reply-To: <56F80231.1010005@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: ramesh.shanmugasundaram@bp.renesas.com

On 03/27/2016 05:54 PM, Marc Kleine-Budde wrote:
> On 03/21/2016 08:18 PM, Oliver Hartkopp wrote:


>> +static int can_validate(struct nlattr *tb[], struct nlattr *data[])
>> +{
>> +	u32 is_can_fd = 0;
>          ^^^
> I've made this bool.

ok


>> +/* helper to define static CAN controller features at device creation time */
>> +static inline void can_set_static_ctrlmode(struct net_device *dev,
>> +					   const u32 static_mode)
>                                             ^^^^^
>
> I've removed the const here.

ok

But doesn't it make sense to indicate that we do not change the given 
parameter in some way?


> Applied with these changes to can-next.

Thanks!

Oliver

