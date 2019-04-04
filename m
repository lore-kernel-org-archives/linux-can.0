From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: kernel BUG at arch/x86/mm/physaddr.c:LINE! (2)
Date: Thu, 4 Apr 2019 16:51:36 +0200
Message-ID: <be750b12-ba3d-ecb4-541a-ca3669bb75d7@xs4all.nl>
References: <0000000000001c2b95057ad0935b@google.com>
 <000000000000462a4105848c8e12@google.com>
 <CAG_fn=VnXmDSc_QNqyEv7f7iwHXC6taBq1t55fHWZpLZ0EdiNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAG_fn=VnXmDSc_QNqyEv7f7iwHXC6taBq1t55fHWZpLZ0EdiNw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Potapenko <glider@google.com>, syzbot <syzbot+6c0effb5877f6b0344e2@syzkaller.appspotmail.com>
Cc: David Miller <davem@davemloft.net>, linux-can@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org, mchehab@kernel.org, mchehab@s-opensource.com, mkl@pengutronix.de, Networking <netdev@vger.kernel.org>, socketcan@hartkopp.net, syzkaller-bugs <syzkaller-bugs@googlegroups.com>
List-Id: linux-can.vger.kernel.org

On 4/4/19 4:47 PM, Alexander Potapenko wrote:
> On Wed, Mar 20, 2019 at 9:35 PM syzbot
> <syzbot+6c0effb5877f6b0344e2@syzkaller.appspotmail.com> wrote:
>>
>> syzbot has bisected this bug to:
>>
>> commit 6d469a202ee73196d0df76025af80bd6a379e658
>> Author: Mauro Carvalho Chehab <mchehab@s-opensource.com>
>> Date:   Sun May 14 17:07:21 2017 +0000
>>
>>      Merge tag 'v4.12-rc1' into patchwork
>>
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12639fd7200000
>> start commit:   6d469a20 Merge tag 'v4.12-rc1' into patchwork
>> git tree:       upstream
>> final crash:    https://syzkaller.appspot.com/x/report.txt?x=15639fd7200000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=11639fd7200000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=d86f24333880b605
>> dashboard link: https://syzkaller.appspot.com/bug?extid=6c0effb5877f6b0344e2
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1312062b400000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=131bd093400000
>>
>> Reported-by: syzbot+6c0effb5877f6b0344e2@syzkaller.appspotmail.com
>> Fixes: 6d469a20 ("Merge tag 'v4.12-rc1' into patchwork")
>>
>> --
>> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000462a4105848c8e12%40google.com.
>> For more options, visit https://groups.google.com/d/optout.
> 
> I believe this bug is caused by vivid_vid_cap_s_selection() calling
> kfree(dev->bitmap_cap).
> This makes little sense, as dev->bitmap_cap seems to be allocated
> using vzalloc().
> 

Yup, that should be vfree. There was a similar problem with bitmap_out that
I fixed, but it looks I missed this one. Can you make a patch?

Thanks,

	Hans
