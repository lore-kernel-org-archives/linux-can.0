From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: MCP2517FD Bus-Off recovery
Date: Thu, 5 Oct 2017 18:56:14 +0200
Message-ID: <c18bbdc5-0ff4-0832-7cc8-ad9901a10952@grandegger.com>
References: <883AF5B5924A484BBBA6684EAC878AEAC573DF@CHN-SV-EXMX02.mchp-main.com>
 <97b73ce1-4692-6d30-52b2-787e13d71bf9@grandegger.com>
 <c7d59770-af79-9846-538c-a4d39770b439@grandegger.com>
 <883AF5B5924A484BBBA6684EAC878AEAC57F61@CHN-SV-EXMX02.mchp-main.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy03.manitu.net ([217.11.48.67]:39436 "EHLO
        mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751335AbdJEQ4R (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2017 12:56:17 -0400
In-Reply-To: <883AF5B5924A484BBBA6684EAC878AEAC57F61@CHN-SV-EXMX02.mchp-main.com>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marcel.Birthelmer@microchip.com, linux-can@vger.kernel.org


Am 05.10.2017 um 17:55 schrieb Marcel.Birthelmer@microchip.com:
> 
> Wolfgang wrote:
>>>
>>> Have a look to the "at91_can" driver. If "restart_ms" is "0", the
>>> automatic recovery will be used. If not, the controller will be stopped:
>>
>> That's not correct. If "restart_ms" is "0" the controller will be stopped waiting
>> for manual restart. Otherwise automatic recovery will be used. The "grcan"
>> driver uses the same logic.
> 
> So it seems like the behavior between the two flows is substantially different - one completely disables the hardware (including the receive mechanism and presumably ACK'ing messages), while the other just temporarily suspends transmission of messages. Is this understanding correct?

Yes, but while the controller is in bus-off, it will not receive or send 
any messages. If we stop the controller brute-force, we must make sure 
that no messages go out or come in. So hardware-wise, the behaviour is 
the same. Well, a bus-off recovery by hardware is different.

>>> http://elixir.free-electrons.com/linux/latest/source/drivers/net/can/a
>>> t91_can.c#L962
>>>
>>> In case of automatic recovery, the CAN controller usually signals back
>>> to error passive -> warning -> active. When it's back to error
>>> passive, netif_wake_queue etc. should be called:
>>>
>>> http://elixir.free-electrons.com/linux/latest/source/drivers/net/can/a
>>> t91_can.c#L922
>>>
>>> Can automatic recovery be switched off?
> 
> No, there's no switch for this feature.

OK,

Wolfgang.
