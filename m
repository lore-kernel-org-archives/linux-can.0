From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] bonding: do not enslave CAN devices
Date: Mon, 9 Mar 2020 11:25:50 +0100
Message-ID: <d69b4a32-5d3e-d100-78d3-d713b97eb2ff@pengutronix.de>
References: <d6d9368d-b468-3946-ac63-abedf6758154@hartkopp.net>
 <20200302.111249.471862054833131096.davem@davemloft.net>
 <03ff979e-a621-c9a3-9be3-13677c147f91@pengutronix.de>
 <20200306.211320.1410615421373955488.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20200306.211320.1410615421373955488.davem@davemloft.net>
Content-Language: de-DE
Sender: stable-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: socketcan@hartkopp.net, linux-can@vger.kernel.org, netdev@vger.kernel.org, syzbot+c3ea30e1e2485573f953@syzkaller.appspotmail.com, dvyukov@google.com, j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net, stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On 3/7/20 6:13 AM, David Miller wrote:
> From: Marc Kleine-Budde <mkl@pengutronix.de>
> Date: Fri, 6 Mar 2020 15:12:48 +0100
> 
>> On 3/2/20 8:12 PM, David Miller wrote:
>>> From: Oliver Hartkopp <socketcan@hartkopp.net>
>>> Date: Mon, 2 Mar 2020 09:45:41 +0100
>>>
>>>> I don't know yet whether it makes sense to have CAN bonding/team
>>>> devices. But if so we would need some more investigation. For now
>>>> disabling CAN interfaces for bonding/team devices seems to be
>>>> reasonable.
>>>
>>> Every single interesting device that falls into a special use case
>>> like CAN is going to be tempted to add a similar check.
>>>
>>> I don't want to set this precedence.
>>>
>>> Check that the devices you get passed are actually CAN devices, it's
>>> easy, just compare the netdev_ops and make sure they equal the CAN
>>> ones.
>>
>> Sorry, I'm not really sure how to implement this check.
> 
> Like this:
> 
> if (netdev->ops != &can_netdev_ops)
> 	return;

There is no single can_netdev_ops. The netdev_ops are per CAN-network
driver. But the ml_priv is used in the generic CAN code.

regards,
Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
