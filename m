From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: WARNING in can_rcv
Date: Tue, 16 Jan 2018 19:11:07 +0100
Message-ID: <CACT4Y+b0oUPVr7f973ZgBm9rUog=-mRWDFpcr-EzKaGYRnn8mQ@mail.gmail.com>
References: <001a11c16b40d795350562e878cc@google.com> <a48197ff-9270-8af7-a814-56af53093b3c@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a48197ff-9270-8af7-a814-56af53093b3c@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: syzbot <syzbot+4386709c0c1284dca827@syzkaller.appspotmail.com>, David Miller <davem@davemloft.net>, linux-can@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>, syzkaller-bugs@googlegroups.com
List-Id: linux-can.vger.kernel.org

On Tue, Jan 16, 2018 at 7:07 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 01/16/2018 06:58 PM, syzbot wrote:
>> Hello,
>>
>> syzkaller hit the following crash on
>> a8750ddca918032d6349adbf9a4b6555e7db20da
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
>> compiler: gcc (GCC) 7.1.1 20170620
>> .config is attached
>> Raw console output is attached.
>> C reproducer is attached
>> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
>> for information about syzkaller reproducers
>>
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+4386709c0c1284dca827@syzkaller.appspotmail.com
>> It will help syzbot understand when the bug is fixed. See footer for
>> details.
>> If you forward the report, please keep this part and the footer.
>>
>> device eql entered promiscuous mode
>> ------------[ cut here ]------------
>> PF_CAN: dropped non conform CAN skbuf: dev type 65534, len 42, datalen 0
>> WARNING: CPU: 0 PID: 3650 at net/can/af_can.c:729 can_rcv+0x1c5/0x200
>> net/can/af_can.c:724
>> Kernel panic - not syncing: panic_on_warn set ...
>
> Invalid packages generate a warning (WARN_ONCE()), and you have
> panic_on_warn active. Should we better silently drop these CAN packages?

Hi,

pr_warn_once() will be more appropriate. It prints a single line.
