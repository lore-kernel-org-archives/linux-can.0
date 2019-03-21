From: syzbot <syzbot+240f9766d6be3d69431e@syzkaller.appspotmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in _decode_session6 (2)
Date: Thu, 21 Mar 2019 16:08:00 -0700
Message-ID: <000000000000461a4c0584a2cfd2@google.com>
References: <000000000000c4ba820579737025@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000000000000c4ba820579737025@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bhelgaas@google.com, daniel@iogearbox.net, davem@davemloft.net, devel@acpica.org, herbert@gondor.apana.org.au, kuznet@ms2.inr.ac.ru, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, lv.zheng@intel.com, mkl@pengutronix.de, netdev@vger.kernel.org, rafael.j.wysocki@intel.com, rjw@rjwysocki.net, robert.moore@intel.com, socketcan@hartkopp.net, steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
List-Id: linux-can.vger.kernel.org

syzbot has bisected this bug to:

commit 64fd1c7040880292710e6592ddc88d0d73cfb6fb
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Mon Jun 12 20:48:41 2017 +0000

     ACPI / PM: Run wakeup notify handlers synchronously

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1555b12b200000
start commit:   64fd1c70 ACPI / PM: Run wakeup notify handlers synchronously
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1755b12b200000
console output: https://syzkaller.appspot.com/x/log.txt?x=1355b12b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=93932074d01b4a5
dashboard link: https://syzkaller.appspot.com/bug?extid=240f9766d6be3d69431e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13f35e4d400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1280edbd400000

Reported-by: syzbot+240f9766d6be3d69431e@syzkaller.appspotmail.com
Fixes: 64fd1c704088 ("ACPI / PM: Run wakeup notify handlers synchronously")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
