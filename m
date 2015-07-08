From: Tom Herbert <tom@herbertland.com>
Subject: Re: Fighting out-of-order reception with RPS?
Date: Wed, 8 Jul 2015 14:17:44 -0700
Message-ID: <CALx6S35OJHyr6iwfdtYW6P-ke2pmsmQ9BjO-D=qjgCHxwF7oew@mail.gmail.com>
References: <559D628C.5020100@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <559D628C.5020100@hartkopp.net>
Sender: netdev-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, sunil.kovvuri@gmail.com, jonathon.reinhart@gmail.com
List-Id: linux-can.vger.kernel.org

On Wed, Jul 8, 2015 at 10:49 AM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> I'm picking up the request 'Setting RPS affinities from network driver' from
> Sunil Kovvuri http://marc.info/?t=142424023500001&r=1&w=2 as I assume to have
> the same issue here.
>
> When receiving CAN frames from a specific CAN network interface (e.g. can0)
> the frames are sporadically out-of-order on SMP systems like my Core i7 laptop
> with 4 CPUs. This out-of-order reception kills reliable communication e.g. for
> CAN transport protocols.
>
> First approach was to set the smp_affinity for the USB adapter on irq 28 with:
>
>         echo 1 > /proc/irq/28/smp_affinity
>
> This worked in my case but it looks wrong to pin the USB host adapter to a
> single CPU and has to be done by hand depending on where the CAN interfaces
> are attached to the system.
>
> Next idea was to use RPS after reading Documentation/networking/scaling.txt
>
> As the only relevant flow identifiction is the number of the incoming CAN
> interface I added
>
>         skb_set_hash(skb, dev->ifindex, PKT_HASH_TYPE_L2);
>
> when creating CAN skbs with alloc_can_skb() in drivers/net/can/dev.c
>
> After enabling RPS for my four CPUs with
>
>         echo f > /sys/class/net/can0/queues/rx-0/rps_cpus
>
> I had no more out-of-order frames in my system :-)
>
> My two questions:
>
> 1. Is there any better solution to meet the described requirements?

I would suggest that you look into how there are OOO packets in the
first place. Even if the interrupts is allowed to happen on different
CPUs by sm_affinity, NAPI execution should be serialized for the
device so that OOO shouldn't happen. The result of your RPS setting
should be all packets go to the same queue, this shouldn't normally
affect the ordering. Looking at drivers/net/can there are apparently
several variants of the driver. Do you know which one you're running?

Tom

> 2. If not: How can enable this RPS solution by default for CAN interfaces?
>
> Best regards,
> Oliver
>
> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
