From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: KASAN: use-after-free Read in j1939_session_get_by_addr
Date: Tue, 5 Nov 2019 09:39:26 +0100
Message-ID: <CACT4Y+Y+zudxSaNc4-b02QWu9hPXHrReCKsOLBpscMub5KN7+A@mail.gmail.com>
References: <0000000000009393ba059691c6a3@google.com> <0000000000009427b5059694e33c@google.com>
 <BN8PR12MB3266A0CC1496ED5D532EA6D5D37E0@BN8PR12MB3266.namprd12.prod.outlook.com>
 <969f940b-05ba-3fbf-79ba-95dc1cebc40d@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <969f940b-05ba-3fbf-79ba-95dc1cebc40d@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Jose Abreu <Jose.Abreu@synopsys.com>, syzbot <syzbot+d9536adc269404a984f8@syzkaller.appspotmail.com>, "arvid.brodin@alten.se" <arvid.brodin@alten.se>, "davem@davemloft.net" <davem@davemloft.net>, "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux@rempel-privat.de" <linux@rempel-privat.de>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "robin@protonic.nl" <robin@protonic.nl>, "socketcan@hartkopp.net" <socketcan@hartkopp.net>, "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
List-Id: linux-can.vger.kernel.org

On Tue, Nov 5, 2019 at 9:35 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 11/5/19 9:21 AM, Jose Abreu wrote:
> > From: syzbot <syzbot+d9536adc269404a984f8@syzkaller.appspotmail.com>
> > Date: Nov/05/2019, 08:05:01 (UTC+00:00)
> >
> >> syzbot has bisected this bug to:
> >>
> >> commit 2af6106ae949651d529c8c3f0734c3a7babd0d4b
> >> Author: Jose Abreu <Jose.Abreu@synopsys.com>
> >> Date:   Tue Jul 9 08:03:00 2019 +0000
> >>
> >>      net: stmmac: Introducing support for Page Pool
> >
> > From the config provided, stmmac driver is not even enabled. Can you
> > please confirm the bisection process ?
>
> Looks like a false positive, as j1939 (net/can/j1939/) hit mainline with
> v5.4-rc1~131^2~78^2.
>
> While the bisected commit is v5.3-rc1~140^2~13^2.


Yes, the commit is most likely irrelevant. As you can see in the
bisection log the process was diverged by "WARNING: ODEBUG bug in
netdev_freemem". I think it's not the first and not the second time I
see that crash breaks bisection:
https://syzkaller.appspot.com/bug?id=96a64fde216dca408a5c25db4e57838c51e435aa
