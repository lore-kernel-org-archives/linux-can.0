From: Sebastian Haas <dev@sebastianhaas.info>
Subject: Re: RFC: improve and consolidate state change and bus-off handling
Date: Sat, 03 Dec 2011 10:28:11 +0100
Message-ID: <4ED9EBAB.4060701@sebastianhaas.info>
References: <4ED8948E.5090806@grandegger.com> <4ED89D50.9040401@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:42782 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446Ab1LCJeB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 3 Dec 2011 04:34:01 -0500
In-Reply-To: <4ED89D50.9040401@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Linux-can Mailing List <linux-can@vger.kernel.org>, SocketCAN Core Mailing List <socketcan-core@lists.berlios.de>

Hello,

Am 02.12.2011 10:41, schrieb Marc Kleine-Budde:
> On 12/02/2011 10:04 AM, Wolfgang Grandegger wrote:
>> - Bus-off recovery:
>>
>>    Currently, I think, we do not handle bus-off recovery correctly for
>>    most controllers. We brute-force stop and restart the controller.
>>    The controller will do the recovery cycle anyway and we may send
>>    messages to early. Instead the software should handle the bus-off
>>    recovery cycle as shown below:
>>
>>    * bus-off happens
>>      - call netif_stop_queue() and maybe disable interrupts
>>
>>    * automatic or manual restart is done
Short note from me about that. We should be carefully with automatic 
recovery at driver-level, since this is basically not covered by the 
standard (only the application is allowed to decide whether or not the 
controller shall go back to error active). A bus off is an unusual state 
in a CAN network, because if this happens the network is physically in a 
bad shape (cable length, stub lines, electrical defects) or has a 
logical error (identifier conflicts, different bit-rates). So in my 
opinion the driver shall not allow anyway of automatic recovery and 
shall be up to the application to decide what to do.

>>      - trigger bus-off recovery sequence by resetting the init bit
>>        (on SJA1000) and maybe re-enable the interrupts
>>      - await the controller going back to error-active state
>>        (signaled via interrupt).
>
> I'm not sure if all controllers signal correctly that they are back in
> error active. My observation is that bus off handling is a bit like
> climbing the mount Everest, the air is quite thin and things can lock up
> quite fast.
In a worst case you need to poll for the error state if the controller 
doesn't support correct signalling. But I expect most controllers to 
implement such a feature since this is quite essential for most 
application to know the controller got bus-on/error active.

>>      - call netif_wake_queue()
>>
>>    Here is a "candump -e" output for the SJA1000 (with delta times)
>>
>>      (009.832477)  can0  20000204  [8] 00 30 00 00 00 00 88 00   ERRORFRAME
>> 	controller-problem{tx-error-passive}
>> 	state-change{tx-error-passive}
>> 	error-counter-tx-rx{{136}{0}}
>>      (000.000804)  can0  20000240  [8] 00 00 00 00 00 00 7F 00   ERRORFRAME
>> 	bus-off
>> 	state-change{}
>> 	error-counter-tx-rx{{127}{0}}
>>      (000.099795)  can0  20000100  [8] 00 00 00 00 00 00 7F 00   ERRORFRAME
>> 	restarted-after-bus-off
>> 	error-counter-tx-rx{{127}{0}}
>>      (000.003061)  can0  20000200  [8] 00 40 00 00 00 00 00 00   ERRORFRA
>> 	state-change{back-to-error-active}
>>
>>     Before doing all the necessary code changes, which are not always
>>     trivial I ask: Would that be the correct bus-off handling???
>
> However if hardware permits the described steps sound reasonable (from
> my non CAN expert point of view).
Despite the fact that you misuse a CAN message structure to carry CAN 
error frames, the overall procedure looks quite good.


Cheers,
  Sebastian
