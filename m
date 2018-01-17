From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: WARNING in can_rcv
Date: Wed, 17 Jan 2018 08:39:17 +0100
Message-ID: <CACT4Y+ZFyO_n5CUhMBwRqTSVd70V3c+sRxpqZpY_HWDq=umGpA@mail.gmail.com>
References: <001a11c16b40d795350562e878cc@google.com> <a48197ff-9270-8af7-a814-56af53093b3c@pengutronix.de>
 <CACT4Y+b0oUPVr7f973ZgBm9rUog=-mRWDFpcr-EzKaGYRnn8mQ@mail.gmail.com>
 <48c5623e-de78-5cfa-b537-2acf9a44ae51@hartkopp.net> <20180117071204.GG15527@zzz.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117071204.GG15527@zzz.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, syzbot <syzbot+4386709c0c1284dca827@syzkaller.appspotmail.com>, David Miller <davem@davemloft.net>, linux-can@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>, syzkaller-bugs@googlegroups.com
List-Id: linux-can.vger.kernel.org

On Wed, Jan 17, 2018 at 8:12 AM, Eric Biggers <ebiggers3@gmail.com> wrote:
> On Wed, Jan 17, 2018 at 07:39:24AM +0100, Oliver Hartkopp wrote:
>>
>>
>> On 01/16/2018 07:11 PM, Dmitry Vyukov wrote:
>> > On Tue, Jan 16, 2018 at 7:07 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>> > > On 01/16/2018 06:58 PM, syzbot wrote:
>> > > > Hello,
>> > > >
>> > > > syzkaller hit the following crash on
>> > > > a8750ddca918032d6349adbf9a4b6555e7db20da
>> > > > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
>> > > > compiler: gcc (GCC) 7.1.1 20170620
>> > > > .config is attached
>> > > > Raw console output is attached.
>> > > > C reproducer is attached
>> > > > syzkaller reproducer is attached. See https://goo.gl/kgGztJ
>> > > > for information about syzkaller reproducers
>> > > >
>> > > >
>> > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> > > > Reported-by: syzbot+4386709c0c1284dca827@syzkaller.appspotmail.com
>> > > > It will help syzbot understand when the bug is fixed. See footer for
>> > > > details.
>> > > > If you forward the report, please keep this part and the footer.
>> > > >
>> > > > device eql entered promiscuous mode
>> > > > ------------[ cut here ]------------
>> > > > PF_CAN: dropped non conform CAN skbuf: dev type 65534, len 42, datalen 0
>> > > > WARNING: CPU: 0 PID: 3650 at net/can/af_can.c:729 can_rcv+0x1c5/0x200
>> > > > net/can/af_can.c:724
>> > > > Kernel panic - not syncing: panic_on_warn set ...
>> > >
>> > > Invalid packages generate a warning (WARN_ONCE()), and you have
>> > > panic_on_warn active. Should we better silently drop these CAN packages?
>> >
>> > Hi,
>> >
>> > pr_warn_once() will be more appropriate. It prints a single line.
>> >
>>
>> The idea behind this WARN() is to detect really bad things that might have
>> happen on network driver level:
>>
>> The CAN subsystem registers with dev_add_pack() for ETH_P_CAN and
>> ETH_P_CANFD only. These ETH_P_ types are only allowed to be created by CAN
>> network devices (like vcan, vxcan, and real CAN drivers).
>>
>> I don't have any strong opinion on using WARN() or pr_warn_once().
>> Is this detected violation worth using WARN(), as something already must
>> have gone really wrong to trigger this issue?
>>
>
> WARN() indicates a kernel bug.  If it's instead "userspace did something
> stupid", or "someone sent some unexpected network packet", it needs to be
> pr_warn_once(), pr_warn_ratelimited(), or removed entirely.


The packet comes from tun device. We could change tun to filter out
such packages earlier. However, in the context of "syzkaller support
for AF_CAN" discussion, it would actually be useful for fuzzer to be
able emit can packets for testing purposes. For example, for tcp it
can not just emit random packets, it can build complex user<->network
interactions, for example, open a listening socket, connect to it
"from outside", accept the connection, and then exchange some data
over the active connection. It could do the same for can.
Is it possible to allow can packets via tun? Then we could leave this
WARNING in place. tun/vcan are contained within a net namespace, so
this should not be a security problem, right?
Or is there a way to do the same with vcan? If yes, then fuzzer could
use vcan. But then we need some fix for this WARNING: either change it
to pr_warn or change tun (I don't have strong preference which one).
