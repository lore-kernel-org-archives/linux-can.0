From: Felix Obenhuber <felix@obenhuber.de>
Subject: Re: isobus with transport protocol
Date: Thu, 14 Feb 2013 09:53:05 +0100
Message-ID: <CAJsOQGNZcKYAe79kdJSZsA4MxOU2cC_+L7p6-x9XJcqsN-vL2A@mail.gmail.com>
References: <CAJsOQGO3bHsCqJ9kr=h0XZHxZ5wPejcPgV7WyCUp2HKYzZx0WQ@mail.gmail.com>
	<5113851F.1060501@pengutronix.de>
	<CAJsOQGMbTkJfc8YYiTdhc9r3aT1mD9MfGmWL3u=DwOmPojNLiw@mail.gmail.com>
	<20130213085946.GA47662@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:41587 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756446Ab3BNIxH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 14 Feb 2013 03:53:07 -0500
Received: by mail-qc0-f175.google.com with SMTP id j3so784972qcs.34
        for <linux-can@vger.kernel.org>; Thu, 14 Feb 2013 00:53:06 -0800 (PST)
In-Reply-To: <20130213085946.GA47662@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: kurt.van.dijck@eia.be, linux-can@vger.kernel.org

Hi Kurt,

On Wed, Feb 13, 2013 at 9:59 AM, Kurt Van Dijck <kurt.van.dijck@eia.be> wrote:
>> We're working with ISOBUS systems (ISO11783). During a transport
>> protocol session
>
> As you know, I've put a j1939 (and ISOBUS) stack on
> https://gitorious.org/linux-can/linux-can-j1939

Yep. Great work.

>> There are multiple
>> software modules that might send frames at the same time over  a
>> single module/socket.
> It does allow for multiple software modules to cooperate
> both on the same & on different logical ECU's (Source addresses),
> and provides a transport protocol without IPC overhead or race conditions.
>
> Can you explain what it is missing for your needs?
> I may be able to help you to get things running.

We're developing a ISOBUS stack (isoaglib.org) that runs on various
platforms. SocketCAN support has been added some time ago. With a
redesign of the HAL we got a new requirement for the CAN driver/api to
deliver the amount of frames that can be queued for transmission.
Without that information we just assume, that the hardware is able to
transmit at least about 3 frames per ms. Cause of the transport
procotol definition we don't get a problem to overflow the tx queue
cause the interation with the tp counterpart slows down the
communication by nature (RTS/CTS...). Having the exact amount of
frames available that can get queued at a certain time is just a
optimization for the internal timings of the protocol stack. It's
running fine without - I just liked to add that in order to speed
things up a little bit.

Yes - we thought about using your J1939 stack for the lower layers of
IsoAgLib. The network and network managent (part 3 and 5) are somehow
boring (as you know ;-). With the current main focus on non Linux ECUs
this is not an option in order to avoid to maintain different ports.
The advantages of IsoAgLib are the high level user APIs for part
6,7,9,10 and12. I'm pretty sure you already got a look at...

cheers,

Felix
