From: syzbot <syzbot+d9536adc269404a984f8@syzkaller.appspotmail.com>
Subject: Re: KASAN: use-after-free Read in j1939_session_get_by_addr
Date: Tue, 05 Nov 2019 00:05:01 -0800
Message-ID: <0000000000009427b5059694e33c@google.com>
References: <0000000000009393ba059691c6a3@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0000000000009393ba059691c6a3@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jose.Abreu@synopsys.com, arvid.brodin@alten.se, davem@davemloft.net, ilias.apalodimas@linaro.org, joabreu@synopsys.com, jose.abreu@synopsys.com, kernel@pengutronix.de, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, linux@rempel-privat.de, mkl@pengutronix.de, netdev@vger.kernel.org, robin@protonic.nl, socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
List-Id: linux-can.vger.kernel.org

syzbot has bisected this bug to:

commit 2af6106ae949651d529c8c3f0734c3a7babd0d4b
Author: Jose Abreu <Jose.Abreu@synopsys.com>
Date:   Tue Jul 9 08:03:00 2019 +0000

     net: stmmac: Introducing support for Page Pool

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15f481c8e00000
start commit:   1574cf83 Merge tag 'mlx5-updates-2019-11-01' of git://git...
git tree:       net-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17f481c8e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13f481c8e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c26333525dde4c39
dashboard link: https://syzkaller.appspot.com/bug?extid=d9536adc269404a984f8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16050314e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159c59b2e00000

Reported-by: syzbot+d9536adc269404a984f8@syzkaller.appspotmail.com
Fixes: 2af6106ae949 ("net: stmmac: Introducing support for Page Pool")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
