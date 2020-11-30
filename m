Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188A7C64E8A
	for <linux-can@archiver.kernel.org>; Mon, 30 Nov 2020 13:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD0B0206D8
	for <linux-can@archiver.kernel.org>; Mon, 30 Nov 2020 13:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pU2rJyw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgK3Nmh (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 30 Nov 2020 08:42:37 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41770 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgK3Nmh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 30 Nov 2020 08:42:37 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AUDesWA094513;
        Mon, 30 Nov 2020 07:40:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1606743654;
        bh=qGnpxmWjDbXlfDGwhJxneOWfwCXjaHmcwH0B3TNhwpo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pU2rJyw+w65Ii+jaL6JlkYjWiiQ84UfUyQ5r8AKQIjxEGTIwJ211113txptvQVbZU
         rqW5Z4afKFvZAHIko/xFdceujd/lJi8/CFc4CBG9qHSkEyMAlEfevHAGNXrKFI08El
         iF9xRStoduZ9VACrrdBBjWUdpkGXW239UBXHh8Go=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AUDesKl093666
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Nov 2020 07:40:54 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 30
 Nov 2020 07:40:54 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 30 Nov 2020 07:40:54 -0600
Received: from [10.250.40.192] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AUDesmL096029;
        Mon, 30 Nov 2020 07:40:54 -0600
Subject: Re: [net-next 0/6] can: tcan4x5x: various cleanups
To:     Marc Kleine-Budde <mkl@pengutronix.de>, <linux-can@vger.kernel.org>
CC:     Sriram Dash <sriram.dash@samsung.com>
References: <20201130133713.269256-1-mkl@pengutronix.de>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <c5f1dd85-ff2f-dd08-fc26-3d9b1ad79e2d@ti.com>
Date:   Mon, 30 Nov 2020 07:40:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201130133713.269256-1-mkl@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Marc

On 11/30/20 7:37 AM, Marc Kleine-Budde wrote:
> Hello,
>
> this is a small series of various cleanups for the tcan4x5x and m_can driver.
>
> regards,
> Marc
>
>
>
For the series

Reviewed-by: Dan Murphy <dmurphy@ti.com>

