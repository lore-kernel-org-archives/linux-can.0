Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1186AC2BBCA
	for <linux-can@archiver.kernel.org>; Mon, 14 Dec 2020 08:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBB6522838
	for <linux-can@archiver.kernel.org>; Mon, 14 Dec 2020 08:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439103AbgLNINR (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 14 Dec 2020 03:13:17 -0500
Received: from first.geanix.com ([116.203.34.67]:57778 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439095AbgLNINL (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 14 Dec 2020 03:13:11 -0500
Received: from [IPv6:2a06:4004:10df:1:da27:a6d2:5305:fd0a] (_gateway [172.21.0.1])
        by first.geanix.com (Postfix) with ESMTPSA id 73A6E485B36;
        Mon, 14 Dec 2020 08:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1607933548; bh=ZOD/anCgzE+7jDuKDrizr1tdw17Hdje0bl016cnbhug=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bTKfAVOtNHtoENwafyuz550sQiUX/W8DWObGt+5RUyKtsa4fWBBE2JK1WFMYdJTMV
         WOjjaRyNuBIgML1xDYq5o26g3AvIZZvotYEqxw+7ua9RpbVm1H/6axBIyVEfulHd1i
         8jIKIq8j4c22URrlIfq6HmXnQaxBg9EwMXaQtZO59N+UOJWVM9e58+zVS1Wsg7/vG3
         cz0VduKIErE3pXrh/FoEJGwJ7Dd8HtsXno8rAt/gKI6P6gExsEeFhKtkQbXz3xWr7y
         h/iPO8WpAhXdOKZk97a7xyWWFk4JNetVmDBrQZy5YHFfY9yl/1tPikitlLv1Tf8b8j
         wo9tbcbAy/PgQ==
Subject: Re: [can-next-rfc 4/7] can: m_can: m_can_config_endisable(): mark as
 static
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Sriram Dash <sriram.dash@samsung.com>
References: <20201212175518.139651-1-mkl@pengutronix.de>
 <20201212175518.139651-5-mkl@pengutronix.de>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <ab910ad6-8976-0a17-e5cf-6d4fa9b9c0e4@geanix.com>
Date:   Mon, 14 Dec 2020 09:12:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201212175518.139651-5-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 12/12/2020 18.55, Marc Kleine-Budde wrote:
> The function m_can_config_endisable() is not used outside of the m_can driver,
> so mark it as static.
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   drivers/net/can/m_can/m_can.c | 2 +-
>   drivers/net/can/m_can/m_can.h | 1 -
>   2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index fb408ca85188..b1ed925ead63 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -368,7 +368,7 @@ static inline bool m_can_tx_fifo_full(struct m_can_classdev *cdev)
>   	return !!(m_can_read(cdev, M_CAN_TXFQS) & TXFQS_TFQF);
>   }
>   
> -void m_can_config_endisable(struct m_can_classdev *cdev, bool enable)
> +static void m_can_config_endisable(struct m_can_classdev *cdev, bool enable)
>   {
>   	u32 cccr = m_can_read(cdev, M_CAN_CCCR);
>   	u32 timeout = 10;
> diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
> index f8a692596e59..3994e20249f8 100644
> --- a/drivers/net/can/m_can/m_can.h
> +++ b/drivers/net/can/m_can/m_can.h
> @@ -103,7 +103,6 @@ int m_can_class_register(struct m_can_classdev *cdev);
>   void m_can_class_unregister(struct m_can_classdev *cdev);
>   int m_can_class_get_clocks(struct m_can_classdev *cdev);
>   void m_can_init_ram(struct m_can_classdev *priv);
> -void m_can_config_endisable(struct m_can_classdev *priv, bool enable);
>   
>   int m_can_class_suspend(struct device *dev);
>   int m_can_class_resume(struct device *dev);

