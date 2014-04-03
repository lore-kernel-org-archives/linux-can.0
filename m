From: Ratheendran <ba.rsrajeshwaran@tataelxsi.co.in>
Subject: Re: Regarding  J1939 support on freescale imx6 BSP
Date: Thu, 3 Apr 2014 11:59:11 +0530
Message-ID: <533CFFB7.3020300@tataelxsi.co.in>
References: <533BAD63.80202@tataelxsi.co.in> <20140402183759.GA4780@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-hk1lp0121.outbound.protection.outlook.com ([207.46.51.121]:29840
	"EHLO APAC01-HK1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162285AbaDCGaF (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 3 Apr 2014 02:30:05 -0400
In-Reply-To: <20140402183759.GA4780@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: linux-can@vger.kernel.org

Hi Kurt,

Thanks for your response,

I just confirmed from my team ,we want j1939  stack into our socketCAN 
layer.

is j1939  stack part of mainstream kernel? do I need to manually update 
my Linux BSP with the source code and resolve the conflicts.

Going further, I want to implement this as a patch with the yocto build, 
what is the best way to move ahead.


Thanks,
Ratheendran

On 4/3/2014 12:07 AM, Kurt Van Dijck wrote:
> Hi Ratheendran,
>
> On Wed, Apr 02, 2014 at 11:55:39AM +0530, Ratheendran wrote:
>> Hi All,
>>
>> I am new to Linux CAN module, want to know the how I can include
>> this J1939 support in my free-scale imx6 BSP. do you have a
>> ready-made patch.
>>
>> Please note, there is no requirement that the driver handle J1939
>> protocol, it must simply allow J1939 to be fully functional.
> Do you refer to my J1939 stack in the linux kernel tree that you can find at
> git@gitorious.org:linux-can/linux-can-j1939.git ?
>
> Or is it something else that you seek?
> That is not clear to me.
>
> Kind regards,
> Kurt
> .
>

