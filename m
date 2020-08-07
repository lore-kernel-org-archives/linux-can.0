From: Zhang Changzhong <zhangchangzhong@huawei.com>
Subject: Re: [PATCH net 0/4] support multipacket broadcast message
Date: Fri, 7 Aug 2020 17:36:38 +0800
Message-ID: <24c3daa5-8243-0b80-9f4c-aa5883cb75da@huawei.com>
References: <1596599425-5534-1-git-send-email-zhangchangzhong@huawei.com>
 <20200806161027.py5ged3a23xpmxgi@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:9352 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726382AbgHGJgq (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 7 Aug 2020 05:36:46 -0400
In-Reply-To: <20200806161027.py5ged3a23xpmxgi@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: robin@protonic.nl, linux@rempel-privat.de, kernel@pengutronix.de, socketcan@hartkopp.net, mkl@pengutronix.de, davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org

Hi Oleksij,

We have tested this j1939 stack according to SAE J1939-21. It works fine for
most cases, but when we test multipacket broadcast message function we found
the receiver can't receive those packets.

You can reproduce on CAN bus or vcan, for vcan case use cangw to connect vcan0
and vcan1:
sudo cangw -A -s vcan0 -d vcan1 -e
sudo cangw -A -s vcan1 -d vcan0 -e

To reproduce it use following commands:
testj1939 -B -r vcan1:0x90 &
testj1939 -B -s20 vcan0:0x80 :,0x12300

Besides, candump receives correct packets while testj1939 receives nothing.

Regards,
Zhang Changzhong

On 2020/8/7 0:10, Oleksij Rempel wrote:
> Hello,
> 
> Thank you for your patches! Currently I'm busy, but I'll take a look at it as
> soon possible.
> 
> btw. can you tell me about more of your use case/work. I would like to
> have some feedback about this stack. You can write a personal message,
> if it is not for public.
> 
> On Wed, Aug 05, 2020 at 11:50:21AM +0800, Zhang Changzhong wrote:
>> Zhang Changzhong (4):
>>   can: j1939: fix support for multipacket broadcast message
>>   can: j1939: cancel rxtimer on multipacket broadcast session complete
>>   can: j1939: abort multipacket broadcast session when timeout occurs
>>   can: j1939: add rxtimer for multipacket broadcast session
>>
>>  net/can/j1939/transport.c | 48 +++++++++++++++++++++++++++++++++++------------
>>  1 file changed, 36 insertions(+), 12 deletions(-)
> 
> Regards,
> Oleksij
> 
