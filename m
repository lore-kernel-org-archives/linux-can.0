From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: fix oops caused by wrong rtnl dellink usage
Date: Thu, 23 Jun 2016 07:52:21 +0200
Message-ID: <21622f73-dad7-50e8-14c4-83c493f1a507@hartkopp.net>
References: <1466516747-5192-1-git-send-email-socketcan@hartkopp.net>
 <3c001239-0c69-65e2-dca3-20c5c4e86017@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:48412 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbcFWFwc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 Jun 2016 01:52:32 -0400
In-Reply-To: <3c001239-0c69-65e2-dca3-20c5c4e86017@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Hi Marc,

I sent two fixes reported by ajneu.

You probably missed this one

http://marc.info/?l=linux-can&m=146650412017263&w=2

which is a stable candidate too.

Regards,
Oliver

On 06/22/2016 10:43 PM, Marc Kleine-Budde wrote:
> On 06/21/2016 03:45 PM, Oliver Hartkopp wrote:
>> For 'real' hardware CAN devices the netlink interface is used to set CAN
>> specific communication parameters. Real CAN hardware can not be created nor
>> removed with the ip tool ...
>>
>> This patch adds a private dellink function for the CAN device driver interface
>> that does just nothing.
>>
>> It's a follow up to commit 993e6f2fd ("can: fix oops caused by wrong rtnl
>> newlink usage") but for dellink.
>>
>> Reported-by: ajneu <ajneu1@gmail.com>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>
> Applied to can + stable on Cc.
>
> Tnx,
> Marc
>
