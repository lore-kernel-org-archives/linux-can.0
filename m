From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: KASAN: slab-out-of-bounds Read in _decode_session6 (2)
Date: Fri, 22 Mar 2019 00:21:51 +0100
Message-ID: <CAJZ5v0jVquKnFHrQ+=AyZM2rwOx3CkdGng1z2g2UX30+PJaKDQ@mail.gmail.com>
References: <000000000000c4ba820579737025@google.com> <000000000000461a4c0584a2cfd2@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000000000000461a4c0584a2cfd2@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: syzbot <syzbot+240f9766d6be3d69431e@syzkaller.appspotmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, daniel@iogearbox.net, David Miller <davem@davemloft.net>, devel@acpica.org, Herbert Xu <herbert@gondor.apana.org.au>, kuznet@ms2.inr.ac.ru, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-can@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Lv <lv.zheng@intel.com>, mkl@pengutronix.de, netdev <netdev@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, socketcan@hartkopp.net, steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
List-Id: linux-can.vger.kernel.org

On Fri, Mar 22, 2019 at 12:08 AM syzbot
<syzbot+240f9766d6be3d69431e@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit 64fd1c7040880292710e6592ddc88d0d73cfb6fb
> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Date:   Mon Jun 12 20:48:41 2017 +0000
>
>      ACPI / PM: Run wakeup notify handlers synchronously
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1555b12b200000
> start commit:   64fd1c70 ACPI / PM: Run wakeup notify handlers synchronously
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=1755b12b200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1355b12b200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=93932074d01b4a5
> dashboard link: https://syzkaller.appspot.com/bug?extid=240f9766d6be3d69431e
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13f35e4d400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1280edbd400000
>
> Reported-by: syzbot+240f9766d6be3d69431e@syzkaller.appspotmail.com
> Fixes: 64fd1c704088 ("ACPI / PM: Run wakeup notify handlers synchronously")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

I don't see how the commit turned up by the bisection can be related
to the reported crash.
