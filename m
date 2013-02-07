From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Retrieve amount of queued frames in the txqueue of a interface
Date: Thu, 07 Feb 2013 18:43:51 +0100
Message-ID: <5113E7D7.4070807@hartkopp.net>
References: <CAJsOQGO3bHsCqJ9kr=h0XZHxZ5wPejcPgV7WyCUp2HKYzZx0WQ@mail.gmail.com> <5113851F.1060501@pengutronix.de> <CAJsOQGMbTkJfc8YYiTdhc9r3aT1mD9MfGmWL3u=DwOmPojNLiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:13940 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759194Ab3BGRny (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 7 Feb 2013 12:43:54 -0500
In-Reply-To: <CAJsOQGMbTkJfc8YYiTdhc9r3aT1mD9MfGmWL3u=DwOmPojNLiw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Felix Obenhuber <felix@obenhuber.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 07.02.2013 17:18, Felix Obenhuber wrote:

> Hi Marc,
> 
> On Thu, Feb 7, 2013 at 11:42 AM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>> On 02/06/2013 12:59 PM, Felix Obenhuber wrote:
>>> Hi,
>>>
>>> how can I retrive the number of frames currently queued for
>>> transmission on a SocketCAN interface? Is this possible via netlink?
>>
>> Sorry, I don't know. What's you usecase?
> 
> We're working with ISOBUS systems (ISO11783). During a transport
> protocol session (similiar to iso tp) we'd like to know how many
> frames can get queued at once to adjust timings. There are multiple
> software modules that might send frames at the same time over  a
> single module/socket.
> 
> Maybe we have to add a tx fifo within the software...


Probably the Linux queueing disciplines for CAN are interesting for you:

http://rtime.felk.cvut.cz/can/socketcan-qdisc-final.pdf

The funtionality is part of the Linux Kernel since 3.6.

Regards,
Oliver
