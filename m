From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] can: mark expected switch fall-throughs
Date: Mon, 18 Feb 2019 20:57:45 -0600
Message-ID: <638c5b62-ac3e-21d3-4ac4-0fad0ef8d9e8@embeddedor.com>
References: <20190129180612.GA28650@embeddedor>
 <432a9399-95f4-e988-5cd2-93340f155fa1@microchip.com>
 <daae008e-35fd-7553-fcb2-7932fe53b959@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <daae008e-35fd-7553-fcb2-7932fe53b959@embeddedor.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas.Ferre@microchip.com, wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
List-Id: linux-can.vger.kernel.org

Hi,

Friendly ping:

Dave, I wonder if you can take this.

Thanks
--
Gustavo

On 2/14/19 3:37 PM, Gustavo A. R. Silva wrote:
> 
> 
> On 1/30/19 2:11 AM, Nicolas.Ferre@microchip.com wrote:
>> On 29/01/2019 at 19:06, Gustavo A. R. Silva wrote:
>>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>>> where we are expecting to fall through.
>>>
>>> This patch fixes the following warnings:
>>>
>>> drivers/net/can/peak_canfd/peak_pciefd_main.c:668:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>> drivers/net/can/spi/mcp251x.c:875:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>> drivers/net/can/usb/peak_usb/pcan_usb.c:422:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>> drivers/net/can/at91_can.c:895:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>> drivers/net/can/at91_can.c:953:15: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>> drivers/net/can/usb/peak_usb/pcan_usb.c: In function ‘pcan_usb_decode_error’:
>>> drivers/net/can/usb/peak_usb/pcan_usb.c:422:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>>     if (n & PCAN_USB_ERROR_BUS_LIGHT) {
>>>        ^
>>> drivers/net/can/usb/peak_usb/pcan_usb.c:428:2: note: here
>>>    case CAN_STATE_ERROR_WARNING:
>>>    ^~~~
>>>
>>> Warning level 3 was used: -Wimplicit-fallthrough=3
>>>
>>> This patch is part of the ongoing efforts to enabling
>>> -Wimplicit-fallthrough.
>>>
>>> Notice that in some cases spelling mistakes were fixed.
>>> In other cases, the /* fall through */ comment is placed
>>> at the bottom of the case statement, which is what GCC
>>> is expecting to find.
>>>
>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>> ---
>>>   drivers/net/can/at91_can.c                    | 6 ++++--
>>
>> For this one:
>> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>>
> 
> Thanks, Nicolas.
> 
> Dave:
> 
> I wonder if you can take this patch.
> 
> Thanks
> --
> Gustavo
> 
>>>   drivers/net/can/peak_canfd/peak_pciefd_main.c | 2 +-
>>>   drivers/net/can/spi/mcp251x.c                 | 3 ++-
>>>   drivers/net/can/usb/peak_usb/pcan_usb.c       | 2 +-
>>>   4 files changed, 8 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
>>> index d98c69045b17..1718c20f9c99 100644
>>> --- a/drivers/net/can/at91_can.c
>>> +++ b/drivers/net/can/at91_can.c
>>> @@ -902,7 +902,8 @@ static void at91_irq_err_state(struct net_device *dev,
>>>   				CAN_ERR_CRTL_TX_WARNING :
>>>   				CAN_ERR_CRTL_RX_WARNING;
>>>   		}
>>> -	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
>>> +		/* fall through */
>>> +	case CAN_STATE_ERROR_WARNING:
>>>   		/*
>>>   		 * from: ERROR_ACTIVE, ERROR_WARNING
>>>   		 * to  : ERROR_PASSIVE, BUS_OFF
>>> @@ -951,7 +952,8 @@ static void at91_irq_err_state(struct net_device *dev,
>>>   		netdev_dbg(dev, "Error Active\n");
>>>   		cf->can_id |= CAN_ERR_PROT;
>>>   		cf->data[2] = CAN_ERR_PROT_ACTIVE;
>>> -	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
>>> +		/* fall through */
>>> +	case CAN_STATE_ERROR_WARNING:
>>>   		reg_idr = AT91_IRQ_ERRA | AT91_IRQ_WARN | AT91_IRQ_BOFF;
>>>   		reg_ier = AT91_IRQ_ERRP;
>>>   		break;
>>> diff --git a/drivers/net/can/peak_canfd/peak_pciefd_main.c b/drivers/net/can/peak_canfd/peak_pciefd_main.c
>>> index c458d5fdc8d3..e4f4d65a76b4 100644
>>> --- a/drivers/net/can/peak_canfd/peak_pciefd_main.c
>>> +++ b/drivers/net/can/peak_canfd/peak_pciefd_main.c
>>> @@ -668,7 +668,7 @@ static int pciefd_can_probe(struct pciefd_board *pciefd)
>>>   		pciefd_can_writereg(priv, CANFD_CLK_SEL_80MHZ,
>>>   				    PCIEFD_REG_CAN_CLK_SEL);
>>>   
>>> -		/* fallthough */
>>> +		/* fall through */
>>>   	case CANFD_CLK_SEL_80MHZ:
>>>   		priv->ucan.can.clock.freq = 80 * 1000 * 1000;
>>>   		break;
>>> diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
>>> index e90817608645..17257c73c302 100644
>>> --- a/drivers/net/can/spi/mcp251x.c
>>> +++ b/drivers/net/can/spi/mcp251x.c
>>> @@ -875,7 +875,8 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
>>>   			if (new_state >= CAN_STATE_ERROR_WARNING &&
>>>   			    new_state <= CAN_STATE_BUS_OFF)
>>>   				priv->can.can_stats.error_warning++;
>>> -		case CAN_STATE_ERROR_WARNING:	/* fallthrough */
>>> +			/* fall through */
>>> +		case CAN_STATE_ERROR_WARNING:
>>>   			if (new_state >= CAN_STATE_ERROR_PASSIVE &&
>>>   			    new_state <= CAN_STATE_BUS_OFF)
>>>   				priv->can.can_stats.error_passive++;
>>> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
>>> index 13238a72a338..eca785532b6b 100644
>>> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
>>> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
>>> @@ -423,7 +423,7 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
>>>   			new_state = CAN_STATE_ERROR_WARNING;
>>>   			break;
>>>   		}
>>> -		/* else: fall through */
>>> +		/* fall through */
>>>   
>>>   	case CAN_STATE_ERROR_WARNING:
>>>   		if (n & PCAN_USB_ERROR_BUS_HEAVY) {
>>>
>>
>>
