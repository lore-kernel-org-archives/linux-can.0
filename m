From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: general protection fault in can_rx_register
Date: Tue, 21 Jan 2020 20:22:48 +0100
Message-ID: <20200121192248.GC13462@x1.vandijck-laurijssen.be>
References: <00000000000030dddb059c562a3f@google.com>
 <55ad363b-1723-28aa-78b1-8aba5565247e@hartkopp.net>
 <20200120091146.GD11138@x1.vandijck-laurijssen.be>
 <CACT4Y+a+GusEA1Gs+z67uWjtwBRp_s7P4Wd_SMmgpCREnDu3kg@mail.gmail.com>
 <8332ec7f-2235-fdf6-9bda-71f789c57b37@hartkopp.net>
 <2a676c0e-20f2-61b5-c72b-f51947bafc7d@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b03.edpnet.be ([212.71.1.220]:46221 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgAUTWx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 21 Jan 2020 14:22:53 -0500
Content-Disposition: inline
In-Reply-To: <2a676c0e-20f2-61b5-c72b-f51947bafc7d@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Dmitry Vyukov <dvyukov@google.com>, Marc Kleine-Budde <mkl@pengutronix.de>, o.rempel@pengutronix.de, syzbot <syzbot+c3ea30e1e2485573f953@syzkaller.appspotmail.com>, linux-can@vger.kernel.org

Oliver,

I decreased the CC list a bit, as I'm more like thinking in the wild
now:

Since the problems happens only rarely, and with vxcan, I assume not
vcan, I started to think to locking issues.

1. What surprised me a bit is 'rtnl_dereference()' calls, without
rcu_read_lock() around it? is that supposed to be ok?

2. is it possible to call vxcan_dellink in between the 2
rcu_assign_pointer() calls in vxcan_newlink(), resulting in a dead end,
i.e. one end is referenced, but already deleted?
I'd expect a kind of rcu_write_lock around the cross-linking at least.

It still puzzles me how this bisected to CAN_REQUIRED_SIZE() macro
commit.

Kurt

On ma, 20 jan 2020 23:35:16 +0100, Oliver Hartkopp wrote:
> 
> Answering myself ...
> 
> On 20/01/2020 23.02, Oliver Hartkopp wrote:
> 
> >
> >Added some code to check whether dev->ml_priv is NULL:
> >
> >~/linux$ git diff
> >diff --git a/net/can/af_can.c b/net/can/af_can.c
> >index 128d37a4c2e0..6fb4ae4c359e 100644
> >--- a/net/can/af_can.c
> >+++ b/net/can/af_can.c
> >@@ -463,6 +463,10 @@ int can_rx_register(struct net *net, struct
> >net_device *dev, canid_t can_id,
> >         spin_lock_bh(&net->can.rcvlists_lock);
> >
> >         dev_rcv_lists = can_dev_rcv_lists_find(net, dev);
> >+       if (!dev_rcv_lists) {
> >+               pr_err("dev_rcv_lists == NULL! %p\n", dev);
> >+               goto out_unlock;
> >+       }
> >         rcv_list = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
> >
> >         rcv->can_id = can_id;
> >@@ -479,6 +483,7 @@ int can_rx_register(struct net *net, struct net_device
> >*dev, canid_t can_id,
> >         rcv_lists_stats->rcv_entries++;
> >         rcv_lists_stats->rcv_entries_max =
> >max(rcv_lists_stats->rcv_entries_max,
> >
> >rcv_lists_stats->rcv_entries);
> >+out_unlock:
> >         spin_unlock_bh(&net->can.rcvlists_lock);
> >
> >         return err;
> >
> >And the output (after some time) is:
> >
> >[  758.505841] netlink: 'crash': attribute type 1 has an invalid length.
> >[  758.508045] bond7148: (slave vxcan1): The slave device specified does
> >not support setting the MAC address
> >[  758.508057] bond7148: (slave vxcan1): Error -22 calling dev_set_mtu
> >[  758.532025] bond10413: (slave vxcan1): The slave device specified does
> >not support setting the MAC address
> >[  758.532043] bond10413: (slave vxcan1): Error -22 calling dev_set_mtu
> >[  758.532254] dev_rcv_lists == NULL! 000000006b9d257f
> >[  758.547392] netlink: 'crash': attribute type 1 has an invalid length.
> >[  758.549310] bond7145: (slave vxcan1): The slave device specified does
> >not support setting the MAC address
> >[  758.549313] bond7145: (slave vxcan1): Error -22 calling dev_set_mtu
> >[  758.550464] netlink: 'crash': attribute type 1 has an invalid length.
> >[  758.552301] bond7146: (slave vxcan1): The slave device specified does
> >not support setting the MAC address
> >
> >So we can see that we get a ml_priv pointer which is NULL which should not
> >be possible due to this:
> >
> >https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/can/dev.c#n743
> 
> This reference doesn't point to the right code as vxcan has its own handling
> do assign ml_priv in vxcan.c .
> 
> >Btw. the variable 'size' is set two times at the top of alloc_candev_mqs()
> >depending on echo_skb_max. This looks wrong.
> 
> No. It looks right as I did not get behind the ALIGN() macro at first sight.
> 
> But it is still open why dev->ml_priv is not set correctly in vxcan.c as all
> the settings for .priv_size and in vxcan_setup look fine.
> 
> Best regards,
> Oliver
