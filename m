From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] bonding: do not enslave CAN devices
Date: Fri, 6 Mar 2020 15:12:48 +0100
Message-ID: <03ff979e-a621-c9a3-9be3-13677c147f91@pengutronix.de>
References: <767580d8-1c93-907b-609c-4c1c049b7c42@pengutronix.de>
 <20200226.202326.295871777946911500.davem@davemloft.net>
 <d6d9368d-b468-3946-ac63-abedf6758154@hartkopp.net>
 <20200302.111249.471862054833131096.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200302.111249.471862054833131096.davem@davemloft.net>
Content-Language: en-GB
Sender: netdev-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>, socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, syzbot+c3ea30e1e2485573f953@syzkaller.appspotmail.com, dvyukov@google.com, j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net, stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On 3/2/20 8:12 PM, David Miller wrote:
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> Date: Mon, 2 Mar 2020 09:45:41 +0100
> 
>> I don't know yet whether it makes sense to have CAN bonding/team
>> devices. But if so we would need some more investigation. For now
>> disabling CAN interfaces for bonding/team devices seems to be
>> reasonable.
> 
> Every single interesting device that falls into a special use case
> like CAN is going to be tempted to add a similar check.
> 
> I don't want to set this precedence.
> 
> Check that the devices you get passed are actually CAN devices, it's
> easy, just compare the netdev_ops and make sure they equal the CAN
> ones.

Sorry, I'm not really sure how to implement this check.

Should I maintain a list of all netdev_ops of all the CAN devices (=
whitelist) and the compare against that list? Having a global list of
pointers to network devices remind me of the old days of kernel-2.4.

regards,
Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
