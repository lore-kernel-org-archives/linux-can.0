From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH 1/2] net: sch_generic: add flag IFF_FIFO_QUEUE to use pfifo_fast as default scheduler
Date: Tue, 02 Apr 2019 19:22:24 +0200
Message-ID: <87mul8nwz3.fsf@toke.dk>
References: <20190327165632.10711-1-mkl@pengutronix.de> <20190327165632.10711-2-mkl@pengutronix.de> <CAM_iQpWVOeJ7JNnFyrnvVVimfO=nn4z2FsCGHcDxgeDYQKoYgQ@mail.gmail.com> <7a25d800-aed1-bec6-0ff8-38c06c3b8fb5@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <7a25d800-aed1-bec6-0ff8-38c06c3b8fb5@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Linux Kernel Network Developers <netdev@vger.kernel.org>, Dave Taht <dave.taht@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>, kernel@pengutronix.de, linux-can@vger.kernel.org, David Miller <davem@davemloft.net>
List-Id: linux-can.vger.kernel.org

Marc Kleine-Budde <mkl@pengutronix.de> writes:

> On 3/27/19 6:14 PM, Cong Wang wrote:
>> On Wed, Mar 27, 2019 at 9:56 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>>>
>>> There is networking hardware that isn't based on Ethernet for layers 1 and 2.
>>>
>>> For example CAN.
>>>
>>> CAN is a multi-master serial bus standard for connecting Electronic Control
>>> Units [ECUs] also known as nodes. A frame on the CAN bus carries up to 8 bytes
>>> of payload. Frame corruption is detected by a CRC. However frame loss due to
>>> corruption is possible, but a quite unusual phenomenon.
>>>
>>> While fq_codel works great for TCP/IP, it doesn't for CAN. There are a lot of
>>> legacy protocols on top of CAN, which are not build with flow control or high
>>> CAN frame drop rates in mind.
>>>
>>> When using fq_codel, as soon as the queue reaches a certain delay based length,
>>> skbs from the head of the queue are silently dropped. Silently meaning that the
>>> user space using a send() or similar syscall doesn't get an error. However
>>> TCP's flow control algorithm will detect dropped packages and adjust the
>>> bandwidth accordingly.
>>>
>>> When using fq_codel and sending raw frames over CAN, which is the common use
>>> case, the user space thinks the package has been sent without problems, because
>>> send() returned without an error. pfifo_fast will drop skbs, if the queue
>>> length exceeds the maximum. But with this scheduler the skbs at the tail are
>>> dropped, an error (-ENOBUFS) is propagated to user space. So that the user
>>> space can slow down the package generation.
>>>
>>> On distributions, where fq_codel is made default via CONFIG_DEFAULT_NET_SCH
>>> during compile time, or set default during runtime with sysctl
>>> net.core.default_qdisc (see [1]), we get a bad user experience. In my test case
>>> with pfifo_fast, I can transfer thousands of million CAN frames without a frame
>>> drop. On the other hand with fq_codel there is more then one lost CAN frame per
>>> thousand frames.
>>>
>>> As pointed out fq_codel is not suited for CAN hardware, so this patch
>>> introduces a new netdev_priv_flag called "IFF_FIFO_QUEUE" (in contrast to the
>>> existing "IFF_NO_QUEUE").
>>>
>>> During transition of a netdev from down to up state the default queuing
>>> discipline is attached by attach_default_qdiscs() with the help of
>>> attach_one_default_qdisc(). This patch modifies attach_one_default_qdisc() to
>>> attach the pfifo_fast (pfifo_fast_ops) if the "IFF_FIFO_QUEUE" flag is set.
>> 
>> I wonder if we just need to allow arbitrary default qdisc per netdevice
>> while you are on it. A private flag is simply a boolean, perhaps in the
>> future other type of devices wants other default qdiscs, so that could
>> make it more flexible.
>
> From my point of view there is networking hardware that use protocols
> that work with (i.e. benefit from) fq_codel (hash flow/queue/head drop).
>
> The silent head drop is the most prominent reason why it doesn't work on
> CAN. I haven't dug deep enough into the code to see if skb->hash is used
> or what the flow dissector will do on CAN frames. So reordering of CAN
> frames (if something else than skb->priority is used) might be a
> problem, too.
>
> From my point of view, if your networking hardware and the protocols on
> top don't like re-ordering or silent head drop, than pfifo_fast is
> probably a good default choice.
>
> I discussed the problem a bit at netdev 0x13 and one point someone
> mentioned is that if there is a generic set this qdisc function people
> might start to add this to network drivers to "optimize" them for
> their special workflow or test case.

I think I was one of the people you spoke with about this. I agree that
the flag approach makes sense, since I view the requirements of the CAN
protocol as very specifically being met by a FIFO queue.

And yeah I do think we should push back on every device type defining
each own arbitrary qdisc default; having the two very specific
exceptions "no queue" and "FIFO queue" to the general qdisc default
setting makes it explicit that this is for special cases only, and that
any other optimisation of the qdisc configuration should be done in
userspace.

-Toke
