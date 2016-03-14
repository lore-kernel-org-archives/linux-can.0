From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC] [PATCH v2] can: fix handling of unmodifiable configuration
 options
Date: Mon, 14 Mar 2016 19:09:35 +0100
Message-ID: <56E6FE5F.2000500@hartkopp.net>
References: <1457807487-14691-1-git-send-email-socketcan@hartkopp.net>
 <SG2PR06MB1038D9B53602CECA8E34C4D4C3880@SG2PR06MB1038.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:14693 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754261AbcCNSJs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 14 Mar 2016 14:09:48 -0400
In-Reply-To: <SG2PR06MB1038D9B53602CECA8E34C4D4C3880@SG2PR06MB1038.apcprd06.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 03/14/2016 11:15 AM, Ramesh Shanmugasundaram wrote:

>> Oliver Hartkopp <socketcan@hartkopp.net>
>> Subject: [RFC] [PATCH v2] can: fix handling of unmodifiable configuration
>> options
>
> (...)
>
>>
>> +static inline void can_set_static_ctrlmode(struct can_priv *priv,
>> +					   const u32 static_mode)
>> +{
>> +	priv->ctrlmode = static_mode;
>> +	priv->ctrlmode_static = static_mode;
>> +}
>
> Is it worth taking the ndev as arg and change the MTU as well in this function? This way mode & MTU would be consistent and would reflect the same in a configuration like this
>
> "ip link set can0 up type can bitrate 1000000 dbitrate 1000000"
>
> Would this be an overkill?

My first thought was that setting the MTU in this function smells fishy.

But as can_set_static_ctrlmode() is intended to be used at CAN device 
setup time only it makes sense to override the MTU which is set in 
can_setup() to CAN_MTU by default.

It doesn't make sense to pass the MTU to alloc_candev() as setting the 
MTU to CAN_MTU is always to correct default (even for configurable CAN 
FD devices).

I'll sed an updated patch which overrides the MTU in 
can_set_static_ctrlmode() when CAN_CTRLMODE_FD is set in ctrlmode_static.

Regards,
Oliver

