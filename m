From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: KASAN: use-after-free Read in slcan_open
Date: Mon, 2 Mar 2020 09:31:58 +0100
Message-ID: <2f8c5b49-ae02-e269-97cf-b4a979f950ac@hartkopp.net>
References: <00000000000099fb63059fd95165@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:9718 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgCBIcQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 2 Mar 2020 03:32:16 -0500
In-Reply-To: <00000000000099fb63059fd95165@google.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: syzbot <syzbot+b5ec6fd05ab552a78532@syzkaller.appspotmail.com>, davem@davemloft.net, dvyukov@google.com, jouni.hogander@unikie.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, mkl@pengutronix.de, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, wg@grandegger.com

#sys fix: can: slcan: Fix use-after-free Read in slcan_open

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/can/slcan.c?id=9ebd796e24008f33f06ebea5a5e6aceb68b51794

Thanks,
Oliver

On 02/03/2020 07.30, syzbot wrote:
> This bug is marked as fixed by commit:
> slcan: Fix use-after-free Read in slcan_open
> But I can't find it in any tested tree for more than 90 days.
> Is it a correct commit? Please update it by replying:
> #syz fix: exact-commit-title
> Until then the bug is still considered open and
> new crashes with the same signature are ignored.
> 
