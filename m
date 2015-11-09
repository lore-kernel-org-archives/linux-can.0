From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can-doc: Add missing semicolon to example
Date: Mon, 09 Nov 2015 19:01:03 +0100
Message-ID: <5640DF5F.8070008@hartkopp.net>
References: <1447075029-22711-1-git-send-email-rumpelsepp@sevenbyte.org> <56409DB3.6040803@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:60321 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbbKISBM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Nov 2015 13:01:12 -0500
In-Reply-To: <56409DB3.6040803@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Stefan Tatschner <rumpelsepp@sevenbyte.org>
Cc: linux-can <linux-can@vger.kernel.org>



On 09.11.2015 14:20, Marc Kleine-Budde wrote:
> On 11/09/2015 02:17 PM, Stefan Tatschner wrote:
>> The example code for CAN_BCM,
>>
>> 	connect(s, (struct sockaddr *)&addr, sizeof(addr))
>>
>> lacks a semicolon at the end of the line. This patch adds that
>> missing semicolon to ensure that the given code snippet actually
>> compiles.
>>
>> Signed-off-by: Stefan Tatschner <rumpelsepp@sevenbyte.org>
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
>
> Jonathan, feel free to take the patch via your tree.
>
> regards,
> Marc
>

Hi Marc,

I was pretty disappointed that my last patch needed more than six weeks to 
emerge in Linus' merge window tree, where it needs additional three month 
until release. When this happens again, we'll have this doc fix in Linux 4.5 - 
for what reason?

I would suggest to send these kinds of doc fixes and enhancements together 
with other CAN fixes via Daves net tree without this needless delay.

Regards,
Oliver

>> ---
>>   Documentation/networking/can.txt | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/networking/can.txt b/Documentation/networking/can.txt
>> index 4636b94..05fd83b 100644
>> --- a/Documentation/networking/can.txt
>> +++ b/Documentation/networking/can.txt
>> @@ -681,7 +681,7 @@ solution for a couple of reasons:
>>       addr.can_family = AF_CAN;
>>       addr.can_ifindex = ifr.ifr_ifindex;
>>
>> -    connect(s, (struct sockaddr *)&addr, sizeof(addr))
>> +    connect(s, (struct sockaddr *)&addr, sizeof(addr));
>>
>>       (..)
>>
>>
>
>
