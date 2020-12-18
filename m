Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430F8C4361B
	for <linux-can@archiver.kernel.org>; Fri, 18 Dec 2020 08:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 053A7233F6
	for <linux-can@archiver.kernel.org>; Fri, 18 Dec 2020 08:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgLRIvf (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 18 Dec 2020 03:51:35 -0500
Received: from first.geanix.com ([116.203.34.67]:33766 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbgLRIvf (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 18 Dec 2020 03:51:35 -0500
Received: from [IPv6:2a06:4004:10df:1:da27:a6d2:5305:fd0a] (_gateway [172.21.0.1])
        by first.geanix.com (Postfix) with ESMTPSA id 69D08486991;
        Fri, 18 Dec 2020 08:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1608281452; bh=wVVk77WcN9aRvhujySLoMbK4DtKPHnQx/Pr/qH7GecU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Zl3eORZIuG+kIkImiHaWgarjri+Sdqm+eItlJHLG5zr0DpaZL/PAG9gTvbnPY98cd
         bVvgonswEaGleLevC+HjJeJn7qv4xrCD4vsAfmro5RpU1TBCyOQFph/pjN5Hnt+drt
         UsvgYHjAXhA+JfwecQktiLaY5sF0RZEbT++dIQQ1SQ1NKeZTgYMyugiTZYCSuIBt/D
         cEwJH6XYiZAMxbDBxeURxJiqKGy5qhCVJQnB6/3+HzdKd7EXZwBuEOb9DhdlIRdelj
         wBLHF0EzhzCdmPimOdLVbLZoYJN8+EhoBlCjnURE9+TW2bavggDS6/JRweHTRUgO4q
         5u0LBF2K+lFDg==
Subject: Re: [RFC]: tcan4x5x: rework regmap support
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Sriram Dash <sriram.dash@samsung.com>
References: <20201215231746.1132907-1-mkl@pengutronix.de>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <87235fa0-a72d-dd90-de5d-714ea8a97441@geanix.com>
Date:   Fri, 18 Dec 2020 09:50:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201215231746.1132907-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 16/12/2020 00.17, Marc Kleine-Budde wrote:
> Hello,
>
> this series first cleans up the the SPI regmap and then fixes several problem:
> - tcan4x5x_regmap_gather_write(), tcan4x5x_regmap_read():
>    Do not place variable "addr" on stack and use it as buffer for SPI
>    transfer. Buffers for SPI transfers must be allocated from DMA save
>    memory.
> - tcan4x5x_regmap_gather_write(), tcan4x5x_regmap_read():
>    Halfe number of SPI transfers by using a single buffer + memcpy().
>    This improves the performance, especially on SPI controllers, which
>    use interrupt based transfers.
> - Use "8" bits per word, not "32". This makes it possible to use this
>    driver on SoCs like the Raspberry Pi, which SPI host controller
>    drivers only support 8 bits per word.
>
> With this series, the driver is able to detect a tcan4x5x on a Raspberry Pi.
>
> regards,
> Marc
>
For this series...

Tested-by: Sean Nyekjaer <sean@geanix.com>

/Sean
