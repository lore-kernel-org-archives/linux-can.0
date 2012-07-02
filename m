From: Hui Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH v2 1/2] can: flexcan: use of_property_read_u32 to get
 DT entry value
Date: Mon, 2 Jul 2012 10:33:10 +0800
Message-ID: <4FF10866.2060608@gmail.com>
References: <1340871695-26327-1-git-send-email-jason77.wang@gmail.com> <1340871695-26327-2-git-send-email-jason77.wang@gmail.com> <4FEC3078.2090706@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:41171 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754272Ab2GBCdd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 1 Jul 2012 22:33:33 -0400
In-Reply-To: <4FEC3078.2090706@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Hui Wang <jason77.wang@gmail.com>, wg@grandegger.com, shawn.guo@linaro.org, linux-can@vger.kernel.org

Marc Kleine-Budde wrote:
> On 06/28/2012 10:21 AM, Hui Wang wrote:
>   
>> of_property_read_u32() can auto handle endian problems, use this
>> function can make code clean and simple.
>>
>> No need to check return value here since the following got value
>> check will handle this.
>>     
>
> Should this go to v3.5 or to net-next? If it goes via net-next, I have
> to delay it until David merges net (which has the be32_to_cpup fix).
>
> Marc
>
>   
It is for net-next.

Thanks,
Hui.

