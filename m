From: Hui Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH 4/4] can: flexcan: add transceiver switch support when
 use device tree
Date: Wed, 27 Jun 2012 17:55:35 +0800
Message-ID: <4FEAD897.5070408@gmail.com>
References: <1340785161-3598-1-git-send-email-jason77.wang@gmail.com> <1340785161-3598-2-git-send-email-jason77.wang@gmail.com> <1340785161-3598-3-git-send-email-jason77.wang@gmail.com> <1340785161-3598-4-git-send-email-jason77.wang@gmail.com> <1340785161-3598-5-git-send-email-jason77.wang@gmail.com> <4FEAC3AA.500@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:49797 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754512Ab2F0Jzv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Jun 2012 05:55:51 -0400
In-Reply-To: <4FEAC3AA.500@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Hui Wang <jason77.wang@gmail.com>, davem@davemloft.net, shawn.guo@linaro.org, linux-can@vger.kernel.org

Marc Kleine-Budde wrote:
> On 06/27/2012 10:19 AM, Hui Wang wrote:
>   
>> Some platforms (like i.MX6) has an external PHY, the PHY is operated
>> by some gpios. If the system registers a platform_data, we can
>> set a callback function pointer to pdata->transceiver_switch to
>> implement PHY switch. If we use device tree, we couldn't pass
>> platform_data to the driver, so i move the switch function to the
>> driver and add device tree entries to let user set which gpios
>> are used to operate PHY.
>>
>> This design doesn't break existing platforms, if a platform doesn't
>> need PHY switch, it doesn't need to set dt entries just as before,
>> if a platform has platform_data, the pdata->transceiver_switch has
>> higher priority.
>>
>> Cc: linux-can@vger.kernel.org
>> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
>> Cc: David S. Miller <davem@davemloft.net>
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>> Signed-off-by: Hui Wang <jason77.wang@gmail.com>
>>     
>
> please coordinate whith Shawn Guo, he has posted a similar patch some
> days ago. http://www.spinics.net/lists/netdev/msg202442.html
>
> Marc
>
>   
After read and compared with his patch:
1. Shawn use gpio_is_valid(gpio) instead of (gpio >= 0), it is good.
2. Shawn add a flag to record active level, it is good.
3. Shawn only add 1 gpio, this is not enough for imx6 sabre lite board.
4. Shawn forget to call gpio_release()


Shawn, what about your opinion?

Regards,
Hui.
