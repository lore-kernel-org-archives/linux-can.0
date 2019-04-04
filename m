From: Alexander Potapenko <glider@google.com>
Subject: Re: kernel BUG at arch/x86/mm/physaddr.c:LINE! (2)
Date: Thu, 4 Apr 2019 16:54:43 +0200
Message-ID: <CAG_fn=UGc2_CpLG0c8Ppv7X7ss6-wmXtEX76=yLow=5_DNCH2g@mail.gmail.com>
References: <0000000000001c2b95057ad0935b@google.com> <000000000000462a4105848c8e12@google.com>
 <CAG_fn=VnXmDSc_QNqyEv7f7iwHXC6taBq1t55fHWZpLZ0EdiNw@mail.gmail.com> <be750b12-ba3d-ecb4-541a-ca3669bb75d7@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <be750b12-ba3d-ecb4-541a-ca3669bb75d7@xs4all.nl>
Sender: netdev-owner@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: syzbot <syzbot+6c0effb5877f6b0344e2@syzkaller.appspotmail.com>, David Miller <davem@davemloft.net>, linux-can@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org, mchehab@kernel.org, mchehab@s-opensource.com, mkl@pengutronix.de, Networking <netdev@vger.kernel.org>, socketcan@hartkopp.net, syzkaller-bugs <syzkaller-bugs@googlegroups.com>
List-Id: linux-can.vger.kernel.org

On Thu, Apr 4, 2019 at 4:51 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 4/4/19 4:47 PM, Alexander Potapenko wrote:
> > On Wed, Mar 20, 2019 at 9:35 PM syzbot
> > <syzbot+6c0effb5877f6b0344e2@syzkaller.appspotmail.com> wrote:
> >>
> >> syzbot has bisected this bug to:
> >>
> >> commit 6d469a202ee73196d0df76025af80bd6a379e658
> >> Author: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> >> Date:   Sun May 14 17:07:21 2017 +0000
> >>
> >>      Merge tag 'v4.12-rc1' into patchwork
> >>
> >> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D12639fd=
7200000
> >> start commit:   6d469a20 Merge tag 'v4.12-rc1' into patchwork
> >> git tree:       upstream
> >> final crash:    https://syzkaller.appspot.com/x/report.txt?x=3D15639fd=
7200000
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=3D11639fd720=
0000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd86f243338=
80b605
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=3D6c0effb5877f=
6b0344e2
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1312062b=
400000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D131bd09340=
0000
> >>
> >> Reported-by: syzbot+6c0effb5877f6b0344e2@syzkaller.appspotmail.com
> >> Fixes: 6d469a20 ("Merge tag 'v4.12-rc1' into patchwork")
> >>
> >> --
> >> You received this message because you are subscribed to the Google Gro=
ups "syzkaller-bugs" group.
> >> To unsubscribe from this group and stop receiving emails from it, send=
 an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> >> To view this discussion on the web visit https://groups.google.com/d/m=
sgid/syzkaller-bugs/000000000000462a4105848c8e12%40google.com.
> >> For more options, visit https://groups.google.com/d/optout.
> >
> > I believe this bug is caused by vivid_vid_cap_s_selection() calling
> > kfree(dev->bitmap_cap).
> > This makes little sense, as dev->bitmap_cap seems to be allocated
> > using vzalloc().
> >
>
> Yup, that should be vfree. There was a similar problem with bitmap_out th=
at
> I fixed, but it looks I missed this one. Can you make a patch?
Yes, I've almost hit the send button :)
> Thanks,
>
>         Hans



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
