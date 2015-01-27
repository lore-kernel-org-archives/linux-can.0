From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can/peak_usb: mark current PEAK USB FD as non-ISO
Date: Tue, 27 Jan 2015 20:19:10 +0100
Message-ID: <54C7E4AE.4080704@hartkopp.net>
References: <1422381484-3804-1-git-send-email-socketcan@hartkopp.net> <54C7D488.4010203@hartkopp.net> <54C7D81A.3030502@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:8434 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970AbbA0TTZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 27 Jan 2015 14:19:25 -0500
In-Reply-To: <54C7D81A.3030502@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can@vger.kernel.org

Compile-tested & plugged in based on the latest peak-next.

Looking forward to test it tomorrow morning.

Tnx!
Oliver

On 27.01.2015 19:25, Marc Kleine-Budde wrote:
> On 01/27/2015 07:10 PM, Oliver Hartkopp wrote:
>> your v10 series looks very good. The ARRAY_SIZE stuff is a good improvement!
>>
>> I compiled the peak-next branch and inserting my single PCAN USB FD adapter
>> worked fine. I'll send my tested-by when I can access my second adapter at
>> work tomorrow.
>
> Thanks.
>
>> The  patch below finally sets the CAN_CTRLMODE_FD_NON_ISO flag.
>> It's tested with the updated ip tool.
>
> Thanks, squashed into patch 9/9
>
>> But beware: The current linux-can-next is missing the CAN_CTRLMODE_FD_NON_ISO
>> patch for M_CAN. Therefore CAN_CTRLMODE_FD_NON_ISO is not defined until Dave
>> pulled net into net-next. So this patch creates a compile error in the latest
>> linux-can-next.
>
> I've cherry-picked the missing patch from net/master and put it into the
> peak-next branch on kernel.org. So the series compiles and when rebasing
> it to net-next after net has been merged, the patch will disappear.
>
> regards,
> Marc
>
