From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] j1939: Fix to softirq tasklet race condition when session
 is destroyed
Date: Wed, 14 Feb 2018 21:20:40 +0100
Message-ID: <7e53c927-5e7e-fc1e-fb79-672b5c7f8cfd@hartkopp.net>
References: <CAHChkrvWdUN6KYg9fbnfA2Mg3ie=PNOPuaSvEwqOzj7uG8xJ3A@mail.gmail.com>
 <20180214193202.GB12758@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:26586 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030477AbeBNUUn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 14 Feb 2018 15:20:43 -0500
In-Reply-To: <20180214193202.GB12758@airbook.vandijck-laurijssen.be>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Elenita Hinds <ecathinds@gmail.com>, linux-can@vger.kernel.org, o.rempel@pengutronix.de, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

Hi all,

On 02/14/2018 08:32 PM, Kurt Van Dijck wrote:
> On wo, 14 feb 2018 11:45:31 -0600, Elenita Hinds wrote:

>> I was seeing the kernel panic when receiving J1939 packets
>> promiscuously over both can0 and can1
>> (with multi-frame messages). The panic is due to the following line in
>> kernel/softirq.c (line 518):
>>
>> if (!test_and_clear_bit(TASKLET_STATE_SCHED,
>>          &t->state))
>>      BUG();  <=== panic here!!
>>
>> The issue seems similar to a previous patch in can/bcm.c
>> (see commit https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/commit/?id=a06393ed03167771246c4c43192d9c264bc48412),

Yeah - that was sticky ;-)

>> wherein a race condition can occur while the tasklets are being or
>> have terminated and the soft irq is checking the flag at the same
>> time. I mimicked the bcm fix and the panic went away.
>>
>> Below is a proposed fix. Please review.
>>
>>
>> Regards,
>> Elenita (Hinds)
>>
> 
> Your patch looks good. Well found!
> Acked-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

Just to keep you up-to-date with latest hrtimer developments:

Anna-Maria Gleixner integrated a rework of hrtimers so that we can use 
them in softirq context without the tasklet trampoline stuff.

The cleanup will also cause changes in net/can/bcm.c
https://lkml.org/lkml/2017/11/29/595

which finally removes all this stuff (and the fix above too!)

I assume the BCM changes will hit 4.17 as the 4.16 only contains the new 
infrastructure without changing the hrtimer users.

Best regards,
Oliver


> 
>> ----
>>
>> diff --git net/can/j1939/transport.c net/can/j1939/transport.c
>> index c15412dae565..9114ae7cdf72 100644
>> --- net/can/j1939/transport.c
>> +++ net/can/j1939/transport.c
>> @@ -121,10 +121,27 @@ static inline struct list_head *sessionq(bool extd)
>>   static inline void j1939_session_destroy(struct session *session)
>>   {
>>       kfree_skb(session->skb);
>> -    hrtimer_cancel(&session->rxtimer);
>> -    hrtimer_cancel(&session->txtimer);
>> -    tasklet_disable(&session->rxtask);
>> -    tasklet_disable(&session->txtask);
>> +
>> +        /* When terminating a session, a hrtimer or a tasklet might run.
>> +         * When the hrtimer triggers its associated tasklet and vice versa,
>> +         * we need to make sure they are not running or scheduled to run.
>> +         * Otherwise, a race condition can occur when the soft irq is
>> +         * handling the tasklet, resulting in kernel panic.
>> +         */
>> +    while (test_bit(TASKLET_STATE_SCHED, &session->rxtask.state) ||
>> +        test_bit(TASKLET_STATE_RUN, &session->rxtask.state) ||
>> +        hrtimer_active(&session->rxtimer)) {
>> +        hrtimer_cancel(&session->rxtimer);
>> +        tasklet_disable(&session->rxtask);
>> +    }
>> +
>> +    while (test_bit(TASKLET_STATE_SCHED, &session->txtask.state) ||
>> +        test_bit(TASKLET_STATE_RUN, &session->txtask.state) ||
>> +        hrtimer_active(&session->txtimer)) {
>> +        hrtimer_cancel(&session->txtimer);
>> +        tasklet_disable(&session->txtask);
>> +    }
>> +
>>       kfree(session);
>>   }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
