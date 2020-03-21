From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Need help in interpreting ip status output
Date: Sat, 21 Mar 2020 18:04:35 +0100
Message-ID: <fe141541-7e79-3bee-8c75-29e6f9f3bc4e@hartkopp.net>
References: <a6c8ef8c-5c72-7a2b-98df-0a30057c5fdc@gmx.de>
 <f029f731-25bc-a3f0-c5a9-380012a16839@gmx.de>
 <86b34b1b-7bda-e481-2087-1be8e64d2fed@hartkopp.net>
 <75a1a6b5-141e-e741-f6c2-bab5e9e4e541@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:17569 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgCUREh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 21 Mar 2020 13:04:37 -0400
In-Reply-To: <75a1a6b5-141e-e741-f6c2-bab5e9e4e541@gmx.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Andr=c3=a9_Hartmann?= <aha_1980@gmx.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Alex Blasche <alexander.blasche@qt.io>, Marc Kleine-Budde <mkl@pengutronix.de>

+ Marc

Hi André,

On 21/03/2020 16.19, André Hartmann wrote:

>> On 12/03/2020 18.43, André Hartmann wrote:
>>
>>>> can someone help me interpreting the following ip output:

>> The reason for the overrun error is a notification from the CAN
>> controller itself. It tells us that the received CAN frame has not been
>> read from the controller until the next CAN frame arrived.
> 
> Ok, that's what I thought too, thanks for the confirmation.
> 
>> The dropped counter usually indicates that the CAN driver did not get a
>> skbuff data structure (e.g. out of memory condition).
>>
>> This is NOT good. What CAN hardware/setup are you using?
> 
> Actually it's not my system. The report is from a customer doing a full
> load test on an iMX8: https://bugreports.qt.io/browse/QTBUG-82610

Thanks for the link!

> I guess the customer should try a more recent Kernel than 4.14 first?

The FlexCAN driver (which is used in the IMX8 AFAIK) had a remarkable 
number of changes last year:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/drivers/net/can/flexcan.c

So I would definitely suggest an update.
I added Marc to this thread as he was very active on the FlexCAN 
improvements.

Best,
Oliver
