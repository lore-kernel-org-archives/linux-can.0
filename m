From: Andre Naujoks <nautsch2@gmail.com>
Subject: Re: [PATCH] can: bcm: check timer values before ktime conversion
Date: Sun, 13 Jan 2019 11:45:39 +0100
Message-ID: <4c7dc087-b555-701f-30e0-4bc2944c1fed@gmail.com>
References: <20190112215726.2622-1-socketcan@hartkopp.net>
 <01976e61-2ba1-09bf-94a1-b0e879c9a07b@gmail.com>
 <1db63586-5ce6-7ec5-f076-ec8d57dffe7d@hartkopp.net>
 <f4e958af-9805-252a-3b1c-269164beadfa@gmail.com>
 <6f1db908-f8ce-3ef1-6e77-072c9890335d@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <6f1db908-f8ce-3ef1-6e77-072c9890335d@hartkopp.net>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>, davem@davemloft.net, netdev@vger.kernel.org
Cc: linux-can@vger.kernel.org, lifeasageek@gmail.com, threeearcat@gmail.com, syzkaller@googlegroups.com, Kyungtae Kim <kt0755@gmail.com>, linux-stable <stable@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

On 1/13/19 9:18 AM, Oliver Hartkopp wrote:
> Hi Andre,
> 
> On 1/12/19 11:45 PM, Andre Naujoks wrote:
>> I really don't know. That's why I'd be hesitant to restrict this. Maybe
>> limit it to something really out of the ordinary, like a year?
> 
> :-)
> 
> The intention was to send and monitor cyclic CAN frames within a range
> of 5 to 5000ms. Even if you want to ping a satellite over CAN in the
> deep space network ... I would like to introduce some kind of
> restriction after all.

Hi Oliver,

The intended use-case is what I am using the BCM for. The 15 minutes
just caught my eye as very close to those 5 seconds in the big scheme of
things.

The restriction is then there to do what? The kernel, I think, has no
problem with these kinds of timeouts. The only justification I see is to
avoid accidentally setting high values as timeouts? To catch typos?

> 
> The question is whether e.g. low power use-cases would require some very
> seldom pings to be monitored.
> 
>> I am not sure that for example one hour would be out of the question for
>> some edge cases. Maybe someone wants to do a heartbeat for his/her
>> system with a very low priority. This would mean a TX_SETUP with a
>> timeout of an hour and a RX_SETUP with a timeout of a bit more.
>>
>> If the system allow timeouts in those ranges, I think it should be
>> allowed. If someone wants to wait a year for a CAN frame, however
>> unlikely that might be, why not?
> 
> That's scary. IMO you would go for another technical approach if you
> want to communicate over this period of time.

Definitely!

> 
> Anyway if it's ok for you I would limit the timer to 400 days to have a
> least a limitation when sending the V2 patch after getting feedback from
> Kyungtae Kim.
> 

400 days seems way less likely to occur than 15 minutes. I give you that
:-). I wouldn't want to to be the one responsible for a deep space probe
not to wake up, because someone else thought it was a good idea to
tunnel CAN over interplanetary IP. If there needs to be a restriction,
400 days would be reasonable in my eyes. Still arbitrary though.

> Thanks for stepping in!

Don't mention it :-)

Regards
  Andre

> 
> Best,
> Oliver>
>>
>> Andre.
>>
>> On 1/12/19 11:30 PM, Oliver Hartkopp wrote:
>>> Hi Andre,
>>>
>>> just wondered whether it makes sense to limit this value for sending
>>> cyclic messages or for detecting a timeout on reception.
>>>
>>> 4.294.967.295 seconds would be ~136 years - this makes no sense to me
>>> and I would assume someone applied some (unintended?) stuff into the
>>> timeval.
>>>
>>> Don't you think?
>>>
>>> Best,
>>> Oliver
>>>
>>> On 1/12/19 11:16 PM, Andre Naujoks wrote:
>>>> Hi.
>>>>
>>>> The 15 minute limit seems arbitrary to me. I'd be surprised if an
>>>> (R|T)X_SETUP failed because of a timeout greater than this. Are there
>>>> any problems with allowing larger timeouts? If not, I do not see a
>>>> reason to restrict this.
>>>>
>>>> Regards
>>>>     Andre
>>>>
>>>> On 1/12/19 10:57 PM, Oliver Hartkopp wrote:
>>>>> Kyungtae Kim detected a potential integer overflow in
>>>>> bcm_[rx|tx]_setup() when
>>>>> the conversion into ktime multiplies the given value with
>>>>> NSEC_PER_USEC (1000).
>>>>>
>>>>> Reference: https://marc.info/?l=linux-can&m=154732118819828&w=2
>>>>>
>>>>> Add a check for the given tv_usec, so that the value stays below one
>>>>> second.
>>>>> Additionally limit the tv_sec value to a reasonable value for CAN
>>>>> related
>>>>> use-cases of 15 minutes.
>>>>>
>>>>> Reported-by: Kyungtae Kim <kt0755@gmail.com>
>>>>> Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>>>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>>>> Cc: linux-stable <stable@vger.kernel.org> # >= 2.6.26
>>>>> ---
>>>>>    net/can/bcm.c | 23 +++++++++++++++++++++++
>>>>>    1 file changed, 23 insertions(+)
>>>>>
>>>>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>>>>> index 0af8f0db892a..ff3799be077b 100644
>>>>> --- a/net/can/bcm.c
>>>>> +++ b/net/can/bcm.c
>>>>> @@ -67,6 +67,9 @@
>>>>>     */
>>>>>    #define MAX_NFRAMES 256
>>>>>    +/* limit timers to 15 minutes for sending/timeouts */
>>>>> +#define BCM_TIMER_SEC_MAX (15*60)
>>>>> +
>>>>>    /* use of last_frames[index].flags */
>>>>>    #define RX_RECV    0x40 /* received data for this element */
>>>>>    #define RX_THR     0x80 /* element not been sent due to throttle
>>>>> feature */
>>>>> @@ -140,6 +143,18 @@ static inline ktime_t
>>>>> bcm_timeval_to_ktime(struct bcm_timeval tv)
>>>>>        return ktime_set(tv.tv_sec, tv.tv_usec * NSEC_PER_USEC);
>>>>>    }
>>>>>    +/* check limitations for timeval provided by user */
>>>>> +static int bcm_is_invalid_tv(struct bcm_msg_head *msg_head)
>>>>> +{
>>>>> +    if ((msg_head->ival1.tv_sec > BCM_TIMER_SEC_MAX) ||
>>>>> +        (msg_head->ival1.tv_usec >= USEC_PER_SEC) ||
>>>>> +        (msg_head->ival2.tv_sec > BCM_TIMER_SEC_MAX) ||
>>>>> +        (msg_head->ival2.tv_usec >= USEC_PER_SEC))
>>>>> +        return 1;
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>>    #define CFSIZ(flags) ((flags & CAN_FD_FRAME) ? CANFD_MTU : CAN_MTU)
>>>>>    #define OPSIZ sizeof(struct bcm_op)
>>>>>    #define MHSIZ sizeof(struct bcm_msg_head)
>>>>> @@ -873,6 +888,10 @@ static int bcm_tx_setup(struct bcm_msg_head
>>>>> *msg_head, struct msghdr *msg,
>>>>>        if (msg_head->nframes < 1 || msg_head->nframes > MAX_NFRAMES)
>>>>>            return -EINVAL;
>>>>>    +    /* check timeval limitations */
>>>>> +    if ((msg_head->flags & SETTIMER) && bcm_is_invalid_tv(msg_head))
>>>>> +        return -EINVAL;
>>>>> +
>>>>>        /* check the given can_id */
>>>>>        op = bcm_find_op(&bo->tx_ops, msg_head, ifindex);
>>>>>        if (op) {
>>>>> @@ -1053,6 +1072,10 @@ static int bcm_rx_setup(struct bcm_msg_head
>>>>> *msg_head, struct msghdr *msg,
>>>>>             (!(msg_head->can_id & CAN_RTR_FLAG))))
>>>>>            return -EINVAL;
>>>>>    +    /* check timeval limitations */
>>>>> +    if ((msg_head->flags & SETTIMER) && bcm_is_invalid_tv(msg_head))
>>>>> +        return -EINVAL;
>>>>> +
>>>>>        /* check the given can_id */
>>>>>        op = bcm_find_op(&bo->rx_ops, msg_head, ifindex);
>>>>>        if (op) {
>>>>>
>>>>
>>
