From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] bonding: do not enslave CAN devices
Date: Mon, 2 Mar 2020 09:45:41 +0100
Message-ID: <d6d9368d-b468-3946-ac63-abedf6758154@hartkopp.net>
References: <20200130133046.2047-1-socketcan@hartkopp.net>
 <767580d8-1c93-907b-609c-4c1c049b7c42@pengutronix.de>
 <20200226.202326.295871777946911500.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20200226.202326.295871777946911500.davem@davemloft.net>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, syzbot+c3ea30e1e2485573f953@syzkaller.appspotmail.com, dvyukov@google.com, j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net, stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org



On 27/02/2020 05.23, David Miller wrote:
> From: Marc Kleine-Budde <mkl@pengutronix.de>
> Date: Tue, 25 Feb 2020 21:32:41 +0100
> 
>> On 1/30/20 2:30 PM, Oliver Hartkopp wrote:
>>> Since commit 8df9ffb888c ("can: make use of preallocated can_ml_priv for per
>>> device struct can_dev_rcv_lists") the device specific CAN receive filter lists
>>> are stored in netdev_priv() and dev->ml_priv points to these filters.
>>>
>>> In the bug report Syzkaller enslaved a vxcan1 CAN device and accessed the
>>> bonding device with a PF_CAN socket which lead to a crash due to an access of
>>> an unhandled bond_dev->ml_priv pointer.
>>>
>>> Deny to enslave CAN devices by the bonding driver as the resulting bond_dev
>>> pretends to be a CAN device by copying dev->type without really being one.
>>>
>>> Reported-by: syzbot+c3ea30e1e2485573f953@syzkaller.appspotmail.com
>>> Fixes: 8df9ffb888c ("can: make use of preallocated can_ml_priv for per
>>> device struct can_dev_rcv_lists")
>>> Cc: linux-stable <stable@vger.kernel.org> # >= v5.4
>>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
>>
>> What's the preferred to upstream this? I could take this via the
>> linux-can tree.
> 
> What I don't get is why the PF_CAN is blindly dereferencing a device
> assuming what is behind bond_dev->ml_priv.
> 
> If it assumes a device it access is CAN then it should check the
> device by comparing the netdev_ops or via some other means.

Yes we do.

> This restriction seems arbitrary.

Since commit 8df9ffb888c the data structures for the CAN filters have 
been moved from net/can/af_can.c into netdev->ml_priv.

PF_CAN only works with CAN interfaces and therefore always checks 
dev->type to be ARPHRD_CAN before accessing netdev->ml_priv.

Bonding and Team driver copy most of the device data structures to 
create bonding/team devices.
They copy dev->type but *not* dev->ml_priv.
That leads to the problematic ml_priv access after passing the dev->type 
check ...

I don't know yet whether it makes sense to have CAN bonding/team 
devices. But if so we would need some more investigation. For now 
disabling CAN interfaces for bonding/team devices seems to be reasonable.

Regards,
Oliver
