From: Michael Walle <michael@walle.cc>
Subject: Re: [PATCH 2/2] can: flexcan: add support for ISO CAN-FD
Date: Tue, 30 Jun 2020 19:00:26 +0200
Message-ID: <e5b56262c291422160e822e4a378dd2c@walle.cc>
References: <20200629181809.25338-1-michael@walle.cc>
 <20200629181809.25338-3-michael@walle.cc>
 <DB8PR04MB679504980A67DB8B1EEC8386E66F0@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <a42e035c8ee3334a721a089b5f8f0580@walle.cc>
 <5f6e0843-8504-e941-b6a3-1dc8599db39e@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <5f6e0843-8504-e941-b6a3-1dc8599db39e@hartkopp.net>
Sender: netdev-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Joakim Zhang <qiangqing.zhang@nxp.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-can.vger.kernel.org

Am 2020-06-30 18:15, schrieb Oliver Hartkopp:
> On 30.06.20 07:53, Michael Walle wrote:
>> [+ Oliver]
>> 
>> Hi Joakim,
>> 
>> Am 2020-06-30 04:42, schrieb Joakim Zhang:
>>>> -----Original Message-----
>>>> From: Michael Walle <michael@walle.cc>
>>>> Sent: 2020年6月30日 2:18
>>>> To: linux-can@vger.kernel.org; netdev@vger.kernel.org;
>>>> linux-kernel@vger.kernel.org
>>>> Cc: Wolfgang Grandegger <wg@grandegger.com>; Marc Kleine-Budde
>>>> <mkl@pengutronix.de>; David S . Miller <davem@davemloft.net>; Jakub
>>>> Kicinski <kuba@kernel.org>; Joakim Zhang <qiangqing.zhang@nxp.com>;
>>>> dl-linux-imx <linux-imx@nxp.com>; Michael Walle <michael@walle.cc>
>>>> Subject: [PATCH 2/2] can: flexcan: add support for ISO CAN-FD
>>>> 
>>>> Up until now, the controller used non-ISO CAN-FD mode, although it 
>>>> supports it.
>>>> Add support for ISO mode, too. By default the hardware is in non-ISO 
>>>> mode and
>>>> an enable bit has to be explicitly set.
>>>> 
>>>> Signed-off-by: Michael Walle <michael@walle.cc>
>>>> ---
>>>>  drivers/net/can/flexcan.c | 19 ++++++++++++++++---
>>>>  1 file changed, 16 insertions(+), 3 deletions(-)
>>>> 
>>>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c 
>>>> index
>>>> 183e094f8d66..a92d3cdf4195 100644
>>>> --- a/drivers/net/can/flexcan.c
>>>> +++ b/drivers/net/can/flexcan.c
>>>> @@ -94,6 +94,7 @@
>>>>  #define FLEXCAN_CTRL2_MRP        BIT(18)
>>>>  #define FLEXCAN_CTRL2_RRS        BIT(17)
>>>>  #define FLEXCAN_CTRL2_EACEN        BIT(16)
>>>> +#define FLEXCAN_CTRL2_ISOCANFDEN    BIT(12)
>>>> 
>>>>  /* FLEXCAN memory error control register (MECR) bits */
>>>>  #define FLEXCAN_MECR_ECRWRDIS        BIT(31)
>>>> @@ -1344,14 +1345,25 @@ static int flexcan_chip_start(struct 
>>>> net_device
>>>> *dev)
>>>>      else
>>>>          reg_mcr |= FLEXCAN_MCR_SRX_DIS;
>>>> 
>>>> -    /* MCR - CAN-FD */
>>>> -    if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
>>>> +    /* MCR, CTRL2
>>>> +     *
>>>> +     * CAN-FD mode
>>>> +     * ISO CAN-FD mode
>>>> +     */
>>>> +    reg_ctrl2 = priv->read(&regs->ctrl2);
>>>> +    if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
>>>>          reg_mcr |= FLEXCAN_MCR_FDEN;
>>>> -    else
>>>> +        reg_ctrl2 |= FLEXCAN_CTRL2_ISOCANFDEN;
>>>> +    } else {
>>>>          reg_mcr &= ~FLEXCAN_MCR_FDEN;
>>>> +    }
>>>> +
>>>> +    if (priv->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO)
>>>> +        reg_ctrl2 &= ~FLEXCAN_CTRL2_ISOCANFDEN;

[1]

>> [..]
>>> ip link set can0 up type can bitrate 1000000 dbitrate 5000000 fd on
>>> ip link set can0 up type can bitrate 1000000 dbitrate 5000000 fd on \
>>>    fd-non-iso on
>> 
>> vs.
>> 
>>> ip link set can0 up type can bitrate 1000000 dbitrate 5000000 
>>> fd-non-iso on
>> 
>> I haven't found anything if CAN_CTRLMODE_FD_NON_ISO depends on
>> CAN_CTRLMODE_FD. I.e. wether CAN_CTRLMODE_FD_NON_ISO can only be set 
>> if
>> CAN_CTRLMODE_FD is also set.
>> 
>> Only the following piece of code, which might be a hint that you
>> have to set CAN_CTRLMODE_FD if you wan't to use 
>> CAN_CTRLMODE_FD_NON_ISO:
>> 
>> drivers/net/can/dev.c:
>>    /* do not check for static fd-non-iso if 'fd' is disabled */
>>    if (!(maskedflags & CAN_CTRLMODE_FD))
>>            ctrlstatic &= ~CAN_CTRLMODE_FD_NON_ISO;
>> 
>> If CAN_CTRLMODE_FD_NON_ISO can be set without CAN_CTRLMODE_FD, what
>> should be the mode if both are set at the same time?
> 
> CAN_CTRLMODE_FD_NON_ISO is only relevant when CAN_CTRLMODE_FD is set.
> 
> So in the example from above
> 
> ip link set can0 up type can bitrate 1000000 dbitrate 5000000 
> fd-non-iso on
> 
> either the setting of 'dbitrate 5000000' and 'fd-non-iso on' is 
> pointless.
> 
> When switching to FD-mode with 'fd on' the FD relevant settings need
> to be applied.
> 
> FD ISO is the default.
> 
> Did this help or did I get anything wrong?

Thanks for the explanation. Yes this helped a great deal and this
patch should be correct; it sets ISO mode if CAN_CTRLMODE_FD is set
and masks it again if CAN_CTRLMODE_FD_NON_ISO is set. See [1].

-michael
