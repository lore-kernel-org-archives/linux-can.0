From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] bonding: do not enslave CAN devices
Date: Sat, 21 Mar 2020 15:00:30 +0100
Message-ID: <42aee2fd-b6d4-fa28-27fc-f8faab32c73f@hartkopp.net>
References: <d6d9368d-b468-3946-ac63-abedf6758154@hartkopp.net>
 <20200302.111249.471862054833131096.davem@davemloft.net>
 <03ff979e-a621-c9a3-9be3-13677c147f91@pengutronix.de>
 <20200306.211320.1410615421373955488.davem@davemloft.net>
 <d69b4a32-5d3e-d100-78d3-d713b97eb2ff@pengutronix.de>
 <20200313095610.x3iorvdotry54vb4@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20200313095610.x3iorvdotry54vb4@pengutronix.de>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Oleksij Rempel <o.rempel@pengutronix.de>, Marc Kleine-Budde <mkl@pengutronix.de>, David Miller <davem@davemloft.net>, Sabrina Dubroca <sd@queasysnail.net>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, syzbot+c3ea30e1e2485573f953@syzkaller.appspotmail.com, dvyukov@google.com, j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net, stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org

+ Sabrina Dubroca (takes care of team driver which has the same issue)

On 13/03/2020 10.56, Oleksij Rempel wrote:
> On Mon, Mar 09, 2020 at 11:25:50AM +0100, Marc Kleine-Budde wrote:
>> On 3/7/20 6:13 AM, David Miller wrote:

>>> Like this:
>>>
>>> if (netdev->ops != &can_netdev_ops)
>>> 	return;
>>
>> There is no single can_netdev_ops. The netdev_ops are per CAN-network
>> driver. But the ml_priv is used in the generic CAN code.
> 
> ping,
> 
> are there any other ways or ideas how to solve this issue?

Well, IMO the patch from
https://marc.info/?l=linux-can&m=158039108004683
is still valid.

Although the attribution that commit 8df9ffb888c ("can: make use of 
preallocated can_ml_priv for per device struct can_dev_rcv_lists")
introduced the problem could be removed.

Even before this commit dev->ml_priv of CAN interfaces has been used to 
store the filter lists. And either the bonding and the team driver do 
not take care of ml_priv.

They pretend to be CAN interfaces by faking dev->type to be ARPHRD_CAN - 
but they are not. When we dereference dev->ml_priv in (badly) faked CAN 
devices we run into the reported issue.

So the approach is to tell bonding and team driver to keep the fingers 
away from CAN interfaces like we do with some ARPHRD_INFINIBAND setups 
in bond_enslave() too.

Regards,
Oliver
