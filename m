From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] bonding: do not enslave CAN devices
Date: Thu, 30 Jan 2020 14:57:39 +0100
Message-ID: <81d1f033-038e-3b1a-9e14-257fad5d1983@hartkopp.net>
References: <20200130133046.2047-1-socketcan@hartkopp.net>
 <20200130134141.GA804563@bistromath.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.169]:21365 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgA3N6D (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 30 Jan 2020 08:58:03 -0500
In-Reply-To: <20200130134141.GA804563@bistromath.localdomain>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, syzbot+c3ea30e1e2485573f953@syzkaller.appspotmail.com, dvyukov@google.com, mkl@pengutronix.de, j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net, davem@davemloft.net, linux-stable <stable@vger.kernel.org>

On 30/01/2020 14.41, Sabrina Dubroca wrote:

> 2020-01-30, 14:30:46 +0100, Oliver Hartkopp wrote:
>> Since commit 8df9ffb888c ("can: make use of preallocated can_ml_priv for per
>> device struct can_dev_rcv_lists") the device specific CAN receive filter lists
>> are stored in netdev_priv() and dev->ml_priv points to these filters.
>>
>> In the bug report Syzkaller enslaved a vxcan1 CAN device and accessed the
>> bonding device with a PF_CAN socket which lead to a crash due to an access of
>> an unhandled bond_dev->ml_priv pointer.
>>
>> Deny to enslave CAN devices by the bonding driver as the resulting bond_dev
>> pretends to be a CAN device by copying dev->type without really being one.
> 
> Does the team driver have the same problem?

Good point!

 From a first look into team_setup_by_port() in team.c I would say YES :-)

Thanks for watching out! I would suggest to wait for some more feedback 
and upstream of this fix.

Best regards,
Oliver
