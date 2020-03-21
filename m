From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Need help in interpreting ip status output
Date: Sat, 21 Mar 2020 13:38:49 +0100
Message-ID: <86b34b1b-7bda-e481-2087-1be8e64d2fed@hartkopp.net>
References: <a6c8ef8c-5c72-7a2b-98df-0a30057c5fdc@gmx.de>
 <f029f731-25bc-a3f0-c5a9-380012a16839@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:22233 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgCUMiz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 21 Mar 2020 08:38:55 -0400
In-Reply-To: <f029f731-25bc-a3f0-c5a9-380012a16839@gmx.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Andr=c3=a9_Hartmann?= <aha_1980@gmx.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi André,

I have an idea ;-)

On 12/03/2020 18.43, André Hartmann wrote:

>> can someone help me interpreting the following ip output:
>>
>> ip -s link show can1
>>       3: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state 
>> UNKNOWN mode DEFAULT group default qlen 100
>>           link/can
>>           RX: bytes  packets  errors  dropped overrun mcast
>>           0          9987413  1       74      1       0
>>           TX: bytes  packets  errors  dropped carrier collsns
>>           0          0        0       0       0       0
>>
>> I'm especially interested in the meaning of the
>>
>> * 1 errors
>> * 74 dropped
>> * 1 overrun

E.g. if you look into
linux/drivers/net/can/sja1000/sja1000.c
you can see that an overrun error also triggers the error counter to 
increase - that's why both are set to 1.

The reason for the overrun error is a notification from the CAN 
controller itself. It tells us that the received CAN frame has not been 
read from the controller until the next CAN frame arrived.

The dropped counter usually indicates that the CAN driver did not get a 
skbuff data structure (e.g. out of memory condition).

This is NOT good. What CAN hardware/setup are you using?

Regards,
Oliver
