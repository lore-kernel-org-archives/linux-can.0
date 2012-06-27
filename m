From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 4/4] can: flexcan: add transceiver switch support when use
 device tree
Date: Wed, 27 Jun 2012 19:22:04 +0800
Message-ID: <CAAQ0ZWSOJog+S3780wD63ObJ6YUfC9T_zOUPzto3esF-W4fnXw@mail.gmail.com>
References: <1340785161-3598-1-git-send-email-jason77.wang@gmail.com>
	<1340785161-3598-2-git-send-email-jason77.wang@gmail.com>
	<1340785161-3598-3-git-send-email-jason77.wang@gmail.com>
	<1340785161-3598-4-git-send-email-jason77.wang@gmail.com>
	<1340785161-3598-5-git-send-email-jason77.wang@gmail.com>
	<4FEAC3AA.500@pengutronix.de>
	<4FEAD897.5070408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:56060 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605Ab2F0LWG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Jun 2012 07:22:06 -0400
Received: by lbbgm6 with SMTP id gm6so1488710lbb.19
        for <linux-can@vger.kernel.org>; Wed, 27 Jun 2012 04:22:04 -0700 (PDT)
In-Reply-To: <4FEAD897.5070408@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Hui Wang <jason77.wang@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, davem@davemloft.net, linux-can@vger.kernel.org

On 27 June 2012 17:55, Hui Wang <jason77.wang@gmail.com> wrote:
> After read and compared with his patch:
> 1. Shawn use gpio_is_valid(gpio) instead of (gpio >= 0), it is good.
> 2. Shawn add a flag to record active level, it is good.
> 3. Shawn only add 1 gpio, this is not enough for imx6 sabre lite board.
> 4. Shawn forget to call gpio_release()

I'm about to resend my series to have linux-can copied and use
devm_gpio_request_one instead.  Do you want me to add STBY gpio
support into my patch?

Regards,
Shawn
