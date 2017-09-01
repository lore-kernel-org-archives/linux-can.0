From: Justin Delegard <justin@samsara.com>
Subject: Re: [PATCH] Add TX limit for SocketCAN.
Date: Thu, 31 Aug 2017 21:17:53 -0700
Message-ID: <CANUzxrqNGZ7A_S=L66kZF_LVrkwks3jYjL0tYP173HRC8EnR4w@mail.gmail.com>
References: <1504232079-2583-1-git-send-email-zhongjie.shi@intel.com>
 <CANGgnMb5-cKT=PjxEF6yYAcUkcP29BRnHU+_xY3ASsT-GQ6qzQ@mail.gmail.com> <106C4230743D00439F3B474E2F2FC8CD53885BF7@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34931 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbdIAESP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 1 Sep 2017 00:18:15 -0400
Received: by mail-wm0-f46.google.com with SMTP id v2so1452107wmf.0
        for <linux-can@vger.kernel.org>; Thu, 31 Aug 2017 21:18:14 -0700 (PDT)
In-Reply-To: <106C4230743D00439F3B474E2F2FC8CD53885BF7@SHSMSX101.ccr.corp.intel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Shi, Zhongjie" <zhongjie.shi@intel.com>
Cc: Austin Schuh <austin@peloton-tech.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can <linux-can@vger.kernel.org>

This strikes me as something that should be configured via a sysctl,
not a kernel config option.

Isn't CAN itself robust against such a problem?  Low priority senders
should be clobbered by higher priority ones.

5 packets per second is also extremely slow.  Even on slow buses (eg
250kbps in J1939) the bitrate supports thousands of packets per
second.

What are you trying to protect with this change?  There's no guarantee
any other device on the bus will respect this, and an attacker using
linux could just revert this change.


Justin

On Thu, Aug 31, 2017 at 8:22 PM, Shi, Zhongjie <zhongjie.shi@intel.com> wrote:
> Hi Austin,
>
> It's appreciated for your review and let me know your use cases!
> Just a quick thought, for your case, is it OK to set the TX to some big value, eg. Some value as 10 * 1024 * 1024?
> Please point out if anything I missed in your comment/point.
>
> It will be also appreciated if you or Oliver can share with me the details of how to "use queuing discipline" to achieve this.
>
> Thanks!
>
> Zhongjie
>
>
> -----Original Message-----
> From: Austin Schuh [mailto:austin@peloton-tech.com]
> Sent: Friday, September 01, 2017 11:02 AM
> To: Shi, Zhongjie <zhongjie.shi@intel.com>
> Cc: Oliver Hartkopp <socketcan@hartkopp.net>; Marc Kleine-Budde <mkl@pengutronix.de>; linux-can <linux-can@vger.kernel.org>
> Subject: Re: [PATCH] Add TX limit for SocketCAN.
>
> On Thu, Aug 31, 2017 at 7:14 PM,  <zhongjie.shi@intel.com> wrote:
>> From: "Shi, Zhongjie" <zhongjie.shi@intel.com>
>>
>> This will be used to prevent malicious or unintentional flooding of
>> messages via SocketCAN.
>>
>> Change-Id: I6c2e122e12a594d9ad7dc4bdeebe15a1929eb893
>> Tracked-On: https://jira01.devtools.intel.com/browse/OAM-48496
>> Signed-off-by: Shi, Zhongjie <zhongjie.shi@intel.com>
>> ---
>>  net/can/Kconfig  | 13 +++++++++++++
>>  net/can/af_can.c | 15 +++++++++++++++  net/can/af_can.h |  5 +++++
>>  net/can/proc.c   | 13 +++++++++++++
>>  4 files changed, 46 insertions(+)
>>
>> diff --git a/net/can/Kconfig b/net/can/Kconfig index a15c0e0..aeba3d0
>> 100644
>> --- a/net/can/Kconfig
>> +++ b/net/can/Kconfig
>> @@ -51,6 +51,19 @@ config CAN_GW
>>           They can be modified with AND/OR/XOR/SET operations as configured
>>           by the netlink configuration interface known e.g. from iptables.
>>
>> +config CAN_TX_ATTEMPT_RATE_LIMIT
>> +       int "Tx attempt rate limit"
>> +       default "5"
>> +       ---help---
>> +         This TX attempt rate limit can be used to prevent flood of messages
>> +         from user space. It's TX "attempt" rate here instead of the "actual"
>> +         TX rate because we do the statistics for the TX attempt no matter if
>> +         the message TX is actually sent successful or not. The current
>> +         default value is "5" which means 5 messages per second that is proper
>> +         for an in-vehicle infotainment (IVI) system. For the use cases other
>> +         than IVI, this can be set to the value corresponding to the specific
>> +         requirement.
>> +
>>  source "drivers/net/can/Kconfig"
>>
>>  endif
>
> This default breaks our systems.  We send hundreds of messages/sec, and at worst case when pushing an update out over CAN to other ECUs, saturate the bus.  This should be opt in.
>
> I have vague recollections from Oliver long ago that you can use queueing disciplines to rate limit the interface, which should implement this without any kernel changes.
>
> Austin



-- 
Justin
