From: Patrick McHardy <kaber@trash.net>
Subject: Re: [can:master 239/293] net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.c:231:
 warning: passing argument 4 of 'NF_HOOK_THRESH' discards qualifiers from
 pointer target type
Date: Thu, 20 Sep 2012 09:14:02 +0200 (MEST)
Message-ID: <Pine.GSO.4.63.1209200902120.8409@stinky-local.trash.net>
References: <20120906231958.GB7382@localhost> <Pine.GSO.4.63.1209111042560.2448@stinky-local.trash.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-can-owner@vger.kernel.org>
Received: from stinky.trash.net ([213.144.137.162]:57429 "EHLO
	stinky.trash.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab2ITHOD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 20 Sep 2012 03:14:03 -0400
In-Reply-To: <Pine.GSO.4.63.1209111042560.2448@stinky-local.trash.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: kernel-janitors@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>, linux-can@vger.kernel.org

On Tue, 11 Sep 2012, Patrick McHardy wrote:

> On Fri, 7 Sep 2012, Fengguang Wu wrote:
>
>> Hi Patrick,
>> 
>> FYI, there are new compile warnings show up in
>> 
>> tree:   git://gitorious.org/linux-can/linux-can-next master
>> head:   bbe660a7ddf32dfe80753c6722e141bf7e4bf5d8
>> commit: 4cdd34084d539c758d00c5dc7bf95db2e4f2bc70 [239/293] netfilter: 
>> nf_conntrack_ipv6: improve fragmentation handling
>> config: avr32-atngw100_defconfig (attached as .config)
>> 
>> All error/warnings:
>> 
>> net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.c: In function 
>> '__ipv6_conntrack_in':
>> net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.c:231: warning: passing 
>> argument 4 of 'NF_HOOK_THRESH' discards qualifiers from pointer target type
>> net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.c:231: warning: passing 
>> argument 5 of 'NF_HOOK_THRESH' discards qualifiers from pointer target type
>
> Thanks, I'll look into this.

It seems the cure for this is worse than the problem. The code
currently casts the const struct net_device pointer to non-const
for the NF_HOOK_THRES call. To avoid the cast we'd have to change
all netfilter hooks to take a non-const pointer. The alternative
would be to change the NF_HOOK functions to also take a const struct
net_device pointer, but that would require the same cast to non-const
for nf_queue, which uses dev_hold() and dev_put(), so this would
effectively just move the warning to a different place.

nf_queue is a quite special case, normally netfilter hooks shouln't
be changing anything on the net_device, so I don't want to unconstify
the arguments.

The compiler actually shouldn't warn about this since its an explicit
cast. I know some older versions of gcc did this, but there's no warning 
with current versions of gcc and the same casts are already present
in other parts of IPv6 conntrack.
