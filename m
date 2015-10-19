From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: can-j1939 API
Date: Mon, 19 Oct 2015 08:07:31 +0200
Message-ID: <562488A3.2010204@hartkopp.net>
References: <linux-can/can-utils/pull/7@github.com> <linux-can/can-utils/pull/7/c144149208@github.com> <560ADC91.1090408@pengutronix.de> <20150929194920.GA11430@airbook.vandijck-laurijssen.be> <CAFUozzFQTOASSR94vKQnMGajUSvHGgL7BMuJSvuXKd3=n6aiog@mail.gmail.com> <562151D4.3060902@posteo.de> <20151018024250.GB29078@airbook.vandijck-laurijssen.be> <5624667E.3080809@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:9548 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbbJSGHm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 19 Oct 2015 02:07:42 -0400
In-Reply-To: <5624667E.3080809@posteo.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Patrick Menschel <menschel.p@posteo.de>, linux-can <linux-can@vger.kernel.org>, Alex Layton <alex@layton.in>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

Hi all,

On 19.10.2015 05:41, Patrick Menschel wrote:
> Am 18.10.2015 um 04:42 schrieb Kurt Van Dijck:
>>>
>>> 1. concerning J1939, I think it would be best to implement it is a
>>> "view" on can0 without changing can0 itself.
>>
>> What exactly do you mean with 'view'?
>>
> Basically leave the can0 functionality as it is and add another
> interface such as J1939_0 or whatever. That way other applications may
> still use normal can0. But maybe I just misunderstood your concept,
> sorry if that's the case.
>

I also have problems to understand the concept for a while now.

>>> As it's already been mentioned, j1939 may share the physical layer with
>>> other protocols, i.e. CanOpen on diesel powered railway equipment or
>>> proprietary protocols of some OEMs for construction machinery.
>>> If there is tester or application equipment installed, CCP is usually
>>> also present.
>>
>> Thanks for the example.
>> IMHO, CanOpen uses only 11bit CANids, so theres no collision in the CAN
>> id space. Does anyone ever encountered CAN protrocols that have
>> collisions in the CANid space with can-j1939?
>>
>>>
>>> 2. concerning address claiming and address collision handling via the
>>> NAME property, I think it should be handled in user space, not within
>>> the module as you may have multiple source addresses on the same device.
>>> For example Engine ECU SA 0x00 and Emission Controller SA 0x3D usually
>>> are one and the same physical device.
>>
>> I think I partly share your conclusion,
>> I do not understand how multiple addresses on an ECU are an argument
>> for handling address claiming in userspace.
>>
> If the device running socketcan+j1939 can only have one SA, it would not
> allow such multi-role implementations.

I would definitely demand multi-role implementations as this is one of the 
main SocketCAN goals to have the entire networking setup running on one host 
or on different hosts without changing the application.

See:

https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tree/Documentation/networking/can.txt?h=linux-4.2.y#n185

If I understood the concepts correctly:

Kurts implementation:
- grabs the entire interface (the entire Linux box?!)
- binds node addresses to the interface (Linux box?!)
- socket addressing matches the function

Alexs implementation:
- socket addressing matches the node address

Both implement address claiming (AC) in Kernel space - which would only fit 
the SocketCAN idea of multi-role implementations, when the AC is per-socket in 
Alexs concept.
We should try to move as much functionality as possible out of the kernel. 
When address claiming makes sense there it should stay there.

IMO Alexs concept is not only much smaller in code size and impact to the 
existing af_can infrastructure - it also implements the multi-role concept in 
a slim way the experienced CAN programmer would expect.

Or did I miss anything vital?

Best regards,
Oliver

