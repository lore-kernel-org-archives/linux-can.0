From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC PATCH] can: add tx/rx led trigger support
Date: Wed, 11 Apr 2012 18:24:14 +0200
Message-ID: <4F85B02E.7070503@hartkopp.net>
References: <1334093965-2692-1-git-send-email-fabio.baltieri@gmail.com> <4F859927.1040404@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:19545 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932488Ab2DKQYM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Apr 2012 12:24:12 -0400
In-Reply-To: <4F859927.1040404@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Fabio Baltieri <fabio.baltieri@gmail.com>, linux-can@vger.kernel.org

On 11.04.2012 16:45, Wolfgang Grandegger wrote:


> On 04/10/2012 11:39 PM, Fabio Baltieri wrote:

>> @@ -52,6 +54,13 @@ struct can_priv {
>>  
>>  	unsigned int echo_skb_max;
>>  	struct sk_buff **echo_skb;
>> +
>> +#ifdef CONFIG_CAN_LEDS
>> +	struct timer_list tx_off_timer, rx_off_timer;
>> +	struct led_trigger *tx_led, *rx_led;
>> +	char tx_led_name[32], rx_led_name[32];
>> +	atomic_t led_discard_count;
>> +#endif
> 
> This requires a lot of space. Please add just *one* pointer here and
> allocate the required space when needed.


Hello Wolfgang,

my argumentation was the other way round.

When CONFIG_CAN_LEDS is set, why do additional kzallocs() at init time and
take care to remove them at exit time?

See: http://marc.info/?l=linux-can&m=133412499123647&w=2

Where i also gave some more details where to implement the rx/tx triggers
which follows your remark too:

> In this file you only find things for CAN protocol support. LEDs should
> be handled by drivers/net/can/dev.c.


Regards,
Oliver
