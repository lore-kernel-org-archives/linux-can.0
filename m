From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH can-next] can: add missing initialization of CAN
 statistics
Date: Wed, 6 Jul 2016 09:27:48 +0200
Message-ID: <8cdd1516-508e-6fc5-ff58-b61181376479@hartkopp.net>
References: <1467789546-25178-1-git-send-email-socketcan@hartkopp.net>
 <b3c32a37-d6bc-4d99-1a9b-4a0fb79460b2@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:10593 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbcGFH14 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 6 Jul 2016 03:27:56 -0400
In-Reply-To: <b3c32a37-d6bc-4d99-1a9b-4a0fb79460b2@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org



On 07/06/2016 09:24 AM, Marc Kleine-Budde wrote:
> On 07/06/2016 09:19 AM, Oliver Hartkopp wrote:


>> +void can_init_stats(void)
>> +{
>> +	memset(&can_pstats, 0, sizeof(can_pstats));
>> +	memset(&can_stats, 0, sizeof(can_stats));
>
> I think this is not needed, as both are global variables, right?

Yes they are.

Is it assured that global variables are initialized with zero like 
static variables?

If so I can provide a far smaller patch :-)

Oliver

