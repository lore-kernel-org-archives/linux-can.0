From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC PATCH] can: add tx/rx led trigger support
Date: Thu, 12 Apr 2012 17:52:04 +0200
Message-ID: <4F86FA24.9000404@hartkopp.net>
References: <1334093965-2692-1-git-send-email-fabio.baltieri@gmail.com> <4F85D553.2010303@hartkopp.net> <CABkP77eHcrOSG140HF++D9Gt=79gVgGZm5JX6ZVNuc4pjpujcA@mail.gmail.com> <5882451.nUC1A4BOX5@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:46603 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934032Ab2DLPwH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 12 Apr 2012 11:52:07 -0400
In-Reply-To: <5882451.nUC1A4BOX5@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Fabio Baltieri <fabio.baltieri@gmail.com>, linux-can@vger.kernel.org


>>> Is the LED "blinking" on traffic or is it just "on" for some time when a
>>> CAN frame is processed?
>>
>> It stays on for some time after each frame. Above a certain
>> packet-rate (1/led_off_delay) LED appear to be constantly on. You can
>> tell periodic packets from bursts from it but nothing more.
> 
> I think a Tx or Rx trigger should just "start" one LED blink, e.g. ON for 
> 100ms and OFF for 100ms no matter if other packets being processed. This way 
> you will constantly see a LED blinking if a specific load is exceeded. If it 
> is at lower rate the LED will blink more rarely.
> You could even go one step further and activate a LED if the CAN interface is 
> UP and turn it off for some time if there is some traffic. So the LED could 
> inidicate if the interface is being used and/or if there is some traffic.


Hi Alexander,

the latter is implemented in my WIFI LED in my notebook:

Interface up -> LED is ON

Interface traffic -> LED is doing a off-on-sequence which leads to constant
blinking when downloading files ...

Nice idea.

Regards,
Oliver
