From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC] K-Line protocol via SocketCAN
Date: Wed, 15 Jun 2016 08:57:49 +0200
Message-ID: <5760FC6D.9030300@hartkopp.net>
References: <573E491E.1000906@denx.de>
 <CAJ=nTsu_bJgj1A5JNJNAd9HAao5493CnofbQpJ_qftYOiCgaYw@mail.gmail.com>
 <573EAE9D.20006@hartkopp.net> <573EFC23.2040906@denx.de>
 <574E47C8.4000709@denx.de> <575415F5.3070306@hartkopp.net>
 <57598472.3070207@denx.de> <5759B597.3060009@hartkopp.net>
 <5759C1D1.1000001@denx.de> <5759CDC9.2010204@hartkopp.net>
 <575C699A.8080000@denx.de> <575DB7F4.3030906@hartkopp.net>
 <575F2E9E.3040307@denx.de> <575F9FBD.2030809@hartkopp.net>
 <5760CEC2.2050701@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:36139 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbcFOG6D (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 15 Jun 2016 02:58:03 -0400
In-Reply-To: <5760CEC2.2050701@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marek Vasut <marex@denx.de>, Mirza Krak <mirza.krak@hostmobility.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

On 06/15/2016 05:42 AM, Marek Vasut wrote:
> On 06/14/2016 08:10 AM, Oliver Hartkopp wrote:
>>
>>>> On 06/11/2016 09:42 PM, Marek Vasut wrote:
>>>>> Well, I was talking about arinc 429 .
>>>>>
>>>>
>>>> Ah - I remember that discussion:
>>>> https://lwn.net/Articles/663130/
>>>> http://thread.gmane.org/gmane.linux.network/385449
>>>>
>>>> What happed to it?
>>>
>>> Priorities shifted. I still hope to return to it and get it into
>>> mainline proper. Since I did some digging in the socketcan recently,
>>> I have a better understanding of it now too. I believe the agreement
>>> there was to put it into the socketcan stack as an extension, does it
>>> still make sense ?
>>>
>>
>> There were intensive discussions about the original patchset and I think
>> the copy&paste hell from the PF_CAN won't make it.
>
> Yeah, that's pretty clear to me. But does it make sense to extend
> socketcan with that arinc429 stuff instead then ?

You might think into the direction of the SLLIN implementation:

Create a ldisc which smells like a CAN interface.
SLLIN doesn't change SocketCAN either.

Regards,
Oliver

