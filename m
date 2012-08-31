From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Truncate DLC to 8 instead of dropping?
Date: Fri, 31 Aug 2012 18:35:14 +0200
Message-ID: <5040E7C2.4040305@hartkopp.net>
References: <20120831115904.GB2624@pengutronix.de> <20120831125021.GB1191@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:15610 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753986Ab2HaQfS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 31 Aug 2012 12:35:18 -0400
In-Reply-To: <20120831125021.GB1191@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfram Sang <w.sang@pengutronix.de>, Kurt Van Dijck <kurt.van.dijck@eia.be>
Cc: linux-can@vger.kernel.org

Hello Kurt and Wolfram,

On 31.08.2012 14:50, Kurt Van Dijck wrote:

> On Fri, Aug 31, 2012 at 01:59:04PM +0200, Wolfram Sang wrote:
>> Hi,
>>
>> I just noticed today that commit c7cd606f60e7679c7f9eee7010f02a6f000209c1
>> ("can: Fix data length code handling in rx path") says regarding
>> overlong packets:
>>
>> ===
>>
>> The ISO 11898-1 Chapter 8.4.2.3 (DLC field) says that register values > 8
>> should be reduced to 8 without any error reporting or frame drop.
>>
>> ===
>>
>> and this is why get_can_dlc() came into existance.
>>
>> However, functions like can_dropped_invalid_skb() from dev.h or can_rcv() from
>> af_can.c do check for a correct length, but drop the packet in the error case.
>> Don't those need to be fixed?
>>
> 
> Interesting point. My first idea is to acknowledge your thinking, BUT:
> * ISO 11898-1 is about the wire format, whereas your issues address
>   higher level interfaces. Higher level interfaces may IMHO use a stricter
>   format that the wire format.


Pointing to the wire format is a good idea.
To me this "dlc error ignoring" requirement is implemented by the CAN
controller. And when the dlc value in the controller register is not sanitized
we should do it on driver level.

> * I find it very likely that DLC is normalized in user space.
>   This could prevent a lot of confusion in userspace apps.
>   We could now argue on the best place to do normalization, but device drivers
>   seem the best place.


ack.

> * With CAN-FD in mind, the handling of DLC is stricter anyway. DLC > 8 is allowed,
>   but is a real coding (probably), so we decided to communicate a 'len' field
>   to userspace.


Yes. This cleans up the detail that the current can_frame.can_dlc has values
from 0..8 which is a 1:1 mapping to the data payload length.

Usually people use this can_dlc element directly as a 'length' information,
e.g. in for() statements.

for (i=0; i < cframe.can_dlc; i++)
	printf("%02X ", cframe.data[i]);

For CAN FD we defined a canfd_frame.len to point out the length information in
a more abstract way. So that people can stay on the current 'length' usage
schema e.g. in for() statements.

for (i=0; i < cfdframe.len; i++)
	printf("%02X ", cfdframe.data[i]);


The real DLC value is hidden from the userspace API - and all the length and
DLC checking conversion stuff is done in one place: On driver level.

>

> Does this address your concerns?


Does it?

:-)

Regards,
Oliver

