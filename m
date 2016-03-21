From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC] [PATCH v4] can: fix handling of unmodifiable configuration
 options
Date: Mon, 21 Mar 2016 16:25:01 +0100
Message-ID: <56F0124D.9040008@hartkopp.net>
References: <1458374870-5380-1-git-send-email-socketcan@hartkopp.net>
 <SG2PR06MB10388D08005F04DAD837A02DC38F0@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <56F00B1E.5080909@hartkopp.net>
 <SG2PR06MB10384D5560A346BFF451F61DC38F0@SG2PR06MB1038.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:54450 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755999AbcCUPbX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 21 Mar 2016 11:31:23 -0400
In-Reply-To: <SG2PR06MB10384D5560A346BFF451F61DC38F0@SG2PR06MB1038.apcprd06.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 03/21/2016 04:19 PM, Ramesh Shanmugasundaram wrote:

>> The only thing I was not sure about when forcing static ctrlmodes to be
>> set was the fact that you would need to set fd-non-iso for the MCAN
>> controller setup - even when you only configure it for CAN2.0 traffic:
>>
>> ip link set can0 type can bitrate 100000 -> ok
>>
>> ip link set can0 type can bitrate 100000 one-shot on -> fail
>
> Oh! I checked for M_CAN but only the config above this. Good that you spotted.
>
>>
>> ip link set can0 type can bitrate 100000 one-shot on fd-non-iso on -> ok
>>
>> To be consistent with 'static ctrlmodes have to be provided' it looks ok.
>> But from a CAN2.0 perspective it looks confusing.
>
> Definitely.
>
>>
>> I wonder if it makes sense to handle this *special* case not to force fd-
>> non-iso when the controller won't get into FD mode. What do you think?
>
> Yes, I agree. Non-ISO only mode will eventually phase out and having a "special" case for this sounds logical.
>

Ok. I'll put this special handling into can_changelink() and will post 
an update (v5).

Thanks,
Oliver
