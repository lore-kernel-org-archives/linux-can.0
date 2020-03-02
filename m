From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] bonding: do not enslave CAN devices
Date: Mon, 02 Mar 2020 11:12:49 -0800 (PST)
Message-ID: <20200302.111249.471862054833131096.davem@davemloft.net>
References: <767580d8-1c93-907b-609c-4c1c049b7c42@pengutronix.de>
        <20200226.202326.295871777946911500.davem@davemloft.net>
        <d6d9368d-b468-3946-ac63-abedf6758154@hartkopp.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <d6d9368d-b468-3946-ac63-abedf6758154@hartkopp.net>
Sender: netdev-owner@vger.kernel.org
To: socketcan@hartkopp.net
Cc: mkl@pengutronix.de, linux-can@vger.kernel.org, netdev@vger.kernel.org, syzbot+c3ea30e1e2485573f953@syzkaller.appspotmail.com, dvyukov@google.com, j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net, stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org

From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Mon, 2 Mar 2020 09:45:41 +0100

> I don't know yet whether it makes sense to have CAN bonding/team
> devices. But if so we would need some more investigation. For now
> disabling CAN interfaces for bonding/team devices seems to be
> reasonable.

Every single interesting device that falls into a special use case
like CAN is going to be tempted to add a similar check.

I don't want to set this precedence.

Check that the devices you get passed are actually CAN devices, it's
easy, just compare the netdev_ops and make sure they equal the CAN
ones.
