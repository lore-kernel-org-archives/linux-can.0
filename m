From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH][next] can: at91_can: mark expected switch fall-throughs
Date: Thu, 14 Feb 2019 15:33:18 -0600
Message-ID: <79441694-59e4-8c75-87bc-8916779631d1@embeddedor.com>
References: <20190208184444.GA28484@embeddedor>
 <8119fbe8-5f4b-e45c-6687-ec42aceb3428@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <8119fbe8-5f4b-e45c-6687-ec42aceb3428@microchip.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Nicolas.Ferre@microchip.com, wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org



On 2/11/19 3:03 AM, Nicolas.Ferre@microchip.com wrote:
> On 08/02/2019 at 19:44, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch
>> cases where we are expecting to fall through.
>>
>> Notice that, in this particular case, the /* fall through */
>> comments are placed at the bottom of the case statement, which
>> is what GCC is expecting to find.
>>
>> Warning level 3 was used: -Wimplicit-fallthrough=3
>>
>> This patch is part of the ongoing efforts to enabling
>> -Wimplicit-fallthrough.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Looks good to me:
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> 

Thanks, Nicolas.

--
Gustavo

>> ---
>>   drivers/net/can/at91_can.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
>> index d98c69045b17..1718c20f9c99 100644
>> --- a/drivers/net/can/at91_can.c
>> +++ b/drivers/net/can/at91_can.c
>> @@ -902,7 +902,8 @@ static void at91_irq_err_state(struct net_device *dev,
>>   				CAN_ERR_CRTL_TX_WARNING :
>>   				CAN_ERR_CRTL_RX_WARNING;
>>   		}
>> -	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
>> +		/* fall through */
>> +	case CAN_STATE_ERROR_WARNING:
>>   		/*
>>   		 * from: ERROR_ACTIVE, ERROR_WARNING
>>   		 * to  : ERROR_PASSIVE, BUS_OFF
>> @@ -951,7 +952,8 @@ static void at91_irq_err_state(struct net_device *dev,
>>   		netdev_dbg(dev, "Error Active\n");
>>   		cf->can_id |= CAN_ERR_PROT;
>>   		cf->data[2] = CAN_ERR_PROT_ACTIVE;
>> -	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
>> +		/* fall through */
>> +	case CAN_STATE_ERROR_WARNING:
>>   		reg_idr = AT91_IRQ_ERRA | AT91_IRQ_WARN | AT91_IRQ_BOFF;
>>   		reg_ier = AT91_IRQ_ERRP;
>>   		break;
>>
> 
> 
