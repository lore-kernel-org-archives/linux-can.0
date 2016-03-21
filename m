From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC] [PATCH v4] can: fix handling of unmodifiable configuration
 options
Date: Mon, 21 Mar 2016 15:54:22 +0100
Message-ID: <56F00B1E.5080909@hartkopp.net>
References: <1458374870-5380-1-git-send-email-socketcan@hartkopp.net>
 <SG2PR06MB10388D08005F04DAD837A02DC38F0@SG2PR06MB1038.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:10712 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755895AbcCUOyh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 21 Mar 2016 10:54:37 -0400
In-Reply-To: <SG2PR06MB10388D08005F04DAD837A02DC38F0@SG2PR06MB1038.apcprd06.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Ramesh,

thanks for your feedback - also in the other thread with the wrong 
subject :-)

Indeed I feel pretty good about this solution:

1. it maintains the current behaviour for CAN2.0 controllers
2. it forces valid combinations for CAN FD
3. it forces the user to think about static ctrlmodes

The only thing I was not sure about when forcing static ctrlmodes to be 
set was the fact that you would need to set fd-non-iso for the MCAN 
controller setup - even when you only configure it for CAN2.0 traffic:

ip link set can0 type can bitrate 100000 -> ok

ip link set can0 type can bitrate 100000 one-shot on -> fail

ip link set can0 type can bitrate 100000 one-shot on fd-non-iso on -> ok

To be consistent with 'static ctrlmodes have to be provided' it looks 
ok. But from a CAN2.0 perspective it looks confusing.

I wonder if it makes sense to handle this *special* case not to force 
fd-non-iso when the controller won't get into FD mode. What do you think?

On 03/21/2016 09:37 AM, Ramesh Shanmugasundaram wrote:

>> +static int can_validate(struct nlattr *tb[], struct nlattr *data[]) {
>> +	u32 is_can_fd = 0;
>> +
>> +	/*
>> +	 * Make sure that valid CAN FD configurations always consist of
>> +	 * - nominal/arbitration bittiming
>> +	 * - data bittiming
>> +	 * - control mode with CAN_CTRLMODE_FD set
>> +	 */
>
> This comment style prompts WARNING in latest checkpatch.pl in case you plan to submit in linux-can-next. Otherwise

Ok - I'll fix that in the next version.

> Reviewed-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>

I can also add this then.

Btw. I'll wait for feedback about fd-non-iso first.

Best regards,
Oliver

