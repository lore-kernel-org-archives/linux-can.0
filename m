From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: WARNING in can_rcv
Date: Tue, 16 Jan 2018 23:12:04 -0800
Message-ID: <20180117071204.GG15527@zzz.localdomain>
References: <001a11c16b40d795350562e878cc@google.com>
 <a48197ff-9270-8af7-a814-56af53093b3c@pengutronix.de>
 <CACT4Y+b0oUPVr7f973ZgBm9rUog=-mRWDFpcr-EzKaGYRnn8mQ@mail.gmail.com>
 <48c5623e-de78-5cfa-b537-2acf9a44ae51@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44688 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750892AbeAQHMH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 17 Jan 2018 02:12:07 -0500
Content-Disposition: inline
In-Reply-To: <48c5623e-de78-5cfa-b537-2acf9a44ae51@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Dmitry Vyukov <dvyukov@google.com>, Marc Kleine-Budde <mkl@pengutronix.de>, syzbot <syzbot+4386709c0c1284dca827@syzkaller.appspotmail.com>, David Miller <davem@davemloft.net>, linux-can@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>, syzkaller-bugs@googlegroups.com

On Wed, Jan 17, 2018 at 07:39:24AM +0100, Oliver Hartkopp wrote:
> 
> 
> On 01/16/2018 07:11 PM, Dmitry Vyukov wrote:
> > On Tue, Jan 16, 2018 at 7:07 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > > On 01/16/2018 06:58 PM, syzbot wrote:
> > > > Hello,
> > > > 
> > > > syzkaller hit the following crash on
> > > > a8750ddca918032d6349adbf9a4b6555e7db20da
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
> > > > compiler: gcc (GCC) 7.1.1 20170620
> > > > .config is attached
> > > > Raw console output is attached.
> > > > C reproducer is attached
> > > > syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> > > > for information about syzkaller reproducers
> > > > 
> > > > 
> > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > Reported-by: syzbot+4386709c0c1284dca827@syzkaller.appspotmail.com
> > > > It will help syzbot understand when the bug is fixed. See footer for
> > > > details.
> > > > If you forward the report, please keep this part and the footer.
> > > > 
> > > > device eql entered promiscuous mode
> > > > ------------[ cut here ]------------
> > > > PF_CAN: dropped non conform CAN skbuf: dev type 65534, len 42, datalen 0
> > > > WARNING: CPU: 0 PID: 3650 at net/can/af_can.c:729 can_rcv+0x1c5/0x200
> > > > net/can/af_can.c:724
> > > > Kernel panic - not syncing: panic_on_warn set ...
> > > 
> > > Invalid packages generate a warning (WARN_ONCE()), and you have
> > > panic_on_warn active. Should we better silently drop these CAN packages?
> > 
> > Hi,
> > 
> > pr_warn_once() will be more appropriate. It prints a single line.
> > 
> 
> The idea behind this WARN() is to detect really bad things that might have
> happen on network driver level:
> 
> The CAN subsystem registers with dev_add_pack() for ETH_P_CAN and
> ETH_P_CANFD only. These ETH_P_ types are only allowed to be created by CAN
> network devices (like vcan, vxcan, and real CAN drivers).
> 
> I don't have any strong opinion on using WARN() or pr_warn_once().
> Is this detected violation worth using WARN(), as something already must
> have gone really wrong to trigger this issue?
> 

WARN() indicates a kernel bug.  If it's instead "userspace did something
stupid", or "someone sent some unexpected network packet", it needs to be
pr_warn_once(), pr_warn_ratelimited(), or removed entirely.

Eric
