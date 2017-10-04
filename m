From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: MCP2517FD Bus-Off recovery
Date: Wed, 4 Oct 2017 22:36:43 +0200
Message-ID: <c7d59770-af79-9846-538c-a4d39770b439@grandegger.com>
References: <883AF5B5924A484BBBA6684EAC878AEAC573DF@CHN-SV-EXMX02.mchp-main.com>
 <97b73ce1-4692-6d30-52b2-787e13d71bf9@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy02.manitu.net ([217.11.48.66]:44766 "EHLO
        mailproxy02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbdJDUgo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2017 16:36:44 -0400
In-Reply-To: <97b73ce1-4692-6d30-52b2-787e13d71bf9@grandegger.com>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marcel.Birthelmer@microchip.com, linux-can@vger.kernel.org

Am 04.10.2017 um 19:31 schrieb Wolfgang Grandegger:
> Hello Marcel,
> 
> Am 04.10.2017 um 18:32 schrieb Marcel.Birthelmer@microchip.com:
>> Hi all,
>> I'm working on a driver for the new MCP2517FD CAN controller (http://www.microchip.com/wwwproducts/en/MCP2517FD). This is a substantially different device from the MCP2515 so it's a separate driver.
> 
> Great!
> 
>> My question pertains to error recovery. This device automatically recovers from Bus-Off to Error-Active after some internal delay (see fig.11-1 of the Family Reference Manual). The ISR detects this state change, but I'm not sure how to handle it in regards to can_restart. Should I just update call netif_carrier_on and netif_wake_queue from the ISR to put the device back into normal mode?
> 
> Have a look to the "at91_can" driver. If "restart_ms" is "0", the
> automatic recovery will be used. If not, the controller will be stopped:

That's not correct. If "restart_ms" is "0" the controller will be 
stopped waiting for manual restart. Otherwise automatic recovery will be 
used. The "grcan" driver uses the same logic.
> http://elixir.free-electrons.com/linux/latest/source/drivers/net/can/at91_can.c#L962
> 
> In case of automatic recovery, the CAN controller usually signals
> back to error passive -> warning -> active. When it's back to error
> passive, netif_wake_queue etc. should be called:
> 
> http://elixir.free-electrons.com/linux/latest/source/drivers/net/can/at91_can.c#L922
> 
> Can automatic recovery be switched off?
> 
>>
>> Also, should the CAN state really be set to CAN_STATE_BUS_OFF while the device is in bus-off mode, since it will recover automatically and there's no explicit "restart" action?
> 
> Yes, the bus-off and restart (back to error active) should be visible
> in user-space.

Wolfgang.
