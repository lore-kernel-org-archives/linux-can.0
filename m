From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] can: mark expected switch fall-throughs
Date: Wed, 8 May 2019 12:30:50 -0500
Message-ID: <0527d7c5-78f8-d581-1960-7ceda8bc3f49@embeddedor.com>
References: <20190129180612.GA28650@embeddedor>
 <31d206cd-65f2-66be-ed79-583210a88d57@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <31d206cd-65f2-66be-ed79-583210a88d57@pengutronix.de>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
List-Id: linux-can.vger.kernel.org

Hi Marc,

On 2/26/19 2:02 AM, Marc Kleine-Budde wrote:
> On 1/29/19 7:06 PM, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>>
>> This patch fixes the following warnings:
>>
>> drivers/net/can/peak_canfd/peak_pciefd_main.c:668:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> drivers/net/can/spi/mcp251x.c:875:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> drivers/net/can/usb/peak_usb/pcan_usb.c:422:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> drivers/net/can/at91_can.c:895:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> drivers/net/can/at91_can.c:953:15: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> drivers/net/can/usb/peak_usb/pcan_usb.c: In function ‘pcan_usb_decode_error’:
>> drivers/net/can/usb/peak_usb/pcan_usb.c:422:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>    if (n & PCAN_USB_ERROR_BUS_LIGHT) {
>>       ^
>> drivers/net/can/usb/peak_usb/pcan_usb.c:428:2: note: here
>>   case CAN_STATE_ERROR_WARNING:
>>   ^~~~
>>
>> Warning level 3 was used: -Wimplicit-fallthrough=3
>>
>> This patch is part of the ongoing efforts to enabling
>> -Wimplicit-fallthrough.
>>
>> Notice that in some cases spelling mistakes were fixed.
>> In other cases, the /* fall through */ comment is placed
>> at the bottom of the case statement, which is what GCC
>> is expecting to find.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Added to linux-can-next.
> 

I wonder if there is any chance for this patch to be queued up for 5.2-rc1.

Thanks
