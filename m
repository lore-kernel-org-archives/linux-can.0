From: ajneu <ajneu1@gmail.com>
Subject: Re: socketcan and libnl3
Date: Tue, 14 Jun 2016 11:05:13 +0000 (UTC)
Message-ID: <loom.20160614T125640-218@post.gmane.org>
References: <5741873B.5040300@xor.wtf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:43818 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751140AbcFNLKV (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 14 Jun 2016 07:10:21 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1bCmEQ-0005hE-Gb
	for linux-can@vger.kernel.org; Tue, 14 Jun 2016 13:10:06 +0200
Received: from 195.50.142.51 ([195.50.142.51])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 14 Jun 2016 13:10:06 +0200
Received: from ajneu1 by 195.50.142.51 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 14 Jun 2016 13:10:06 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hubert Denkmair <xor <at> xor.wtf> writes:

> 
> Hi there,
> 
> is anyone here using libnl3 to configure socketcan links?
> 
> I'm running into trouble and I'm wondering whether it's just me or if the 
> rtnl_link_can_set_ctrlmode() and rtnl_link_can_set_restart_ms()
> calls should work at all?
> 
> So, setting bitrate and sample-point via libnl works for me,
> setting e.g. CAN_CTRLMODE_LISTENONLY does not.
> Setting modes via iproute2 works as expected.
> 
> My code is here:
> https://raw.githubusercontent.com/HubertD/cangaroo/master/canifconfig/main.c
> (will gladly boil that down to a few lines if anyone is interested...)
> 
> Greetings,
> 
> Hubert
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


Hi Hubert,

I've tried your canifconfig under Debian Stretch
with the following command:

    sudo ./canifconfig -i can0 -u -b 250000

and wow that sure is one destructive command!!
Command Line shows: "Killed"

And from then on issuing command

    sudo ifconfig

hangs. I cannot even stop it with Ctrl-C.

This may be a problem with libnl, or with the Debian Testing (Strech) that
I'm running!! Completely destructive!


/var/log/messages shows

Jun 14 08:50:58 deb456 kernel: [ 2824.823991] Call Trace:
Jun 14 08:50:58 deb456 kernel: [ 2824.824001]  [<ffffffff814d9a84>] ?
rtnl_newlink+0x214/0x8a0
Jun 14 08:50:58 deb456 kernel: [ 2824.824019]  [<ffffffff8133ca63>] ?
nla_parse+0x93/0xf0
Jun 14 08:50:58 deb456 kernel: [ 2824.824034]  [<ffffffff8133cb0d>] ?
nla_strlcpy+0x4d/0x60
Jun 14 08:50:58 deb456 kernel: [ 2824.824050]  [<ffffffff814d6ec4>] ?
rtnl_link_ops_get+0x34/0x50
Jun 14 08:50:58 deb456 kernel: [ 2824.824067]  [<ffffffff814d99e6>] ?
rtnl_newlink+0x176/0x8a0
Jun 14 08:50:58 deb456 kernel: [ 2824.824084]  [<ffffffff814d8491>] ?
rtnetlink_rcv_msg+0xe1/0x230
Jun 14 08:50:58 deb456 kernel: [ 2824.824102]  [<ffffffff814d83b0>] ?
rtnetlink_rcv+0x30/0x30
Jun 14 08:50:58 deb456 kernel: [ 2824.824119]  [<ffffffff814fb5d1>] ?
netlink_rcv_skb+0xa1/0xc0
Jun 14 08:50:58 deb456 kernel: [ 2824.824135]  [<ffffffff814d83a4>] ?
rtnetlink_rcv+0x24/0x30
Jun 14 08:50:58 deb456 kernel: [ 2824.824152]  [<ffffffff814fafa2>] ?
netlink_unicast+0x172/0x220
Jun 14 08:50:58 deb456 kernel: [ 2824.824170]  [<ffffffff814fb34e>] ?
netlink_sendmsg+0x2fe/0x3b0
Jun 14 08:50:58 deb456 kernel: [ 2824.824187]  [<ffffffff814ab410>] ?
sock_sendmsg+0x30/0x40
Jun 14 08:50:58 deb456 kernel: [ 2824.824203]  [<ffffffff814abe2e>] ?
___sys_sendmsg+0x28e/0x2a0
Jun 14 08:50:58 deb456 kernel: [ 2824.824221]  [<ffffffff811ca7df>] ?
alloc_pages_vma+0xbf/0x250
Jun 14 08:50:58 deb456 kernel: [ 2824.824239]  [<ffffffff811a6602>] ?
handle_mm_fault+0x1462/0x1d00
Jun 14 08:50:58 deb456 kernel: [ 2824.824256]  [<ffffffff814aa41b>] ?
move_addr_to_user+0xab/0xc0
Jun 14 08:50:58 deb456 kernel: [ 2824.824273]  [<ffffffff814ac701>] ?
__sys_sendmsg+0x51/0x90
Jun 14 08:50:58 deb456 kernel: [ 2824.824291]  [<ffffffff815c65b6>] ?
system_call_fast_compare_end+0xc/0x96


Regards,
ajneu

