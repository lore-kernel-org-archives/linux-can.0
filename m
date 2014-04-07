From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] c_can: Add support for eg20t (pch_can)
Date: Mon, 07 Apr 2014 12:19:17 +0200
Message-ID: <53427BA5.3050601@grandegger.com>
References: <1396534451-9654-1-git-send-email-alexander.stein@systec-electronic.com> <533DAB54.8010008@grandegger.com> <9040333.kfdMrH1CV1@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:53199 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510AbaDGKTY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Apr 2014 06:19:24 -0400
In-Reply-To: <9040333.kfdMrH1CV1@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On 04/07/2014 11:47 AM, Alexander Stein wrote:
> Hello Wolfgang,
> 
> On Thursday 03 April 2014 20:41:24, Wolfgang Grandegger wrote:
>> On 04/03/2014 04:14 PM, Alexander Stein wrote:
>>> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
>>
>> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
>>
>> In my patch stack I have also th patch below. Could you please give it
>> I try before I re-submit it. Thanks.
> 
> With this patch the driver still works, at least MSI is working. The other problems still exist.

I have taking this code from pch_can.c. PCI bus master is only required
for MSI. It will not curer the other problems, of course. I will roll
out this patch when your patch has been accepted.

Thanks for testing.

Wolfgang.

