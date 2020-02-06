From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [BUG] pfifo_fast may cause out-of-order CAN frame transmission
Date: Thu, 6 Feb 2020 18:06:44 +0100
Message-ID: <5e9b81f5-018d-0680-2d0b-55ff3bfb978f@hartkopp.net>
References: <661cc33a-5f65-2769-cc1a-65791cb4b131@pengutronix.de>
 <7717e4470f6881bbc92645c72ad7f6ec71360796.camel@redhat.com>
 <779d3346-0344-9064-15d5-4d565647a556@pengutronix.de>
 <1b70f56b72943bf5dfd2813565373e8c1b639c31.camel@redhat.com>
 <53ce1ab4-3346-2367-8aa5-85a89f6897ec@pengutronix.de>
 <57a2352dfc442ea2aa9cd653f8e09db277bf67c7.camel@redhat.com>
 <b012e914-fc1a-5a45-f28b-e9d4d4dfc0fe@pengutronix.de>
 <ef6b4e00-75fe-70f6-6b57-7bdbaa1aac33@pengutronix.de>
 <13e8950e8537e549f6afb6e254ec75a7462ce648.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <13e8950e8537e549f6afb6e254ec75a7462ce648.camel@redhat.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Paolo Abeni <pabeni@redhat.com>, Ahmad Fatoum <a.fatoum@pengutronix.de>, netdev@vger.kernel.org, linux-can@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
List-Id: linux-can.vger.kernel.org

Hi Paolo,

On 06/02/2020 14.21, Paolo Abeni wrote:
> On Tue, 2020-02-04 at 17:25 +0100, Ahmad Fatoum wrote:
>> Hello Paolo,
>>
>> On 1/20/20 5:06 PM, Ahmad Fatoum wrote:
>>> Hello Paolo,
>>>
>>> On 1/16/20 1:40 PM, Paolo Abeni wrote:
>>>> I'm sorry for this trial & error experience. I tried to reproduce the
>>>> issue on top of the vcan virtual device, but it looks like it requires
>>>> the timing imposed by a real device, and it's missing here (TL;DR: I
>>>> can't reproduce the issue locally).
>>>
>>> No worries. I don't mind testing.
>>>
>>>> Code wise, the 2nd patch closed a possible race, but it dumbly re-
>>>> opened the one addressed by the first attempt - the 'empty' field must
>>>> be cleared prior to the trylock operation, or we may end-up with such
>>>> field set and the queue not empty.
>>>>
>>>> So, could you please try the following code?
>>>
>>> Unfortunately, I still see observe reodering.
>>
>> Any news?
> 
> I'm unable to find any better solution than a revert. That will cost
> some small performace regression, so I'm a bit reluctant to go ahead.
> If there is agreement I can post the revert.

Is it possible that the current pfifo_fast handling has some additional 
problems:

https://marc.info/?l=linux-netdev&m=158092393613669&w=2

Or is this unrelated?

Best,
Oliver
