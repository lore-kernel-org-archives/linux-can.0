From: Prabhakar Lad <prabhakar.csengg@gmail.com>
Subject: Re: [Gitorious] Activity: prabhakar requested a merge of prab...
Date: Tue, 24 Jun 2014 12:06:00 +0100
Message-ID: <CA+V-a8tcsgj1h+Qu0OSXGEoXvpbm7r0itQTRnmDpQgXiz1t-PA@mail.gmail.com>
References: <53a829dc98811_78d23ff48250bea851769@ratt.gitorious.c.bitbit.net.mail>
 <53A851DC.2060801@hartkopp.net> <53A85445.8070400@pengutronix.de>
 <53A8560F.4060607@hartkopp.net> <53A859E5.7050107@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:45089 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081AbaFXLGd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Jun 2014 07:06:33 -0400
Received: by mail-we0-f181.google.com with SMTP id q59so153293wes.26
        for <linux-can@vger.kernel.org>; Tue, 24 Jun 2014 04:06:30 -0700 (PDT)
In-Reply-To: <53A859E5.7050107@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi

On Mon, Jun 23, 2014 at 5:46 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 06/23/2014 06:30 PM, Oliver Hartkopp wrote:
>> On 23.06.2014 18:22, Marc Kleine-Budde wrote:
>>> On 06/23/2014 06:12 PM, Oliver Hartkopp wrote:
>>>> Hi Prabhakar,
>>>>
>>>> thanks for your patch.
>>>>
>>>> Can you please send it with git send-email to the mailing list for a review?
>>>>
>>>> Additionally:
>>>>
>>>> Does this patch introduce any backward compatibility restrictions (e.g. you
>>>> need at least the includes from 2.6.14+ to build candump ...).
>>>
>>> When was CAN support added to the linux kernel? :)
>>
>> I know that you would detect this joke ;-)
>> Btw. I backported SocketCAN to 2.6.13 - so my question is not totally
>> brain-damaged when talking about the can-utils which are not sticking to a
>> specific kernel version.
>
> I was assuming that there was a certain seriousness in your statement :D
>
> Do you mean the inclusion of "sched.h"? I think this comes from the
> glibc. However, we can add autotool support to detect this.
>
>>>> You only provide to configure a value for SCHED_RR.
>>>> Does it make sense to provide other scheduling policies too?
>>>
>>> I would use chrt to start the tool, if I need non standard scheduling
>>> policies.
>>
>> But then you would like to specifiy the scheduling policy??
>
> You can use chrt to start another program with different scheduling
> policies, it's like nice, but with more functionality. See man page of
> chrt for more information.
>
What do you suggest to go with the patch or just use chrt ?

Regards,
--Prabhakar
