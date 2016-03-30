From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: bcmserver.c usage and preconditions
Date: Wed, 30 Mar 2016 13:59:31 +0200
Message-ID: <56FBBFA3.8000907@hartkopp.net>
References: <56FB6BAA.6080304@posteo.de>
 <8fb9bcb24a544baa84b23528f3f239b4@SGPMBX1021.APAC.bosch.com>
 <56FB8F01.5060802@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:39517 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbcC3L7m (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 30 Mar 2016 07:59:42 -0400
In-Reply-To: <56FB8F01.5060802@posteo.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Patrick Menschel <menschel.p@posteo.de>, "Misra Pankaj Kumar (RBEI/EEA2)" <Pankaj.Kumar@in.bosch.com>
Cc: linux-can <linux-can@vger.kernel.org>

Hi Patrick,

On 03/30/2016 10:32 AM, Patrick Menschel wrote:
> Hi Pankaj,
>
> CAN Bus is functional in both directions, rx and tx .
>
> 1. cansend works properly
> 2. candump also works properly
>
> I'm just trying to verify if it's just me or the bcm.

It's you :-)

>>
>> 2. then start bcmserver
>>
>> ~$ bcmserver
>>
>> 3. and input the line
>>
>> ~$ can0 A 1 0 123 8 11 22 33 44 55 66 77 88
>>
>> but unfortunately I don't get any output at all.

The bcmserver creates an IP server listening on port 28600 on localhost.

So you would need to connect this server e.g. with netcat first and then 
type the according command (with '<' and '>' tags!!) into the netcat shell.

Regards,
Oliver
