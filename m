From: Patrick McHardy <kaber@trash.net>
Subject: Re: [can:master 239/293] net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.c:231:
 warning: passing argument 4 of 'NF_HOOK_THRESH' discards qualifiers from
 pointer target type
Date: Tue, 11 Sep 2012 10:44:02 +0200 (MEST)
Message-ID: <Pine.GSO.4.63.1209111042560.2448@stinky-local.trash.net>
References: <20120906231958.GB7382@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-can-owner@vger.kernel.org>
Received: from stinky.trash.net ([213.144.137.162]:62215 "EHLO
	stinky.trash.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579Ab2IKIwd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 11 Sep 2012 04:52:33 -0400
In-Reply-To: <20120906231958.GB7382@localhost>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: kernel-janitors@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>, linux-can@vger.kernel.org

On Fri, 7 Sep 2012, Fengguang Wu wrote:

> Hi Patrick,
>
> FYI, there are new compile warnings show up in
>
> tree:   git://gitorious.org/linux-can/linux-can-next master
> head:   bbe660a7ddf32dfe80753c6722e141bf7e4bf5d8
> commit: 4cdd34084d539c758d00c5dc7bf95db2e4f2bc70 [239/293] netfilter: nf_conntrack_ipv6: improve fragmentation handling
> config: avr32-atngw100_defconfig (attached as .config)
>
> All error/warnings:
>
> net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.c: In function '__ipv6_conntrack_in':
> net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.c:231: warning: passing argument 4 of 'NF_HOOK_THRESH' discards qualifiers from pointer target type
> net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.c:231: warning: passing argument 5 of 'NF_HOOK_THRESH' discards qualifiers from pointer target type

Thanks, I'll look into this.
