From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: want blocking writes, but eventually get: errno 105 (No buffer
 space available)
Date: Wed, 22 Jun 2016 17:52:04 +0200
Message-ID: <1322d2e3-31f1-dddd-908b-8a95eb024353@hartkopp.net>
References: <loom.20160622T163626-806@post.gmane.org>
 <loom.20160622T165844-987@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:14422 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311AbcFVPwJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 22 Jun 2016 11:52:09 -0400
In-Reply-To: <loom.20160622T165844-987@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: ajneu <ajneu1@gmail.com>, linux-can@vger.kernel.org



On 06/22/2016 05:00 PM, ajneu wrote:
> ajneu <ajneu1 <at> gmail.com> writes:
>
>>    errno 105 (No buffer space available)
> This is ENOBUFS
>
> ajneu <ajneu1 <at> gmail.com> writes:
>
>
>> * My config:
>>   sudo ip link set can0 down
>>   sudo ip link set can0 txqueuelen 10
>>   sudo ip link set can0 up type can bitrate 250000
>>
>> 1st program run:
>> ~> block on 33'rd write (32 frames queued)
>>
>> 2nd program run:
>> ~> block on 7'th write (6 frames queued)
>>
>> 3rd program run:
>> ~> block on 7'th write (6 frames queued)
>>
>> 4rd program run:
>> ~> when trying 3'rd write: errno 105 (No buffer space available)
>>    (so 2 frames queued)
>>
>> PLEASE: could sombody explain these numbers !
>> They don't make sense to me.
>
> Above if you sum the queued frames, I get: 32+6+6+2 = 46 queued
>
>
> I've checked it for other values of txqueuelen:
>
> sudo ip link set can0 down
> sudo ip link set can0 txqueuelen 1
> sudo ip link set can0 up type can bitrate 250000
> ~> queued: 32+5 == 37
>
> sudo ip link set can0 down
> sudo ip link set can0 txqueuelen 2
> sudo ip link set can0 up type can bitrate 250000
> ~> queued: 32+6 == 38
>
> sudo ip link set can0 down
> sudo ip link set can0 txqueuelen 10
> sudo ip link set can0 up type can bitrate 250000
> ~> queued: 32+6+6+2 == 46
>
> sudo ip link set can0 down
> sudo ip link set can0 txqueuelen 46
> sudo ip link set can0 up type can bitrate 250000
> ~> queued: 32+6+6+6+6+6+6+6+6+2 == 82
>
>
>
> So this is the general formula:
>
> For txqueuelen == N, i.e.
>
> sudo ip link set can0 down
> sudo ip link set can0 txqueuelen N
> sudo ip link set can0 up type can bitrate 250000
> ~> queued: N + 36
>
>
> Please can someone explain this...
> (And also how I can get guaranteed blocking behaviour. ;)  )

If you check proto_ops in Linux there are some sendmsg implementations 
that implement waiting for the queue to be able to take new messages.
Some others do not implement that waiting.

The question is whether blocking write (and probably write outdated 
content) is what you want for CAN.

Regards,
Oliver
