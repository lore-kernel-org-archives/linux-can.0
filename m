From: Andrea Scian - DAVE Embedded Systems <andrea.scian@dave.eu>
Subject: Re: [PATCH] can: xilinx: fix RX FIFO overflow error handling
Date: Wed, 5 Aug 2015 22:01:28 +0200
Message-ID: <55C26B98.1010401@dave.eu>
References: <1437685986-25824-1-git-send-email-andrea.scian@dave.eu>
 <55B1BBEA.7020506@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx.dave-tech.it ([2.229.21.40]:36750 "EHLO mx.dave-tech.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752162AbbHEUGo (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 5 Aug 2015 16:06:44 -0400
In-Reply-To: <55B1BBEA.7020506@xilinx.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michal Simek <michal.simek@xilinx.com>, Kedareswara rao Appana <appana.durga.rao@xilinx.com>
Cc: mkl@pengutronix.de, wg@grandegger.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org


Michal,
Kedar,

Any feedback regarding my patch?
Have you ever experienced such a problem?

Andrea SCIAN

*DAVE Embedded Systems*
via Talponedo 29/A 33080 Porcia (PN) - Italy
Telephone: +39.0434.921215
Telefax: +39.0434.1994030
web: www.dave.eu <http://www.dave.eu>


Il 24/07/2015 06:15, Michal Simek ha scritto:
> + Kedar
>
> On 07/23/2015 11:13 PM, Andrea Scian wrote:
>> Simply resetting the peripheral on RX FIFO overflow in not enough,
>> because we also need to re-initialize the whole device.
>> Also always enable RX FIFO overflow interrupt otherwise we may hang
>> until another interrupt arrives (this happens if FIFO overrun and just
>> read from CAN bus with candump)
>>
>> Signed-off-by: Andrea Scian <andrea.scian@dave.eu>
>> ---
>>
>> You can reproduce the problem with the following test-bed
>> * connect a Zynq based board to a PC with a CAN bus adapter (e.g. PCAN USB)
>> * start sending lots of CAN messages to Zynq system
>> * configure and start xilinx CAN driver
>> ** canconfig can0 bitrate 1000000
>> ** canconfig can0 start
>> * try to send/receive messages (cansend/candump)
>> * if you send a CAN message you'll get the RX FIFO error and additional messages
>> will not be received
>> * if you try to get messages you simple don't receive them (no interrupt triggered)
>> * with canconfig stop/start the hang goes away (if the others peers stop sending
>> send lots of messages ;-) )
>>
>> I tested the patch over xilinx-2014.04 kernel, but the patch applies cleanly to
>> mainline too.
>>
>> If someone has a better understanding of Xilinx CAN driver, please let me know if
>> it's better to handle the error in a different manner.
>>
>> Maybe the bus off handler need the same threadment too.
>>
>> TIA,
>>
>> Andrea Scian
>>
>> ---
>>   drivers/net/can/xilinx_can.c |    5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
>> index 5e8b560..c278177 100644
>> --- a/drivers/net/can/xilinx_can.c
>> +++ b/drivers/net/can/xilinx_can.c
>> @@ -100,6 +100,7 @@ enum xcan_reg {
>>   #define XCAN_INTR_ALL		(XCAN_IXR_TXOK_MASK | XCAN_IXR_BSOFF_MASK |\
>>   				 XCAN_IXR_WKUP_MASK | XCAN_IXR_SLP_MASK | \
>>   				 XCAN_IXR_RXNEMP_MASK | XCAN_IXR_ERROR_MASK | \
>> +				 XCAN_IXR_RXOFLW_MASK | \
>>   				 XCAN_IXR_ARBLST_MASK | XCAN_IXR_RXOK_MASK)
>>
>>   /* CAN register bit shift - XCAN_<REG>_<BIT>_SHIFT */
>> @@ -526,6 +527,7 @@ static int xcan_rx(struct net_device *ndev)
>>   	return 1;
>>   }
>>
>> +static void xcan_chip_stop(struct net_device *ndev);
>>   /**
>>    * xcan_err_interrupt - error frame Isr
>>    * @ndev:	net_device pointer
>> @@ -597,7 +599,8 @@ static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
>>   	if (isr & XCAN_IXR_RXOFLW_MASK) {
>>   		stats->rx_over_errors++;
>>   		stats->rx_errors++;
>> -		priv->write_reg(priv, XCAN_SRR_OFFSET, XCAN_SRR_RESET_MASK);
>> +		xcan_chip_stop(ndev);
>> +		xcan_chip_start(ndev);
>>   		if (skb) {
>>   			cf->can_id |= CAN_ERR_CRTL;
>>   			cf->data[1] |= CAN_ERR_CRTL_RX_OVERFLOW;
>>
>
