From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Subject: Re: [bug, bisected] pfifo_fast causes packet reordering
Date: Wed, 21 Mar 2018 20:44:04 +0100
Message-ID: <983427eb-2e25-f201-c953-4cff22569deb@theobroma-systems.com>
References: <946dbe16-a2eb-eca8-8069-468859ccc78d@theobroma-systems.com>
 <CAA93jw5FSbvg8AZ=EmneW8juqd8LCgp=xUrSxYm2GBEucKkT3w@mail.gmail.com>
 <95844480-d020-9000-53ef-0da8b965ce6e@gmail.com>
 <3a959e50-8656-5d9c-97b9-227d733948f8@theobroma-systems.com>
 <5aeb54ba-2d96-4ab5-53c4-2d3691be7acc@gmail.com>
 <340a6c54-6031-5522-98f5-eafdd3a37a38@theobroma-systems.com>
 <00cc2d41-6861-9a9c-603f-ba8013b2e2ce@theobroma-systems.com>
 <4e33aae4-9e87-22b4-7f09-008183ea553a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4e33aae4-9e87-22b4-7f09-008183ea553a@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: John Fastabend <john.fastabend@gmail.com>, Dave Taht <dave.taht@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Martin Elshuber <martin.elshuber@theobroma-systems.com>
List-Id: linux-can.vger.kernel.org

On 21.03.18 19:43, John Fastabend wrote:
> Thats my theory at least. Are you able to test a patch if I generate
> one to fix this?

Yes, no problem.

I just tested with the flag change you suggested (see below, I had to 
keep TCQ_F_CPUSTATS to prevent a crash) and I have NOT seen OOO so far.

Thanks,
Jakob


diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 190570f21b20..51b68ef4977b 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -792,7 +792,7 @@ struct Qdisc_ops pfifo_fast_ops __read_mostly = {
         .dump           =       pfifo_fast_dump,
         .change_tx_queue_len =  pfifo_fast_change_tx_queue_len,
         .owner          =       THIS_MODULE,
-       .static_flags   =       TCQ_F_NOLOCK | TCQ_F_CPUSTATS,
+       .static_flags   =       TCQ_F_CPUSTATS,
  };
  EXPORT_SYMBOL(pfifo_fast_ops);
