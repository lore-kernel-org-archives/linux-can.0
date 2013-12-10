From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: sja1000 interrupt problem
Date: Tue, 10 Dec 2013 08:49:40 +0100
Message-ID: <333c0fd4238558062478212eb0704b04@grandegger.com>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com>
 <52831FC7.3040509@hartkopp.net>
 <f323c29b9730c877729322453b9e4ec9@grandegger.com>
 <201311131008.55018.pisa@cmp.felk.cvut.cz> <5287E6B2.8020709@hartkopp.net>
 <85256584a266750b1330cfae8bebd55c@grandegger.com>
 <5288D236.403@hartkopp.net> <5288FB91.9050703@grandegger.com>
 <52892B21.9000501@grandegger.com>
 <CANGgnMa1NXWCtRCWEp3O+c614OyxD=E9mpr55FZNtLkoDrrxMw@mail.gmail.com>
 <CANGgnMa=Kri=ede28bB1fdB9YVsDMMwQpwQTUpheQdqwWaUnVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from uranus.manitu.net ([217.11.48.8]:39921 "EHLO uranus.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750921Ab3LJHtm (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 10 Dec 2013 02:49:42 -0500
In-Reply-To: <CANGgnMa=Kri=ede28bB1fdB9YVsDMMwQpwQTUpheQdqwWaUnVg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Schuh <austin@peloton-tech.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org

Hi Austin,



On Mon, 9 Dec 2013 13:54:24 -0800, Austin Schuh <austin@peloton-tech.com>

wrote:

> Ok.  I succeeded in getting a trace from when the IRQ gets disabled.

> It took ~2.5 days to trigger it with tracing enabled, and it takes

> much less time (typically under a day) with tracing disabled.  The

> trace is at http://98.207.84.11/sja1000_crash.trace.bz2  It is 42 MB

> compressed and 1 GB uncompressed.



Could you please tell use what trigger you used (how and when did you

stop the trace) and what the test scenario was (TX on CAN0, RX on CAN1,

etc.).



Wolfgang.



> Austin

> 

> On Mon, Nov 18, 2013 at 9:08 AM, Austin Schuh <austin@peloton-tech.com>

> wrote:

>> I'm off on a buisness trip right now, and when I get back either late

>> this week, or early next week, I'll be able to get back to working on

>> debugging this.  Thanks everyone for all your help so far!

>>

>> Austin

>>

>> On Sun, Nov 17, 2013 at 12:46 PM, Wolfgang Grandegger

>> <wg@grandegger.com> wrote:

>>> On 11/17/2013 06:23 PM, Wolfgang Grandegger wrote:

>>>> On 11/17/2013 03:27 PM, Oliver Hartkopp wrote:

>>>>>

>>>>>

>>>>> On 17.11.2013 09:18, Wolfgang Grandegger wrote:

>>>>>>

>>>>>> On Sat, 16 Nov 2013 22:42:10 +0100, Oliver Hartkopp

>>>>>

>>>>>

>>>>>>> Btw. I would try two more things with the sja1000.c driver:

>>>>>>

>>>>>>>

>>>>>>

>>>>>>> 1. Print the corresponding CAN device name and the point in the

code

>>>>>>

>>>>>> before

>>>>>>

>>>>>>> returning IRQ_NONE to catch the problematic return site.

>>>>>>

>>>>>>>

>>>>>>

>>>>>>> 2. Replace all IRQ_NONE with IRQ_HANDLED for a test ...

>>>>>>

>>>>>>>

>>>>>>

>>>>>>> Any other ideas?

>>>>>>

>>>>>>

>>>>>>

>>>>>> A function trace is still the first thing to take. Be aware that

the

>>>>>>

>>>>>> tasks are running on more than one CPU. It's just to establish a

good

>>>>>>

>>>>>> trigger.

>>>>>>

>>>>>

>>>>> Yes. But so far the function trace only showed the fact of

>>>>> simultaneous irq

>>>>> treads for the two CAN interfaces - what we were expecting :-)

>>>>

>>>> Yes, because the trigger was not good so far.

>>>>

>>>>> IMO it's interesting to get the concrete return site from where the

>>>>> IRQ_NONE

>>>>> is returned. Maybe one of the other interfaces / bits in PITA are

>>>>> enabled

>>>>> which we did not see so far.

>>>>

>>>> The problem is that the IRQs are shared, also with the ATA disk.

There

>>>> it's normal to see unhandled interrupts. My idea was to trigger a

>>>> "tracing_off" after 10 IRQ_NONE in sequence.

>>>

>>> See my patch below. @Austin, you may want to give it a try.

>>>

>>> Wolfgang.

>>>

>>> From eac2b63d114bc83544f806a549fe7339d54c031f Mon Sep 17 00:00:00 2001

>>> From: Wolfgang Grandegger <wg@grandegger.com>

>>> Date: Sun, 17 Nov 2013 21:39:05 +0100

>>> Subject: [PATCH] sja1000: debugging code to inspect too much

unhandeled

>>> irq

>>>

>>> If more than "IRQ_NONE_COUNT_MAX" unhandled interrupts are detected

>>> in sequence, ftracing will be stopped.

>>> ---

>>>  drivers/net/can/sja1000/sja1000.c |   34

>>>  +++++++++++++++++++++++++++-------

>>>  1 file changed, 27 insertions(+), 7 deletions(-)

>>>

>>> diff --git a/drivers/net/can/sja1000/sja1000.c

>>> b/drivers/net/can/sja1000/sja1000.c

>>> index 7164a99..80e8d84 100644

>>> --- a/drivers/net/can/sja1000/sja1000.c

>>> +++ b/drivers/net/can/sja1000/sja1000.c

>>> @@ -486,6 +486,9 @@ static int sja1000_err(struct net_device *dev,

>>> uint8_t isrc, uint8_t status)

>>>         return 0;

>>>  }

>>>

>>> +#define IRQ_NONE_COUNT_MAX 5

>>> +static int irq_none_count;

>>> +

>>>  irqreturn_t sja1000_interrupt(int irq, void *dev_id)

>>>  {

>>>         struct net_device *dev = (struct net_device *)dev_id;

>>> @@ -496,7 +499,7 @@ irqreturn_t sja1000_interrupt(int irq, void

*dev_id)

>>>

>>>         /* Shared interrupts and IRQ off? */

>>>         if (priv->read_reg(priv, SJA1000_IER) == IRQ_OFF)

>>> -               return IRQ_NONE;

>>> +               goto out;

>>>

>>>         if (priv->pre_irq)

>>>                 priv->pre_irq(priv);

>>> @@ -506,8 +509,11 @@ irqreturn_t sja1000_interrupt(int irq, void

>>> *dev_id)

>>>                 n++;

>>>                 status = priv->read_reg(priv, SJA1000_SR);

>>>                 /* check for absent controller due to hw unplug */

>>> -               if (status == 0xFF && sja1000_is_absent(priv))

>>> -                       return IRQ_NONE;

>>> +               if (status == 0xFF && sja1000_is_absent(priv)) {

>>> +                       netdev_warn(dev, "controller lost (n=%d)\n",

n);

>>> +                       n = 0;

>>> +                       goto out;

>>> +               }

>>>

>>>                 if (isrc & IRQ_WUI)

>>>                         netdev_warn(dev, "wakeup interrupt\n");

>>> @@ -534,8 +540,11 @@ irqreturn_t sja1000_interrupt(int irq, void

>>> *dev_id)

>>>                                 sja1000_rx(dev);

>>>                                 status = priv->read_reg(priv,

>>>                                 SJA1000_SR);

>>>                                 /* check for absent controller */

>>> -                               if (status == 0xFF &&

>>> sja1000_is_absent(priv))

>>> -                                       return IRQ_NONE;

>>> +                               if (status == 0xFF &&

>>> sja1000_is_absent(priv)) {

>>> +                                       netdev_warn(dev, "controller

>>> lost (n=%d)\n", n);

>>> +                                       n = 0;

>>> +                                       goto out;

>>> +                               }

>>>                         }

>>>                 }

>>>                 if (isrc & (IRQ_DOI | IRQ_EI | IRQ_BEI | IRQ_EPI |

>>>                 IRQ_ALI)) {

>>> @@ -547,11 +556,22 @@ irqreturn_t sja1000_interrupt(int irq, void

>>> *dev_id)

>>>

>>>         if (priv->post_irq)

>>>                 priv->post_irq(priv);

>>> -

>>>         if (n >= SJA1000_MAX_IRQ)

>>>                 netdev_dbg(dev, "%d messages handled in ISR", n);

>>>

>>> -       return (n) ? IRQ_HANDLED : IRQ_NONE;

>>> +out:

>>> +       if (n) {

>>> +               irq_none_count = 0;

>>> +               return IRQ_HANDLED;

>>> +       } else {

>>> +               irq_none_count++;

>>> +               if (irq_none_count >= IRQ_NONE_COUNT_MAX) {

>>> +                       netdev_info(dev, "tracing stopped after %d

>>> unhandled irqs)\n",

>>> +                                   irq_none_count);

>>> +                       tracing_off();

>>> +               }

>>> +               return IRQ_NONE;

>>> +       }

>>>  }

>>>  EXPORT_SYMBOL_GPL(sja1000_interrupt);

>>>

>>> --

>>> 1.7.9.5

>>>

>>>

>>>

>>>
