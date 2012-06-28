From: Hui Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH] can: flexcan: use of_property_read_u32 to avoid endian
 problem
Date: Thu, 28 Jun 2012 13:18:19 +0800
Message-ID: <4FEBE91B.3020709@gmail.com>
References: <1340852337-19840-1-git-send-email-jason77.wang@gmail.com> <CAAQ0ZWTE=sF7-bnL6RZ8BuUQEmH+YtRE5J2A+mqsMPpsf6W_vw@mail.gmail.com> <4FEBE648.7040007@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:38748 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989Ab2F1FSt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Jun 2012 01:18:49 -0400
In-Reply-To: <4FEBE648.7040007@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Shawn Guo <shawn.guo@linaro.org>, Hui Wang <jason77.wang@gmail.com>, mkl@pengutronix.de, wg@grandegger.com, linux-can@vger.kernel.org

Oliver Hartkopp wrote:
> The first patch (you wanted to superseed) has already been pulled from Dave
> Miller, see:
>
> http://git.kernel.org/?p=linux/kernel/git/davem/net.git;a=commitdiff;h=85f2f834e85517307f13e30e630a5fc86f757cb5
>
> If you want to update your patch you need to do this based on your already
> accepted patch.
>   
Got it, i will generate an incremental patch basing on it.
> Regards,
> Oliver
>
> Btw. no need to put Dave Miller in all your CAN-related postings in CC. He
> get's hundreds of mails each day ...
>   
OK.

Regards,
Hui.
> On 28.06.2012 05:32, Shawn Guo wrote:
>
>   
>> On 28 June 2012 10:58, Hui Wang <jason77.wang@gmail.com> wrote:
>>     
>>> Use of_property_read_u32() to get DT value can avoid endian problems,
>>> this is needed since this driver can run on powerpc (be) and arm (le).
>>>
>>> No need to check ret value here since we will check the got value to
>>> verify if users pass a valid value in the DT.
>>>
>>> Cc: linux-can@vger.kernel.org
>>> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
>>> Cc: David S. Miller <davem@davemloft.net>
>>> Cc: Shawn Guo <shawn.guo@linaro.org>
>>>       
>> Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
>>
>>     
>>> Cc: Wolfgang Grandegger <wg@grandegger.com>
>>> Signed-off-by: Hui Wang <jason77.wang@gmail.com>
>>>       
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-can" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>     
>
>
>
>   

