From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] bonding: do not enslave CAN devices
Date: Fri, 6 Mar 2020 18:34:05 +0100
Message-ID: <CACT4Y+brat=HBcptYy_=13ny40TuM=Y2XNUXja_zH4Z1Mwen4w@mail.gmail.com>
References: <767580d8-1c93-907b-609c-4c1c049b7c42@pengutronix.de>
 <20200226.202326.295871777946911500.davem@davemloft.net> <d6d9368d-b468-3946-ac63-abedf6758154@hartkopp.net>
 <20200302.111249.471862054833131096.davem@davemloft.net> <03ff979e-a621-c9a3-9be3-13677c147f91@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <03ff979e-a621-c9a3-9be3-13677c147f91@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: David Miller <davem@davemloft.net>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, netdev <netdev@vger.kernel.org>, syzbot <syzbot+c3ea30e1e2485573f953@syzkaller.appspotmail.com>, j.vosburgh@gmail.com, vfalico@gmail.com, Andy Gospodarek <andy@greyhouse.net>, stable <stable@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

On Fri, Mar 6, 2020 at 3:12 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 3/2/20 8:12 PM, David Miller wrote:
> > From: Oliver Hartkopp <socketcan@hartkopp.net>
> > Date: Mon, 2 Mar 2020 09:45:41 +0100
> >
> >> I don't know yet whether it makes sense to have CAN bonding/team
> >> devices. But if so we would need some more investigation. For now
> >> disabling CAN interfaces for bonding/team devices seems to be
> >> reasonable.
> >
> > Every single interesting device that falls into a special use case
> > like CAN is going to be tempted to add a similar check.
> >
> > I don't want to set this precedence.
> >
> > Check that the devices you get passed are actually CAN devices, it's
> > easy, just compare the netdev_ops and make sure they equal the CAN
> > ones.
>
> Sorry, I'm not really sure how to implement this check.
>
> Should I maintain a list of all netdev_ops of all the CAN devices (=
> whitelist) and the compare against that list? Having a global list of
> pointers to network devices remind me of the old days of kernel-2.4.

I think Dave means something like this:

$ grep "netdev_ops == " drivers/net/*/*.c net/*/*.c
drivers/net/hyperv/netvsc_drv.c: if (event_dev->netdev_ops == &device_ops)
drivers/net/ppp/ppp_generic.c: if (dev->netdev_ops == &ppp_netdev_ops)
net/dsa/slave.c: return dev->netdev_ops == &dsa_slave_netdev_ops;
net/openvswitch/vport-internal_dev.c: return netdev->netdev_ops ==
&internal_dev_netdev_ops;
