From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] can: mark expected switch fall-throughs
Date: Thu, 14 Feb 2019 17:04:03 -0600
Message-ID: <a8e53868-2b13-b050-7714-e3e24d18cf00@embeddedor.com>
References: <20190129180612.GA28650@embeddedor>
 <432a9399-95f4-e988-5cd2-93340f155fa1@microchip.com>
 <daae008e-35fd-7553-fcb2-7932fe53b959@embeddedor.com>
 <20190214221703.GQ10129@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214221703.GQ10129@piout.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Nicolas.Ferre@microchip.com, wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, Ludovic.Desroches@microchip.com, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
List-Id: linux-can.vger.kernel.org



On 2/14/19 4:17 PM, Alexandre Belloni wrote:
> Hi,
> 
> On 14/02/2019 15:37:26-0600, Gustavo A. R. Silva wrote:
>>
>>
>> On 1/30/19 2:11 AM, Nicolas.Ferre@microchip.com wrote:
>>> On 29/01/2019 at 19:06, Gustavo A. R. Silva wrote:
>>>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>>>> where we are expecting to fall through.
>>>>
>>>> This patch fixes the following warnings:
>>>>
>>>> drivers/net/can/peak_canfd/peak_pciefd_main.c:668:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>>> drivers/net/can/spi/mcp251x.c:875:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>>> drivers/net/can/usb/peak_usb/pcan_usb.c:422:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>>> drivers/net/can/at91_can.c:895:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>>> drivers/net/can/at91_can.c:953:15: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>>> drivers/net/can/usb/peak_usb/pcan_usb.c: In function ‘pcan_usb_decode_error’:
>>>> drivers/net/can/usb/peak_usb/pcan_usb.c:422:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>>>     if (n & PCAN_USB_ERROR_BUS_LIGHT) {
>>>>        ^
>>>> drivers/net/can/usb/peak_usb/pcan_usb.c:428:2: note: here
>>>>    case CAN_STATE_ERROR_WARNING:
>>>>    ^~~~
>>>>
>>>> Warning level 3 was used: -Wimplicit-fallthrough=3
>>>>
>>>> This patch is part of the ongoing efforts to enabling
>>>> -Wimplicit-fallthrough.
>>>>
>>>> Notice that in some cases spelling mistakes were fixed.
>>>> In other cases, the /* fall through */ comment is placed
>>>> at the bottom of the case statement, which is what GCC
>>>> is expecting to find.
>>>>
>>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>>> ---
>>>>   drivers/net/can/at91_can.c                    | 6 ++++--
>>>
>>> For this one:
>>> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>>>
>>
>> Thanks, Nicolas.
>>
> 
> I though I had a déjà vu but you actually sent the at91 part twice.
> 

It wasn't intentional.

>> Dave:
>>
>> I wonder if you can take this patch.
>>
>> Thanks
>> --
>> Gustavo
>>
>>>>   drivers/net/can/peak_canfd/peak_pciefd_main.c | 2 +-
>>>>   drivers/net/can/spi/mcp251x.c                 | 3 ++-
>>>>   drivers/net/can/usb/peak_usb/pcan_usb.c       | 2 +-
>>>>   4 files changed, 8 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
>>>> index d98c69045b17..1718c20f9c99 100644
>>>> --- a/drivers/net/can/at91_can.c
>>>> +++ b/drivers/net/can/at91_can.c
>>>> @@ -902,7 +902,8 @@ static void at91_irq_err_state(struct net_device *dev,
>>>>   				CAN_ERR_CRTL_TX_WARNING :
>>>>   				CAN_ERR_CRTL_RX_WARNING;
>>>>   		}
>>>> -	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
>>>> +		/* fall through */
>>>> +	case CAN_STATE_ERROR_WARNING:
>>>>   		/*
>>>>   		 * from: ERROR_ACTIVE, ERROR_WARNING
>>>>   		 * to  : ERROR_PASSIVE, BUS_OFF
>>>> @@ -951,7 +952,8 @@ static void at91_irq_err_state(struct net_device *dev,
>>>>   		netdev_dbg(dev, "Error Active\n");
>>>>   		cf->can_id |= CAN_ERR_PROT;
>>>>   		cf->data[2] = CAN_ERR_PROT_ACTIVE;
>>>> -	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
> 
> Seriously, for that one, you should fix the compiler. The fall through

I'll pass your feedback on to the GCC guys.

> is not implicit, it is actually quite explicit and the warning is simply
> wrong.
> 
> Also, the gcc documentation says that -Wimplicit-fallthrough=3
> recognizes /* fallthrough */ as a proper fall through comment (and I
> tested with gcc 8.2).
> 

Yeah. But that's not the relevant change in this case.  Notice that the
comment was moved to the very bottom of the previous case.

Thanks
--
Gustavo
