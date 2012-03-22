From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC] can: Introducing CANFD for af_can & can-raw
Date: Thu, 22 Mar 2012 12:00:51 +0100
Message-ID: <4F6B0663.1080405@grandegger.com>
References: <20120321110502.GA3372@vandijck-laurijssen.be> <4F69BEE3.2040705@pengutronix.de> <20120321120846.GB3372@vandijck-laurijssen.be> <4F69CA74.3020607@pengutronix.de> <4F69D5D2.5080003@hartkopp.net> <20120321135339.GB6428@vandijck-laurijssen.be> <4F69EC19.7090205@grandegger.com> <4F69EE38.9000904@hartkopp.net> <20120322095730.GC426@vandijck-laurijssen.be> <4F6AF9B4.2020002@grandegger.com> <20120322103515.GE426@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:40027 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab2CVLBD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Mar 2012 07:01:03 -0400
In-Reply-To: <20120322103515.GE426@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, dev@sebastianhaas.info, linux-can@vger.kernel.org

On 03/22/2012 11:35 AM, Kurt Van Dijck wrote:
> Hey Wolfgang,
> 
> On Thu, Mar 22, 2012 at 11:06:44AM +0100, Wolfgang Grandegger wrote:
>> Hi Kurt,
>>
>> On 03/22/2012 10:57 AM, Kurt Van Dijck wrote:
>>> On Wed, Mar 21, 2012 at 04:05:28PM +0100, Oliver Hartkopp wrote:
>>>> On 21.03.2012 15:56, Wolfgang Grandegger wrote:
>>>>
>>>>>>>
>>>>>>> I think it's much more tricky to find a proper solution here.
>>>>>> As I mentioned before, I just use CAN_RAW with this. Actually, I just
>>>>>> ran a real CAN program that I wrote years ago. It still operates!
>>>>>
>>>>> Would you program still run if the payload is bigger than 8 bytes?
>>>>> I agree with Oliver.
>>>>
>>> The other side would have noticed at design time that it cannot
>>> send >8 bytes :-)
>>>
>>> Did I miss something here? Is there a reason why existing programs
>>> may or should not work on a CANFD bus? I wanted to incorporate
>>> CANFD functionality _without_ putting an alternative API next to the
>>> current one, so to be able to use existing binaries on a future
>>> CANFD bus _without_ recompile (and thus not using the extras
>>> possibilities for that program).
>>
>> I believe that 99% of the existing apps, including candump, do work with
>> a (hard-coded) maximum length of 8 bytes instead of a variable length.
> I agree with that (99% may even be a bit low :-) )
> 
> I did manage to let such applications still function as expected.
> 
> The remaining 1% may or may not work. In case of proper coded programs,
> I'm sure they work. In other cases, I'm not sure.
> Thus the question is:
> Does the remaining 1% that we don't know, justify an alternate approach?

Well, I do not yet know. I first would like to see the data sheet of a
CANFD controller to understand better the possible use cases. And
without real use case, we will not add any CANFD support to the mainline
kernel anyway. There is still some time to think and discuss.

> My initial patch mainly illustrates that this may be a reasonable question.
> 
> As ethernet user, on a socket level, I also do not care about low-level
> technology (100Mbit, 1GBit, UTP, ...).

But that's because we use higher-level protocols like UDP and TCP which
do not care about the hardware frame size.

Wolfgang.

