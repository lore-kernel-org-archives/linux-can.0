From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH RESEND next 1/2] net: can: mscan: add a comment on reg
 to idx mapping
Date: Sun, 25 Aug 2013 18:42:01 +0200
Message-ID: <521A33D9.7050605@hartkopp.net>
References: <1377256144-4173-1-git-send-email-agust@denx.de> <52174782.6080002@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:27447 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376Ab3HYQmF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 25 Aug 2013 12:42:05 -0400
In-Reply-To: <52174782.6080002@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On 23.08.2013 13:29, Marc Kleine-Budde wrote:
> On 08/23/2013 01:09 PM, Anatolij Gustschin wrote:
>> From: Gerhard Sittig <gsi@denx.de>
>>
>> add a comment about the magic of deriving an MSCAN component index
>> from the peripheral's physical address / register offset
>>
>> Cc: linux-can@vger.kernel.org
>> Cc: netdev@vger.kernel.org
>> Signed-off-by: Gerhard Sittig <gsi@denx.de>
>> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> 
> Tnx, both applied to linux-can-next/testing. Will be included in the net
> pull request to Daivd.

For net-next or for net?

When this stuff would be for net-next i could add a new feature for can-gw too ...

So that there's not always only one lonely item to pull for Dave ;-)

Regards,
Oliver


