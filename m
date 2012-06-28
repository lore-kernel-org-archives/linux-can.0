From: Hui Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH 4/4] can: flexcan: add transceiver switch support when
 use device tree
Date: Thu, 28 Jun 2012 09:53:04 +0800
Message-ID: <4FEBB900.9020300@gmail.com>
References: <1340785161-3598-1-git-send-email-jason77.wang@gmail.com>	<1340785161-3598-2-git-send-email-jason77.wang@gmail.com>	<1340785161-3598-3-git-send-email-jason77.wang@gmail.com>	<1340785161-3598-4-git-send-email-jason77.wang@gmail.com>	<1340785161-3598-5-git-send-email-jason77.wang@gmail.com>	<4FEAC3AA.500@pengutronix.de>	<4FEAD897.5070408@gmail.com> <CAAQ0ZWSOJog+S3780wD63ObJ6YUfC9T_zOUPzto3esF-W4fnXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:55920 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447Ab2F1BxX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Jun 2012 21:53:23 -0400
In-Reply-To: <CAAQ0ZWSOJog+S3780wD63ObJ6YUfC9T_zOUPzto3esF-W4fnXw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Hui Wang <jason77.wang@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>, davem@davemloft.net, linux-can@vger.kernel.org

Shawn Guo wrote:
> On 27 June 2012 17:55, Hui Wang <jason77.wang@gmail.com> wrote:
>   
>> After read and compared with his patch:
>> 1. Shawn use gpio_is_valid(gpio) instead of (gpio >= 0), it is good.
>> 2. Shawn add a flag to record active level, it is good.
>> 3. Shawn only add 1 gpio, this is not enough for imx6 sabre lite board.
>> 4. Shawn forget to call gpio_release()
>>     
>
> I'm about to resend my series to have linux-can copied and use
> devm_gpio_request_one instead.  Do you want me to add STBY gpio
> support into my patch?
>   
Yes.

Thanks,
Hui.
> Regards,
> Shawn
>
>   

