From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 send causes call trace dump
Date: Tue, 8 Dec 2015 11:05:15 +0100
Message-ID: <20151208100515.GD32721@airbook.vandijck-laurijssen.be>
References: <CAEE8DsL73FVDMdVCVC0Z=X5KKiaE=KnTwPNp3gJS37nd7oq9dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b01.edpnet.be ([212.71.1.221]:41281 "EHLO
	relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933183AbbLHKIc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Dec 2015 05:08:32 -0500
Content-Disposition: inline
In-Reply-To: <CAEE8DsL73FVDMdVCVC0Z=X5KKiaE=KnTwPNp3gJS37nd7oq9dA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yang Wang <wang701@purdue.edu>
Cc: linux-can <linux-can@vger.kernel.org>

Hi,

I looked quickly in the program source, it looks right at first glance.

Your problem is not related to userspace, it's kernelspace.

j1939-v3.15x is not stable yet.
I pushed my latest commits yesterday.

Can you try checkout j1939-v3.15?
It worked on my system, but I had not yet a chance to seriously test
that. I'm currently removing rtnetlink requirements.

Kind regards
Kurt

--- Original message ---
> Date:	Mon, 7 Dec 2015 01:07:33 -0500
> From: Yang Wang <wang701@purdue.edu>
> To: linux-can <linux-can@vger.kernel.org>
> Subject: J1939 send causes call trace dump
> 
> Hi all,
> 
> I have an issue when sending J1939 messages from a src to dest address
> using static addressing.
> 
> My setup:
> 
> Virtualbox, Ubuntu 14.04, running kernel version 3.15 (compiled using
> Kurt's j1939-3.15x branch)
> iproute2, Kurt's j1939-v3.0 branch
> can-utils, Kurt's j1939-v6 branch
> 
> Setting up the CAN interface:
> 
> $ modprobe vcan
> $ ip link add can0 type vcan
> $ ip link set can0 up
> $ modprobe can-j1939
> $ ip link set can0 j1939 on
> $ ip addr add j1939 0x45 dev can0
> 
> For my program, for binding:
> 
> addr.can_addr.j1939.addr = 0x45;
> addr.can_addr.j1939.name = J1939_NO_NAME;
> addr.can_addr.j1939.pgn = 0xF00A;
> 
> and for sending, I change j1939.addr to 0x30, allocate a buffer of
> data and send the message using sendto().
> 
> Using jspy, I could catch the message being sent. However, my program
> doesn't exit gracefully. The terminal spits out "Killed" right after
> my program sends out the message.
> 
> In addition, a reproducible call trace is observed:
> 
> [ 1279.698179] BUG: unable to handle kernel NULL pointer dereference
> at 000000000000006c
> [ 1279.699105] IP: [<ffffffffa017a49d>] j1939_send+0xdd/0x230 [can_j1939]
> [ 1279.699940] PGD 2df3d067 PUD 6cd55067 PMD 0
> [ 1279.700458] Oops: 0002 [#1] SMP
> [ 1279.705655] CPU: 1 PID: 1666 Comm: jsend Not tainted 3.15.0+ #1
> [ 1279.706415] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
> VirtualBox 12/01/2006
> [ 1279.707372] task: ffff88007c371d40 ti: ffff88006cd20000 task.ti:
> ffff88006cd20000
> [ 1279.708462] RIP: 0010:[<ffffffffa017a49d>]  [<ffffffffa017a49d>]
> j1939_send+0xdd/0x230 [can_j1939]
> [ 1279.709420] RSP: 0018:ffff88006cd23ca8  EFLAGS: 00010286
> [ 1279.709999] RAX: 0000000000406000 RBX: ffff88007c3e0500 RCX: ffff88007c371d40
> [ 1279.710987] RDX: 0000000000406000 RSI: 0000000000000000 RDI: 0000000000000000
> [ 1279.712061] RBP: ffff88006cd23cc8 R08: 0000000000017120 R09: 0000000000000101
> [ 1279.714081] R10: ffffffff81609047 R11: ffffea0001f0f800 R12: ffff88007b848000
> [ 1279.716688] R13: 0000000000000000 R14: ffff88007b848010 R15: ffff88006cd23e80
> [ 1279.718419] FS:  00007f6a223f9740(0000) GS:ffff88007fc80000(0000)
> knlGS:0000000000000000
> [ 1279.720975] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1279.722103] CR2: 000000000000006c CR3: 000000007c381000 CR4: 00000000000406e0
> [ 1279.723302] Stack:
> [ 1279.724270]  0000000000000008 ffff88007c3e0500 ffff88006cc20ee8
> ffff88006cc20c00
> [ 1279.726141]  ffff88006cd23d48 ffffffffa017d4f5 ffff88007ffecf00
> ffff88006cd23e70
> [ 1279.727723]  ffff88006cc4b000 0000000000000000 ffff88007c371d40
> ffff88006cd23d48
> [ 1279.729309] Call Trace:
> [ 1279.730000]  [<ffffffffa017d4f5>] j1939sk_sendmsg+0x3c5/0x540 [can_j1939]
> [ 1279.730988]  [<ffffffff8160227b>] sock_sendmsg+0x8b/0xc0
> [ 1279.731850]  [<ffffffff8161ae49>] ? dev_get_by_name_rcu+0x69/0x90
> [ 1279.732833]  [<ffffffff816321ae>] ? dev_ioctl+0x1ce/0x590
> [ 1279.733734]  [<ffffffff811d2f33>] ? __fdget+0x13/0x20
> [ 1279.734590]  [<ffffffff816027f1>] SYSC_sendto+0x121/0x1c0
> [ 1279.736282]  [<ffffffff811b7ecc>] ? alloc_file+0x1c/0x80
> [ 1279.737136]  [<ffffffff811d359e>] ? __fd_install+0x4e/0x60
> [ 1279.737989]  [<ffffffff816031ee>] SyS_sendto+0xe/0x10
> [ 1279.738808]  [<ffffffff8172ad2d>] system_call_fastpath+0x1a/0x1f
> [ 1279.739681] Code: 00 00 0f b6 43 2d 3c fd 76 44 3c fe 0f 84 ec 00
> 00 00 c7 43 40 00 00 00 00 41 bd 9d ff ff ff 4c 89 f7 e8 57 74 5a e1
> 48 8b 7b 18 <f0> ff 4f 6c 0f 84 99 00 00 00 4c 89 e7 e8 f1 04 00 00 44
> 89 e8
> [ 1279.742900] RIP  [<ffffffffa017a49d>] j1939_send+0xdd/0x230 [can_j1939]
> [ 1279.743779]  RSP <ffff88006cd23ca8>
> [ 1279.744460] CR2: 000000000000006c
> [ 1279.746096] ---[ end trace b6e1fe37af842f42 ]---
> 
> I tried to deciper the call trace by looking up instructor pointer
> address and look into j1939 module code but not very fruitful.
> 
> I also tried using v3.6, v3.16 branch of iproute2 and they produced
> the same call trace.
> 
> Have anybody else encountered this type of issue? I am not certain
> where I should go look into. Any pointer will be appreciated.
> 
> Regards,
> Yang
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
